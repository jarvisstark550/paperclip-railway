#!/bin/bash

# Automated Railway Deployment Script
# This script will deploy the Paperclip application to Railway
# Requires: Valid RAILWAY_TOKEN set in environment

set -e

echo "🚀 Starting Paperclip Railway Deployment"
echo "========================================="

# Configuration
RAILWAY_TOKEN="${RAILWAY_TOKEN:-}"
PROJECT_NAME="paperclip-railway"
SERVICE_NAME="paperclip"
DB_SERVICE_NAME="paperclip-postgres"
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOMAIN="jarvis-clip.com"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Utility functions
log_info() {
    echo -e "${GREEN}ℹ️  $1${NC}"
}

log_warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check prerequisites
log_info "Checking prerequisites..."

if [ -z "$RAILWAY_TOKEN" ]; then
    log_error "RAILWAY_TOKEN not set. Please export RAILWAY_TOKEN before running this script."
    exit 1
fi

if ! command -v npx &> /dev/null; then
    log_error "npx not found. Please install Node.js"
    exit 1
fi

log_info "Prerequisites OK"

# Step 1: Build application
log_info "Step 1: Building application..."
cd "$APP_DIR"
npm run build
log_info "Build complete"

# Step 2: Initialize Railway project
log_info "Step 2: Initializing Railway project..."
npx @railway/cli@latest init --name "$PROJECT_NAME" || {
    log_warn "Project might already exist, attempting to link..."
    npx @railway/cli@latest link --projectId "$(npx @railway/cli@latest list --json | jq -r ".[] | select(.name==\"$PROJECT_NAME\") | .id")" || true
}

# Step 3: Create PostgreSQL service
log_info "Step 3: Creating PostgreSQL service..."
npx @railway/cli@latest add --service postgres || log_warn "PostgreSQL service might already exist"

# Step 4: Set environment variables
log_info "Step 4: Setting environment variables..."
VARS=(
    "NODE_ENV=production"
    "PORT=3000"
    "PAPERCLIP_AGENT_JWT_SECRET=<REDACTED_JWT_SECRET>"
    "ANTHROPIC_API_KEY=<REDACTED_ANTHROPIC_KEY>-GUVigagtms1BhNUOdSLVYTLQwBxqo4_zg1FjI2XLmWCNK2KkbTUSLqOGAnK9u2B0IKjpdfYGcCVueVYWzg-hYkWGgAA"
    "PAPERCLIP_API_KEY=<REDACTED_PCP_KEY>"
    "PAPERCLIP_BASE_URL=https://$DOMAIN"
)

for var in "${VARS[@]}"; do
    npx @railway/cli@latest variable set "$var"
done

log_info "Environment variables set"

# Step 5: Deploy application
log_info "Step 5: Deploying application..."
npx @railway/cli@latest up --detach || log_warn "Deploy command may not support --detach flag"

log_info "Application deployed to Railway"

# Step 6: Get deployment information
log_info "Step 6: Getting deployment information..."
RAILWAY_URL=$(npx @railway/cli@latest domain list --json | jq -r ".[0].domain" || echo "unknown")
log_info "Railway URL: $RAILWAY_URL"

# Step 7: Configure custom domain
log_info "Step 7: Configuring custom domain..."
npx @railway/cli@latest domain add "$DOMAIN" || log_warn "Domain configuration might require manual setup"

log_info "Deployment complete!"
log_info "========================================="
log_info "Application URL: https://$DOMAIN"
log_info "Status: Check Railway dashboard for deployment status"
log_info "Next: Update DNS records at Namecheap"

echo ""
echo "📋 Manual steps required:"
echo "1. Update DNS records at Namecheap for $DOMAIN"
echo "2. Add CNAME record pointing to Railway domain"
echo "3. Wait for DNS propagation (5-60 minutes)"
echo "4. Access https://$DOMAIN/admin to create user accounts"
echo ""
