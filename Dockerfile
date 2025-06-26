# -------- STAGE 1: Build --------
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app
COPY . .

# -------- STAGE 2: Production --------
FROM node:18-alpine

WORKDIR /app

# Copy only necessary files from builder stage
COPY --from=builder /app .

# Expose app port
EXPOSE 3000

# Run the app
CMD ["node", "index.js"]
