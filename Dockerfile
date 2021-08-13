FROM node:14-alpine As development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
ENTRYPOINT ["node", "dist/main.js"]

FROM node:14-alpine as production
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=development /app/dist ./dist
USER node
ENV PORT=8080
EXPOSE 8080
CMD ["node", "dist/main.js"]
