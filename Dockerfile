FROM python:3.11-slim

LABEL org.opencontainers.image.title="mcpo"
LABEL org.opencontainers.image.description="Docker image for mcpo (Model Context Protocol OpenAPI Proxy)"
LABEL org.opencontainers.image.source="https://github.com/lkoujiu/mcpo-docker"
LABEL org.opencontainers.image.licenses="MIT"

# Specify the variable you need
ARG RAILWAY_SERVICE_NAME
# Use the variable
RUN echo $RAILWAY_SERVICE_NAME

ARG n8n-railway-custom.RAILWAY_PUBLIC_DOMAIN
RUN echo $n8n-railway-custom.RAILWAY_PUBLIC_DOMAIN

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="/usr/local/bin" sh

# Create /app and non-root user
RUN mkdir -p /app && useradd -m appuser && chown -R appuser:appuser /app
WORKDIR /app
# Copy script
COPY generate-config.sh /app/generate-config.sh
RUN chmod +x generate-config.sh

# Switch to non-root user
USER appuser
COPY config.json /app/config.json


EXPOSE 8000

ENTRYPOINT ["uvx", "mcpo"]
CMD ["--config", "/app/config.json"]
