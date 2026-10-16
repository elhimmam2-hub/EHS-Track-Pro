const db = require('../config/db');

/**
 * Two-way Offline Delta Sync Controller
 * 1. Pulls client mutations (Outbox from mobile device)
 * 2. Applies idempotent updates to PostgreSQL
 * 3. Returns changes generated on the server since client's last_sync_time
 */
async function processDeltaSync(req, res) {
  const client = await db.pool.connect();
  const { device_id, last_sync_timestamp, mutations } = req.body;
  const userId = req.user.id;

  try {
    await client.query('BEGIN');

    const processedMutationIds = [];

    // 1. Ingest mobile device mutations
    if (Array.isArray(mutations) && mutations.length > 0) {
      for (const mut of mutations) {
        const { mutation_id, entity_name, entity_id, operation, payload, created_at } = mut;

        // Record in sync delta journal
        await client.query(
          `INSERT INTO sync_deltas (user_id, device_id, entity_name, entity_id, operation, payload, client_timestamp)
           VALUES ($1, $2, $3, $4, $5, $6, $7)`,
          [userId, device_id, entity_name, entity_id, operation, payload, created_at]
        );

        // Apply entity updates
        if (entity_name === 'incidents' && operation === 'UPSERT') {
          await client.query(
            `INSERT INTO incidents (id, type, title, description, severity_level, site_location, reporter_id, created_at)
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
             ON CONFLICT (id) DO UPDATE SET
               title = EXCLUDED.title,
               description = EXCLUDED.description,
               severity_level = EXCLUDED.severity_level,
               updated_at = NOW()`,
            [
              entity_id,
              payload.type || 'near_miss',
              payload.title,
              payload.description,
              payload.severity_level || 1,
              payload.site_location || 'Unknown Site',
              userId,
              created_at || new Date().toISOString(),
            ]
          );
        } else if (entity_name === 'capas' && operation === 'UPSERT') {
          await client.query(
            `INSERT INTO capas (id, incident_id, action_title, assignee_name, deadline, status, priority, created_at)
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
             ON CONFLICT (id) DO UPDATE SET
               status = EXCLUDED.status,
               updated_at = NOW()`,
            [
              entity_id,
              payload.incident_id,
              payload.action_title,
              payload.assignee_name,
              payload.deadline,
              payload.status || 'in_progress',
              payload.priority || 'medium',
              created_at || new Date().toISOString(),
            ]
          );
        }

        processedMutationIds.push(mutation_id);
      }
    }

    // 2. Fetch server updates since last client sync
    const lastSyncDate = last_sync_timestamp ? new Date(last_sync_timestamp) : new Date(0);
    const updatedIncidents = await client.query(
      `SELECT * FROM incidents WHERE updated_at > $1`,
      [lastSyncDate]
    );

    const updatedCAPAs = await client.query(
      `SELECT * FROM capas WHERE updated_at > $1`,
      [lastSyncDate]
    );

    await client.query('COMMIT');

    return res.status(200).json({
      success: true,
      synced_at: new Date().toISOString(),
      acknowledged_mutations: processedMutationIds,
      server_deltas: {
        incidents: updatedIncidents.rows,
        capas: updatedCAPAs.rows,
      },
    });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('[SYNC ERROR]', error);
    return res.status(500).json({
      success: false,
      message: 'Failed to process offline delta sync batch.',
      error: error.message,
    });
  } finally {
    client.release();
  }
}

module.exports = { processDeltaSync };
