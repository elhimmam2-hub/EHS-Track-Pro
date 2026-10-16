const db = require('../config/db');

async function getAllCAPAs(req, res) {
  try {
    const { rows } = await db.query(`SELECT * FROM capas ORDER BY created_at DESC`);
    return res.status(200).json({ success: true, count: rows.length, data: rows });
  } catch (err) {
    return res.status(500).json({ success: false, message: err.message });
  }
}

async function createCAPA(req, res) {
  const { incident_id, action_title, assignee_name, deadline, priority } = req.body;
  const capaId = `CAPA-2026-${Math.floor(100 + Math.random() * 900)}`;

  try {
    const { rows } = await db.query(
      `INSERT INTO capas (id, incident_id, action_title, assignee_name, deadline, priority, status)
       VALUES ($1, $2, $3, $4, $5, $6, 'assigned')
       RETURNING *`,
      [capaId, incident_id, action_title, assignee_name, deadline, priority || 'medium']
    );
    return res.status(201).json({ success: true, data: rows[0] });
  } catch (err) {
    return res.status(500).json({ success: false, message: err.message });
  }
}

async function closeCAPA(req, res) {
  const { id } = req.params;
  const verifiedBy = req.user.id;

  try {
    const { rows } = await db.query(
      `UPDATE capas
       SET status = 'closed', closed_at = NOW(), verified_by = $1, updated_at = NOW()
       WHERE id = $2
       RETURNING *`,
      [verifiedBy, id]
    );

    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: 'CAPA action not found.' });
    }

    return res.status(200).json({ success: true, data: rows[0] });
  } catch (err) {
    return res.status(500).json({ success: false, message: err.message });
  }
}

module.exports = { getAllCAPAs, createCAPA, closeCAPA };
