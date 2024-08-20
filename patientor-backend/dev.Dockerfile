FROM node:20

WORKDIR /usr/src/app

COPY . .

# COPY --chown=node:node . .

# Change npm ci to npm install since we are going to be in development mode
RUN npm install
# API_URL is set to http://localhost:3001/api for local and docker build
# this is required for docker-compose.dev.yml on top folder.
# check precedence in docker envs or create dockerfile without this specific variable
ENV API_URL=http://localhost:8080/api
# USER node
# npm run dev is the command to start the application in development mode
CMD ["npm", "run", "dev"]