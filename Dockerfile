# -------- STAGE 1: Build --------
FROM node:22 AS builder

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y python3-dev build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy package.json and package-lock.json and install dependencies
COPY package*.json ./
RUN npm install --force

# Copy the rest of the app source code
COPY . .

# -------- STAGE 2: Development --------
FROM node:22

WORKDIR /app

# Copy from the builder stage
COPY --from=builder /app .

# Install nodemon and cross-env globally if not installed locally (optional)
RUN npm install --global nodemon cross-env

# Expose port your app listens on
EXPOSE 3000

# Run migration and seed before starting the app
CMD sh -c "npm run migration && npm run seed && npm run dev"
