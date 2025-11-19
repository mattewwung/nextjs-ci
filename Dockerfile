FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install -g pm2@6.0.13 @sap/cds-dk@8.8.2

RUN npm install

COPY . .

RUN npm run build

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["pm2-runtime", "server.js"]
