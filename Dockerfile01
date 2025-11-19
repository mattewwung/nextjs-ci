# ======================
# 1. Build Stage
# ======================
FROM node:20-alpine AS builder

WORKDIR /app

# 只复制依赖文件，保持缓存命中率最高
COPY package.json package-lock.json ./

# 安装依赖（使用 npm ci）
RUN npm ci

# 复制所有源代码
COPY . .

# 构建 Next.js
RUN npm run build


# ======================
# 2. Production Runner
# ======================
FROM node:20-alpine AS runner

WORKDIR /app

# 安装 PM2（全局安装只会运行一次 → 有缓存）
RUN npm install -g pm2

ENV NODE_ENV=production
ENV PORT=3000

# 复制独立运行的 Next.js 产物
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

EXPOSE 3000

# 使用 PM2 启动 Next.js（优雅、稳定、日志自动管理）
CMD ["pm2-runtime", "server.js"]
