# Paperclip AI - Railway Deployment

Production deployment of Paperclip AI Agent Orchestration platform on Railway.

## Configuration

- **Domain**: jarvis-clip.com
- **Users**: 
  - jarvis@gmail.com
  - angel@garciateam.com
- **Database**: Railway-managed PostgreSQL
- **Storage**: Local disk (configurable)
- **Secrets**: Railway environment variables

## Deployment Steps

1. Push this repository to GitHub
2. Create Railway project and link GitHub repo
3. Set up Railway Postgres service
4. Configure environment variables
5. Deploy application
6. Configure DNS
7. Enable HTTPS (automatic with Railway)

## Environment Variables

See `.env.example` for all required variables.

Key variables:
- `DATABASE_URL`: PostgreSQL connection string (set by Railway)
- `PAPERCLIP_AGENT_JWT_SECRET`: JWT secret for authentication
- `ANTHROPIC_API_KEY`: Claude API key
- `PAPERCLIP_API_KEY`: Internal API key

## Security

- HTTPS enforced in production
- Strong password requirements enforced
- Database isolated in VPC
- Regular backups enabled
- API authentication required

## Support

For issues, contact: openclaw@paperclip.local
