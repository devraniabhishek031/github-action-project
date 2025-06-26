# Stage 1: Build
FROM node:18-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .


# Stage 2: Run
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
ENV NODE_ENV=production
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=10s CMD curl -f http://localhost:3000/health || exit 1
CMD [ "node", "src/index.js" ]
