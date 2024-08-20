FROM node:20

WORKDIR /usr/src/app

COPY . .

RUN npm ci

RUN npm run tsc

CMD ["npm", "run", "start"]
