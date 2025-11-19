FROM node:20-alpine

WORKDIR /app

COPY . .
COPY package.json package-lock.json ./

RUN npm install
RUN npm install -g pm2
RUN npm i -g @sap/cds-dk@8.8.2

RUN npm run build

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["pm2-runtime", "server.js"]
