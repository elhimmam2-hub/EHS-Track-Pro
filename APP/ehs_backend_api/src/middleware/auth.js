const jwt = require('jsonwebtoken');

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({
      success: false,
      message: 'Access denied. Missing bearer token.',
    });
  }

  const secret = process.env.JWT_SECRET || 'ehs_track_pro_super_secret_jwt_key_2026';

  jwt.verify(token, secret, (err, user) => {
    if (err) {
      return res.status(403).json({
        success: false,
        message: 'Invalid or expired token.',
      });
    }
    req.user = user;
    next();
  });
}

module.exports = { authenticateToken };
