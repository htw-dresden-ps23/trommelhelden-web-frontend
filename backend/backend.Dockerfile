FROM node:latest
WORKDIR /srv/app
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npx prisma generate --schema=./src/prisma/schema.prisma    
RUN npm run build
EXPOSE 5001
CMD ["node", "dist/app.js"]