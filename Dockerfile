# pull the official base image  
FROM node:13.12.0-alpine as dev
 
# set your working directory  
WORKDIR /app  
 
# install application dependencies  
COPY package.json ./  
COPY package-lock.json ./  
RUN npm install 
 
# add app  
COPY . ./  

RUN npm run build

FROM nginxinc/nginx-unprivileged
COPY --from=dev /app/build /etc/nginx/html

USER 101
COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx-debug", "-g", "daemon off;"]