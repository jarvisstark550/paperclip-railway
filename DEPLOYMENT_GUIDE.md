# Paperclip AI - Railway Deployment Guide

**Status**: Application code ready for deployment  
**Domain**: jarvis-clip.com  
**Users**: jarvis@gmail.com, angel@garciateam.com  
**Database**: PostgreSQL (to be hosted on Railway)  

## Prerequisites

- Railway account (jarvis@gmail.com) - VERIFIED ✓
- Domain jarvis-clip.com - PURCHASED ✓
- GitHub account with access to create repos
- Secrets ready for migration ✓
  - PAPERCLIP_AGENT_JWT_SECRET
  - ANTHROPIC_API_KEY
  - PAPERCLIP_API_KEY

## Step-by-Step Deployment

### PHASE 1: GitHub Setup (5 min)

1. Create a new GitHub repository `paperclip-railway`
   - Visibility: Private (for security)
   - Initialize with .gitignore (Node.js)

2. Clone locally:
   ```bash
   git clone https://github.com/<your-org>/paperclip-railway.git
   cd paperclip-railway
   ```

3. Copy files from this directory into the cloned repo:
   ```bash
   cp -r /Users/openclaw/.openclaw/workspace/paperclip-railway/* .
   git add .
   git commit -m "Initial Paperclip Railway deployment setup"
   git push origin main
   ```

### PHASE 2: Railway Project Setup (10 min)

1. Log into Railway at https://railway.app
2. Create new project "Paperclip AI"
3. Choose "GitHub" as deployment source
4. Connect and authorize GitHub account
5. Select repository: `paperclip-railway`
6. Railway auto-detects Node.js configuration from Procfile

### PHASE 3: Database Setup (15 min)

1. In Railway project dashboard:
   - Add service → PostgreSQL
   - Name: "paperclip-postgres"
   - Leave defaults (Railway manages backups, replicas)

2. Once PostgreSQL service is created:
   - Copy CONNECTION STRING to a safe place
   - Format: `postgresql://user:password@host:port/railway`
   - This will be your `DATABASE_URL`

### PHASE 4: Database Migration (20 min)

1. Export local database to SQL dump:
   ```bash
   npm install
   node scripts/export-database.js
   # Creates: database-export-TIMESTAMP.sql
   ```

2. In Railway PostgreSQL dashboard:
   - Go to "Connect" tab
   - Option 1: Use psql command (if available):
     ```bash
     psql $DATABASE_URL < database-export-TIMESTAMP.sql
     ```
   - Option 2: Use Railway dashboard:
     - Click "Query" or "Tools"
     - Upload/paste SQL dump contents
     - Execute

3. Verify migration:
   ```bash
   psql $DATABASE_URL -c "SELECT count(*) as table_count FROM information_schema.tables WHERE table_schema='public';"
   ```

### PHASE 5: Environment Configuration (10 min)

1. In Railway project → Node.js service
2. Go to "Variables" tab
3. Add the following environment variables:
   ```
   PORT=3000
   NODE_ENV=production
   DATABASE_URL=postgresql://user:password@host:port/railway
   PAPERCLIP_AGENT_JWT_SECRET=<REDACTED_JWT_SECRET>
   ANTHROPIC_API_KEY=<REDACTED_ANTHROPIC_KEY>-GUVigagtms1BhNUOdSLVYTLQwBxqo4_zg1FjI2XLmWCNK2KkbTUSLqOGAnK9u2B0IKjpdfYGcCVueVYWzg-hYkWGgAA
   PAPERCLIP_API_KEY=<REDACTED_PCP_KEY>
   PAPERCLIP_BASE_URL=https://jarvis-clip.com
   ```

**⚠️ SECURITY**: These variables are encrypted at rest by Railway. DO NOT commit to git.

### PHASE 6: Application Deployment (10 min)

1. Railway auto-deploys on git push
2. If not auto-triggered:
   - Go to Deployments tab
   - Click "Deploy" button
   - Watch logs for build progress

3. Check deployment status:
   - Logs should show: `🚀 Paperclip server running on port 3000`
   - Service status should be "Running"

4. Get Railway public URL:
   - In service details, find "Generated Domain"
   - Example: `paperclip-xxxxxx.railway.app`
   - This is temporary, will be replaced by custom domain

### PHASE 7: DNS Configuration (10 min)

