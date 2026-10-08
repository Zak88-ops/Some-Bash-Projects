FROM node:22-alpine
WORKDIR /app
COPY *.json* . 
RUN npm install 
COPY . . 
EXPOSE 4000
CMD ["node","server.js"]
