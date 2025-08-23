#!/bin/bash

# Fallback for local dev
#N8N_URL="https://${RAILWAY_PUBLIC_DOMAIN:-localhost:3000}/mcp/starter"
MCPO_N8N_URL="https://n8n-railway-custom-production-5457.up.railway.app/mcp/starter"
LOCAL_TIMEZONE="${LOCAL_TIMEZONE:-Asia/Shanghai}"
echo "what is N*N_URL ${MCPO_N8N_URL}"
if [ ! -d /app ]; then
  mkdir -p /app
fi 
# Generate config.json
cat <<EOF > /app/config.json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "time": {
      "command": "uvx",
      "args": ["mcp-server-time", "--local-timezone=${LOCAL_TIMEZONE}"]
    },
    "n8n": {
      "command": "npx",
      "args": ["-y", "supergateway", "--sse", "${MCPO_N8N_URL}"]
    }
  }
}
EOF

echo "✅ config.json generated using RAILWAY_PUBLIC_DOMAIN"