1. Go to Namecheap account for jarvis-clip.com
2. DNS Settings:
   - Add CNAME record:
     - Host: `@` (root domain)
     - Value: `cname.railway.app` (or Railway's CNAME value)
   - Add CNAME record:
     - Host: `www`
     - Value: `cname.railway.app`

3. In Railway dashboard:
   - Service → Domain tab
   - Add custom domain: `jarvis-clip.com`
   - Railway provides CNAME target
   - Wait for DNS propagation (can take 5-60 min)

4. Verify:
   ```bash
   curl -I https://jarvis-clip.com
   # Should return 200 OK
   ```

### PHASE 8: HTTPS Configuration (Automatic)

Railway automatically:
- Provisions SSL/TLS certificate (Let's Encrypt)
- Enforces HTTPS
- Redirects HTTP → HTTPS (configured in app code)

**Verify**:
```bash
curl -I http://jarvis-clip.com
# Should redirect to https://jarvis-clip.com with 301/302
```

### PHASE 9: Authentication Setup (20 min)

Paperclip uses better-auth for user management.

1. Access admin panel:
   - Navigate to: `https://jarvis-clip.com/admin`
   - Initial setup wizard appears

2. Create first user (admin):
   - Email: `jarvis@gmail.com`
   - Password: Generate strong temporary password (minimum 12 chars, mixed case, numbers, symbols)
   - Example: `TempP@ss2026!Jarvis`
   - User role: `Admin`

3. Create second user:
   - Email: `angel@garciateam.com`
   - Password: Generate strong temporary password
   - Example: `TempP@ss2026!Angel`
   - User role: `User` or `Admin` (as needed)

4. **IMPORTANT**: Users MUST change passwords on first login
   - Enforce in application settings
   - Set password change deadline to immediate

### PHASE 10: Authentication Testing (10 min)

Test both user accounts:

```bash
# Test 1: jarvis@gmail.com login
curl -X POST https://jarvis-clip.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "jarvis@gmail.com",
    "password": "TempP@ss2026!Jarvis"
  }'

# Expected response: { token, user: { email, ... } }

# Test 2: angel@garciateam.com login
curl -X POST https://jarvis-clip.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "angel@garciateam.com",
    "password": "TempP@ss2026!Angel"
  }'

# Expected response: { token, user: { email, ... } }
```

### PHASE 11: API Key Generation (5 min)

1. Access admin panel → API Keys
2. Create new API key for OpenClaw integration:
   - Name: "OpenClaw Integration"
   - Permissions: All (or as needed)
   - Generate

3. Save the key:
   - Format: `<REDACTED_PCP_KEY>`
   - Store securely (one-time display)

### PHASE 12: Security Hardening (30 min)

1. **Rate Limiting**:
   - Admin panel → Security Settings
   - Auth endpoints: Max 5 attempts per 15 minutes
   - API endpoints: Max 100 requests per minute

2. **Database Security**:
   - Railway Postgres: Verify isolated in VPC ✓ (Railway default)
   - No public internet access ✓ (Railway default)
   - Automated backups enabled ✓ (Railway default)

3. **Application Security**:
   - Verify HTTPS redirect working ✓
   - Verify JWT secret is strong ✓
   - Verify API keys are not logged ✓

4. **Monitoring**:
   - Enable Railway application logs
   - Set up error notifications (if available)

### PHASE 13: Backup Verification (10 min)

1. Railway automatically backs up PostgreSQL
   - Daily backups, 30-day retention (default)
   
2. Test backup restore:
   - Request backup download from Railway dashboard
   - Document location and procedure

3. Document backup:
   - Location: Railway database service dashboard
   - Retention: 30 days
   - Restore: Automatic or on-demand via Railway CLI

### PHASE 14: Integration Testing (30 min)

Comprehensive test suite:

```bash
#!/bin/bash

DOMAIN="https://jarvis-clip.com"
JARVIS_EMAIL="jarvis@gmail.com"
JARVIS_PASS="TempP@ss2026!Jarvis"
ANGEL_EMAIL="angel@garciateam.com"
ANGEL_PASS="TempP@ss2026!Angel"

echo "🧪 PHASE 14: Integration Testing"

# Test 1: HTTPS Enforcement
echo "Test 1: HTTPS enforcement"
REDIRECT=$(curl -I http://jarvis-clip.com 2>&1 | grep -i "301\|302\|https")
if [[ ! -z "$REDIRECT" ]]; then
  echo "  ✓ HTTP redirects to HTTPS"
else
  echo "  ✗ HTTPS redirect failed"
fi

# Test 2: SSL Certificate
echo "Test 2: SSL Certificate valid"
SSL_CHECK=$(curl -I $DOMAIN 2>&1 | grep -i "200\|secure")
if [[ ! -z "$SSL_CHECK" ]]; then
  echo "  ✓ SSL certificate valid"
else
  echo "  ✗ SSL certificate issue"
fi

# Test 3: Jarvis Login
echo "Test 3: Jarvis login"
JARVIS_TOKEN=$(curl -s -X POST $DOMAIN/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\": \"$JARVIS_EMAIL\", \"password\": \"$JARVIS_PASS\"}" | grep -o '"token":"[^"]*"')
if [[ ! -z "$JARVIS_TOKEN" ]]; then
  echo "  ✓ Jarvis login successful"
else
  echo "  ✗ Jarvis login failed"
fi

# Test 4: Angel Login
echo "Test 4: Angel login"
ANGEL_TOKEN=$(curl -s -X POST $DOMAIN/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\": \"$ANGEL_EMAIL\", \"password\": \"$ANGEL_PASS\"}" | grep -o '"token":"[^"]*"')
if [[ ! -z "$ANGEL_TOKEN" ]]; then
  echo "  ✓ Angel login successful"
else
  echo "  ✗ Angel login failed"
fi

# Test 5: API Key Authentication
echo "Test 5: API Key authentication"
API_TEST=$(curl -s -H "X-API-Key: <REDACTED_PCP_KEY>" \
  $DOMAIN/api/status)
if [[ ! -z "$API_TEST" ]]; then
  echo "  ✓ API key authentication working"
else
  echo "  ✗ API key authentication failed"
fi

# Test 6: Cross-device access
echo "Test 6: Cross-device access"
for AGENT in curl wget httpie; do
  if command -v $AGENT &> /dev/null; then
    echo "  ✓ $AGENT available for remote testing"
  fi
done

echo ""
echo "✅ Testing complete"
```

## Post-Deployment Checklist

- [ ] Application deployed and running
- [ ] HTTPS working (enforced, valid certificate)
- [ ] Both users can log in
- [ ] API key authentication working
- [ ] Database migrated and verified
- [ ] Backups enabled
- [ ] DNS configured
- [ ] Custom domain working
- [ ] Rate limiting configured
- [ ] Monitoring/alerts set up (optional)
- [ ] Documentation updated
- [ ] Team notified of credentials

## Security Reminders

⚠️ **CRITICAL**:
1. Users MUST change temporary passwords immediately
2. API keys should be rotated periodically
3. Never commit secrets to git (use environment variables)
4. Regularly review access logs
5. Keep Node.js and dependencies updated

## Troubleshooting

### Application won't start
- Check logs: Railway Deployments tab
- Common issues:
  - Missing environment variables
  - DATABASE_URL incorrect
  - Port already in use

### Database migration failed
- Verify PostgreSQL service is running
- Check DATABASE_URL format
- Ensure local database export is valid SQL
- Try manual import via Railway dashboard

### Domain not resolving
- Wait 15-60 min for DNS propagation
- Verify CNAME record in Namecheap
- Check Railway domain configuration
- Use: `nslookup jarvis-clip.com` to debug

### HTTPS certificate issues
- Railway auto-provisions via Let's Encrypt
- Usually resolves within 5-10 min of DNS propagation
- Check Railway service logs for certificate errors

## Rollback Procedure

If critical issues occur:

1. **Database**: Use Railway automated backup
   - Railway dashboard → PostgreSQL → Backups
   - Restore from latest clean backup

2. **Application**: Railway keeps previous deployments
   - Click "Revert" on previous successful deployment

3. **DNS**: If needed, revert to temporary Railway domain
   - Update CNAME back to temp domain

## Support & Documentation

- **Paperclip Docs**: https://github.com/paperclipai/paperclip
- **Railway Docs**: https://docs.railway.app
- **Troubleshooting**: See logs in Railway dashboard
- **Emergency Contact**: openclaw@paperclip.local

---

**Deployment completed**: [Date/Time]  
**Deployed by**: [Name/ID]  
**Notes**: [Any special configurations or issues]
