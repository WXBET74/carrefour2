# Dockerfile
FROM node:18-slim

# Avoid prompts from Puppeteer during install
ENV PUPPETEER_SKIP_DOWNLOAD=false \
    PUPPETEER_PRODUCT=chrome \
    PUPPETEER_CACHE_DIR=/home/pptruser/.cache/puppeteer

# Install necessary dependencies for Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install && npx puppeteer install

# Bundle app source
COPY . .

# Expose the port and start the app
EXPOSE 3000
CMD [ "node", "index.js" ]
