const express = require('express');
const router = express.Router();

const { authenticateToken } = require('../middleware/auth');
const { authorizeRoles } = require('../middleware/rbac');

const { getAllIncidents, createIncident, getDashboardKPIs } = require('../controllers/incident.controller');
const { getAllCAPAs, createCAPA, closeCAPA } = require('../controllers/capa.controller');
const { processDeltaSync } = require('../controllers/sync.controller');

// 1. Health check & Public status
router.get('/health', (req, res) => {
  res.json({ status: 'healthy', version: '2.4.0', timestamp: new Date().toISOString() });
});

// 2. Offline-first Delta Synchronization (Any authenticated field user)
router.post('/sync/delta', authenticateToken, processDeltaSync);

// 3. Incidents & Hazard reporting
router.get('/incidents', authenticateToken, getAllIncidents);
router.post(
  '/incidents',
  authenticateToken,
  authorizeRoles('field_worker', 'site_supervisor', 'safety_inspector', 'ehs_manager'),
  createIncident
);

// 4. CAPA (Corrective & Preventive Actions)
router.get('/capas', authenticateToken, getAllCAPAs);
router.post(
  '/capas',
  authenticateToken,
  authorizeRoles('site_supervisor', 'safety_inspector', 'ehs_manager'),
  createCAPA
);
router.patch(
  '/capas/:id/close',
  authenticateToken,
  authorizeRoles('safety_inspector', 'ehs_manager'),
  closeCAPA
);

// 5. KPIs & Analytics Dashboard
router.get('/dashboard/kpis', authenticateToken, getDashboardKPIs);

module.exports = router;
