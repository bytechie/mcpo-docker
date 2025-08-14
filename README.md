# mcpo-docker

The source from [alephpiece](https://github.com/alephpiece/mcpo-docker) .

An example Docker image for [mcpo](https://github.com/open-webui/mcpo), a tool that exposes MCP (Model Context Protocol) servers as OpenAPI-compatible HTTP endpoints for [OpenWebUI](https://github.com/open-webui/open-webui).

> Still waiting for the official mcpo docker!

## Quick start

```shell
# Pull the repo
git clone https://github.com/lkoujiu/mcpo-docker.git
cd mcpo-docker

# Copy sample files and edit them as you like.
cp config.example.json config.json
cp docker-compose.example.yml docker-compose.yml

# Create a container and wait for the servers to start.
# It may take time if you have many servers enabled.
docker compose up -d
```

Or you can build the docker from source.

```shell
docker build -t mcpo .
```

### Connect OpenWebUI to your servers

> See [OpenAPI Tool Servers](https://docs.openwebui.com/openapi-servers/) for details.

1. Open OpenWebUI > Settings > Tools
2. Add a connection `http://localhost:8000/memory`
3. Check available tools on the chat page

With mcpo, each MCP server gets a separate endpoint. For example:

- `http://localhost:8000/sequential-thinking`
- `http://localhost:8000/memory`
- `http://localhost:8000/time`

## MCP configuration

Standard MCP configuration file, see [config.example.json](./config.example.json).



# Railway platform:
Integrating openwebui => mcpo => n8n  
## [Railway-provided Variables](https://docs.railway.com/guides/variables#reference-variables)
Railway provides many variables to help with development operations. Some of the commonly used variables include -

- RAILWAY_PUBLIC_DOMAIN
- RAILWAY_PRIVATE_DOMAIN
- RAILWAY_TCP_PROXY_PORT

## Referencing Another Service's Variable
Use the following syntax to reference variables in another service:

`${{SERVICE_NAME.VAR}}`

Your frontend service needs to make requests to your backend. You do not want to hardcode the backend URL in your frontend code. Go to your frontend service settings and add the Railway-provided variable for the backend URL

`API_URL=https://${{ backend.RAILWAY_PUBLIC_DOMAIN }}`


To use a Streamable HTTP-compatible MCP server, specify the server type and endpoint:

mcpo --port 8000 --api-key "top-secret" --server-type "streamable-http" -- http://127.0.0.1:8002/mcp


## License

MIT
