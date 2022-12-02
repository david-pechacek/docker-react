# Multi-step build example

# build phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase
FROM nginx
# copy over something from another phase
# copy build folder from previous phase (/app/build)
# /usr/share/nginx/html is where you host static content from for nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx container is start so we don't have to specify that.
