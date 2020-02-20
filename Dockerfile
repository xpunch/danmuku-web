# -------
# Builder
# -------
FROM node:12.16.1

COPY . .
RUN npm install && RUN npm install -g @angular/cli && npm run build

# ---------------
# Final Container
# ---------------
FROM nginx:1.17.8-alpine

COPY dist /usr/share/nginx/html
COPY build/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80