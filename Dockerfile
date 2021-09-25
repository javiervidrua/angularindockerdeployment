###############################################################################
# Stage 1: Compile and Build angular codebase
###############################################################################
# Use official node image as the base image
FROM node:latest as node

# Set the working directory INSIDE OF THE DOCKER CONTAINER
WORKDIR /angular-application

# Add the source code to app
COPY ./angular-application /angular-application

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build --prod


###############################################################################
# Stage 2: Serve app with nginx server
###############################################################################
# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=node /angular-application/dist/angular-application /usr/share/nginx/html

# Expose port 80
EXPOSE 80
