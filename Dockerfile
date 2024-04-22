# Stage 1: Build the React application
FROM node:alpine as build

WORKDIR /mart-frontend

COPY package.json ./
COPY package-lock.json ./

npm install -g npm@10.5.2

COPY . .

RUN npm run build

# Stage 2: Serve the React application with NGINX
FROM nginx:alpine

# Remove default NGINX website
RUN rm -rf /usr/share/nginx/html/*



# Copy built React app from previous stage to NGINX default public folder
COPY --from=build /mart-frontend/build /usr/share/nginx/html


# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
