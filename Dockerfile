FROM node:10.16.0-alpine
WORKDIR /home/node/app
COPY package.json .
RUN npm install --production
COPY . .
USER node
EXPOSE 3002
CMD ["node", "./bin/www"]