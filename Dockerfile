FROM node:lts-alpine As development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
USER node
EXPOSE 4000
ENTRYPOINT ["node", "dist/main.js"]

FROM node:lts-alpine as production
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=development /app/dist ./dist
USER node
CMD ["node", "dist/main.js"]
