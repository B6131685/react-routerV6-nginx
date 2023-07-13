FROM node:18-alpine3.17 as build
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build

FROM ubuntu
RUN apt-get update
RUN useradd -m finn
RUN apt install sudo
RUN apt-get install nginx -y
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /var/www/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]