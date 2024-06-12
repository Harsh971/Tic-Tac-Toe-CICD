# Use an official Nginx image as a parent image
FROM nginx:latest

# Copy the local files into the container's filesystem
COPY . /usr/share/nginx/html

# Expose port 80 to allow outside access
EXPOSE 80

# Start Nginx with global binding to 0.0.0.0
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
