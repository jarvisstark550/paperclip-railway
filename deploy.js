#!/usr/bin/env node

import https from 'https';

const RAILWAY_TOKEN = "9c46adff-44be-4ddd-8948-7927cb2a4e5a";
const API_URL = "backend.railway.app";

function makeGraphQLRequest(query) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({ query });
    const options = {
      hostname: API_URL,
      port: 443,
      path: '/graphql',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RAILWAY_TOKEN}`,
        'Content-Type': 'application/json',
        'Content-Length': data.length,
      },
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          resolve({ status: res.statusCode, body: JSON.parse(body) });
        } catch (e) {
          resolve({ status: res.statusCode, body });
        }
      });
    });

    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

async function main() {
  console.log('Testing Railway API connection...');
  const result = await makeGraphQLRequest('{ me { id email } }');
  console.log('Response:', JSON.stringify(result, null, 2));
}

main().catch(console.error);
