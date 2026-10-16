/**
 * Role-Based Access Control (RBAC) Guard Middleware
 * Restricts route execution based on allowed roles.
 */
function authorizeRoles(...allowedRoles) {
  return (req, res, next) => {
    if (!req.user || !req.user.role) {
      return res.status(403).json({
        success: false,
        message: 'Forbidden. No role identified in session context.',
      });
    }

    if (!allowedRoles.includes(req.user.role)) {
      return res.status(403).json({
        success: false,
        message: `Forbidden. Role '${req.user.role}' lacks sufficient privileges for this operational resource.`,
      });
    }

    next();
  };
}

module.exports = { authorizeRoles };
