FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY index.js logger.js ./

EXPOSE 10000

CMD ["npm", "start"]
