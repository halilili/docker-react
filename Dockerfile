FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.13.9-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 8808
CMD ["nginx", "-g", "daemon off;"]
