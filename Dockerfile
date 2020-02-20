# -------
# Builder
# -------
FROM node:12.16.1 AS builder

COPY . .
RUN npm install && npm install -g @angular/cli
RUN npm run build

RUN pw && ls

# ---------------
# Final Container
# ---------------
FROM nginx:1.17.8-alpine 

COPY --from=builder /danmuku/dist /usr/share/nginx/html
COPY --from=builder /danmuku/build/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80