# Use the official Dart image as the base image
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Get dependencies
RUN dart pub get

# Copy the rest of the application
COPY . .

# Build the Flutter web app
RUN dart pub global activate flutter_tools
RUN dart pub global run flutter_tools:flutter build web --release

# Use nginx to serve the Flutter web app
FROM nginx:alpine

# Copy the built Flutter web app to nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
