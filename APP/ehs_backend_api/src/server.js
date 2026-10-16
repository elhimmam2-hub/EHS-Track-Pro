const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
require('dotenv').config();

const apiRoutes = require('./routes/api.routes');

const app = express();
const PORT = process.env.PORT || 5000;

// Security & Middlewares
app.use(helmet());
app.use(cors({ origin: '*' }));
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ extended: true, limit: '50mb' }));
app.use(morgan('dev'));

// Static uploads directory (for media & signed PDFs)
app.use('/uploads', express.static('uploads'));

// API Routes
app.use('/api/v1', apiRoutes);

// Root Welcome
app.get('/', (req, res) => {
  res.json({
    app: 'EHS Track Pro API',
    description: 'Enterprise REST Backend for Occupational Safety, Health & Environment Management',
    docs: '/api/v1/health',
    status: 'online',
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('[SERVER ERROR]', err);
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Internal Server Error',
  });
});

app.listen(PORT, () => {
  console.log(`====================================================`);
  console.log(`🛡️  EHS Track Pro Backend running on port ${PORT}`);
  console.log(`📡 Health endpoint: http://localhost:${PORT}/api/v1/health`);
  console.log(`====================================================`);
});
