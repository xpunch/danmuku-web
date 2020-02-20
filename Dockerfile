# -------
# Builder
# -------
FROM node:12.16.1 AS builder

COPY . .
RUN npm install \
    npm install -g @angular/cli \
    npm run build

# ---------------
# Final Container
# ---------------
FROM nginx:1.17.8-alpine 

COPY --from=builder dist /usr/share/nginx/html
COPY --from=builder build/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80