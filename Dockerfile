# -------
# Builder
# -------
FROM node:13.1.0 AS builder

WORKDIR /danmuku
COPY . .
RUN npm install && npm install -g @angular/cli
RUN pwd && ls && ng version && npm run build

# ---------------
# Final Container
# ---------------
FROM nginx:1.17.8-alpine 

COPY --from=builder /danmuku/dist /usr/share/nginx/html
COPY --from=builder /danmuku/build/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80