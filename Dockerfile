FROM node:12.16.1

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm ci --only=production

COPY ./__sapper__/build/ .

EXPOSE 3000
CMD ["node", "index.js"]
