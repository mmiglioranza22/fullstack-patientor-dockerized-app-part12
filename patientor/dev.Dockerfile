# # Works for single docker build and docker compose, but does not listen to changes in code
# FROM node:20

# WORKDIR /usr/src/app

# COPY . .

# # COPY --chown=node:node . .

# # Change npm ci to npm install since we are going to be in development mode
# RUN npm install

# # USER node
# # npm run dev is the command to start the application in development mode
# CMD ["npm", "run", "dev", "--", "--host"]
# ----- END WORKS -----

# ----- WORKS -----
# https://www.baeldung.com/ops/docker-npm_install-missing-node_modules-fix 2 step build
# # Stage 1: Build
# FROM node:20 AS builder
# WORKDIR /usr/src/app

# # Copy package.json and package-lock.json first to leverage the cache
# COPY package.json package-lock.json ./

# # Install dependencies and cache them
# RUN npm install --prefer-offline --no-audit --progress=false

# # Copy the rest of the application code
# COPY . .

# # Stage 2: Runtime
# FROM node:20
# WORKDIR /usr/src/app
# COPY --from=builder /usr/src/app .

# CMD ["npm", "run", "dev", "--", "--host"]

# ----- END WORKS -----

# --- DEVELOPMENT MODE WORKS!!!!!! ----- https://docs.docker.com/compose/file-watch/#prerequisites
# run with docker compose --watch
# Run as a non-privileged user
FROM node:20
RUN useradd -ms /bin/sh -u 1001 app
USER app

# Install dependencies
WORKDIR /usr/src/app
COPY --chown=app:app package.json package-lock.json ./
RUN npm install

# Copy source files into application directory
COPY --chown=app:app . .

CMD ["npm", "run", "dev", "--", "--host"]
