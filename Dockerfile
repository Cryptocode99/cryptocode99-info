FROM node:12.13.1 AS builder

WORKDIR /home/node
COPY --chown=node:node . .

# ARG BUILD_EXPIRE
# ARG BUILD_DOMAIN

RUN npm i -g yarn

USER node

RUN yarn install
RUN yarn build

FROM nginx:mainline-alpine

COPY --from=builder /home/node/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000

