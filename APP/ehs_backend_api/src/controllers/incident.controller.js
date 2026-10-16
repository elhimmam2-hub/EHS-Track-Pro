const db = require('../config/db');

async function getAllIncidents(req, res) {
  try {
    const { rows } = await db.query(
      `SELECT i.*, u.full_name as reporter_name
       FROM incidents i
       LEFT JOIN users u ON i.reporter_id = u.id
       ORDER BY i.created_at DESC`
    );
    return res.status(200).json({ success: true, count: rows.length, data: rows });
  } catch (err) {
    return res.status(500).json({ success: false, message: err.message });
  }
}

async function createIncident(req, res) {
  const { id, type, title, description, severity_level, site_location, latitude, longitude } = req.body;
  const reporterId = req.user.id;

  try {
    const incidentId = id || `INC-2026-${Math.floor(100 + Math.random() * 900)}`;
    const { rows } = await db.query(
      `INSERT INTO incidents (id, type, title, description, severity_level, site_location, latitude, longitude, reporter_id)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
       RETURNING *`,
      [incidentId, type, title, description, severity_level || 1, site_location, latitude, longitude, reporterId]
    );

    // Write audit log
    await db.query(
      `INSERT INTO audit_logs (user_id, action, entity, entity_id, details)
       VALUES ($1, 'CREATE_INCIDENT', 'incidents', $2, $3)`,
      [reporterId, incidentId, JSON.stringify({ type, severity_level })]
    );

    return res.status(201).json({ success: true, data: rows[0] });
  } catch (err) {
    return res.status(500).json({ success: false, message: err.message });
  }
}

async function getDashboardKPIs(req, res) {
  try {
    // 1. LTIFR Calculation (Mock total man-hours worked = 1,000,000)
    const ltiCountRes = await db.query(
      `SELECT COUNT(*) FROM incidents WHERE type = 'lost_time_injury'`
    );
    const ltiCount = parseInt(ltiCountRes.rows[0].count, 10);
    const totalManHours = 1000000;
    const ltifr = ((ltiCount * 1000000) / totalManHours).toFixed(2);

    // 2. Open vs Closed CAPAs
    const capaStatsRes = await db.query(
      `SELECT 
         COUNT(*) as total,
         COUNT(*) FILTER (WHERE status = 'closed') as closed,
         COUNT(*) FILTER (WHERE status = 'in_progress') as in_progress
       FROM capas`
    );

    return res.status(200).json({
      success: true,
      kpis: {
        ltifr: parseFloat(ltifr),
        ltifr_benchmark: 0.50,
        compliance_score: 96.4,
        safe_man_hours: 1840000,
        capa_summary: capaStatsRes.rows[0],
      },
    });
  } catch (err) {
    return res.status(500).json({ success: false, message: err.message });
  }
}

module.exports = { getAllIncidents, createIncident, getDashboardKPIs };
