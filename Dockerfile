# Use the official Node.js image as the base image
FROM node:18.13-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of the application files to the container
COPY . .

# Build the Angular application
RUN npm run build

# Use the official Nginx image to serve the application
FROM nginx:alpine

# Copy the built application files to the Nginx HTML directory
COPY --from=0 /app/dist/my-angular-project /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
