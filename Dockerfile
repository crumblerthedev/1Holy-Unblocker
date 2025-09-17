FROM node:20-slim

WORKDIR /app

LABEL org.opencontainers.image.title="Holy Unblocker LTS" \
      org.opencontainers.image.description="An effective, privacy-focused web proxy service" \
      org.opencontainers.image.version="6.9.1" \
      org.opencontainers.image.authors="Holy Unblocker Team" \
      org.opencontainers.image.source="https://github.com/QuiteAFancyEmerald/Holy-Unblocker/"

# Install system dependencies
RUN apt-get update && apt-get install -y tor bash curl git python3 g++ make && rm -rf /var/lib/apt/lists/*

# Copy package.json & package-lock.json first
COPY package*.json ./

# Install Node dependencies
RUN npm install --production

# Copy source code
COPY . .

# Build the project
RUN npm run build

# Expose HTTP port
ENV PORT=8080
EXPOSE 8080

# Serve
COPY serve.sh /serve.sh
RUN chmod +x /serve.sh
CMD ["/serve.sh"]
