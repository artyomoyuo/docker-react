FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
COPY --chown=node:node ./package.json .
RUN npm install
COPY --chown=node:node  ./ ./ 
RUN npm run build 

FROM nginx
EXPOSE 80 # to read by travis, docker ignores it
COPY --from=builder /home/node/app/build /usr/share/nginx/html

#WORKDIR=/app/build
#CMD ["nginx"]

