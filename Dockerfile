FROM jenkins/inbound-agent:alpine

USER root

# Install Node.js
RUN apk add --no-cache nodejs npm

USER jenkins