FROM node:18-alpine

# Install Java (required for Jenkins agent)
RUN apk add --no-cache openjdk11-jre-headless openssh-client git curl

# Create Jenkins working directory
RUN mkdir -p /home/jenkins && chmod 777 /home/jenkins

# Set working directory
WORKDIR /home/jenkins