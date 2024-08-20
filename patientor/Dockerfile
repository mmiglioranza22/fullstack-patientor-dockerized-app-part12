# The first FROM is now a stage called build-stage

FROM node:20 AS build-stage 
# Run as a non-privileged user
RUN useradd -ms /bin/sh -u 1001 app
USER app

# Install dependencies
WORKDIR /usr/src/app
COPY --chown=app:app package.json package-lock.json ./
RUN npm ci

ENV VITE_BACKEND_URL="http://localhost:8080/api" 
# Copy source files into application directory
COPY --chown=app:app . .

RUN npm run build

# This is a new stage, everything before this is gone, except for the files that we want to COPY
FROM nginx:1.25-alpine

# COPY the directory dist from the build-stage to /usr/share/nginx/html
# The target location here was found from the Docker hub page
COPY --from=build-stage /usr/src/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/

# required for nginx.conf
EXPOSE 9080

CMD ["nginx", "-g", "daemon off;"]

# docker run -p 8000:9080 app-prod
