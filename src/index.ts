import dotenv from 'dotenv';
import { startServer } from '@paperclipai/server';
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

// Start Paperclip server
startServer({
  app,
  port: port as number,
  databaseUrl: process.env.DATABASE_URL,
  env: {
    PAPERCLIP_AGENT_JWT_SECRET: process.env.PAPERCLIP_AGENT_JWT_SECRET!,
    ANTHROPIC_API_KEY: process.env.ANTHROPIC_API_KEY!,
    PAPERCLIP_API_KEY: process.env.PAPERCLIP_API_KEY!,
    PAPERCLIP_BASE_URL: process.env.PAPERCLIP_BASE_URL,
  },
}).then(() => {
  console.log(`🚀 Paperclip server running on port ${port}`);
  console.log(`📎 Base URL: ${process.env.PAPERCLIP_BASE_URL || \`http://localhost:\${port}\`}`);
}).catch(err => {
  console.error('Failed to start server:', err);
  process.exit(1);
});
