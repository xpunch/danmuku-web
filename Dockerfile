# -------
# Builder
# -------
FROM node:12.16.1 AS builder

WORKDIR /usr/local
COPY . .
RUN npm install \
    npm install -g @angular/cli \
    npm run build

RUN ls

# ---------------
# Final Container
# ---------------
FROM nginx:1.17.8-alpine 

WORKDIR /usr/local
COPY --from=builder /usr/local/dist /usr/share/nginx/html
COPY --from=builder /usr/local/build/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80