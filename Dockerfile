FROM python:3.11-slim

LABEL org.opencontainers.image.title="mcpo"
LABEL org.opencontainers.image.description="Docker image for mcpo (Model Context Protocol OpenAPI Proxy)"
LABEL org.opencontainers.image.source="https://github.com/lkoujiu/mcpo-docker"
LABEL org.opencontainers.image.licenses="MIT"

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
RUN chmod +x generate-config.sh

# Switch to non-root user
USER appuser
COPY config.json /app/config.json
# Copy script
COPY generate-config.sh /app/generate-config.sh

EXPOSE 8000

ENTRYPOINT ["uvx", "mcpo"]
CMD ["--config", "/app/config.json"]
