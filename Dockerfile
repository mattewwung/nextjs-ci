FROM node:20-alpine AS builder

WORKDIR /app

COPY . .
COPY package.json package-lock.json ./

RUN npm install
RUN npm install -g pm2

RUN npm run build

ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["pm2-runtime", "server.js"]
