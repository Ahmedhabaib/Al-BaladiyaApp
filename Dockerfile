# Use an official Flutter image as the base image
FROM cirrusci/flutter:3.7.0

# Set the working directory in the container
WORKDIR /app

# Copy the pubspec files to the working directory
COPY pubspec.* ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Build the Flutter web application
RUN flutter build web

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Remove default nginx website
RUN rm -rf /var/www/html/*

# Copy the built web application to nginx's html directory
RUN cp -r build/web/* /var/www/html

# Expose port 80 for the web server
EXPOSE 80

# Start nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
