import dotenv from 'dotenv';
import express from 'express';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Middleware for redirecting HTTP to HTTPS in production
if (process.env.NODE_ENV === 'production') {
  app.use((req, res, next) => {
    if (req.header('x-forwarded-proto') !== 'https') {
      res.redirect(`https://${req.header('host')}${req.url}`);
    } else {
      next();
    }
  });
}

// Basic health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'Paperclip server is running' });
});

// Start server
app.listen(port, () => {
  console.log(`Paperclip server running on port ${port}`);
  console.log(`Base URL: ${process.env.PAPERCLIP_BASE_URL || `http://localhost:${port}`}`);
});
