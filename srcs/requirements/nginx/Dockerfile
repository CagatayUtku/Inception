# Use the penultimate stable version of Alpine as the base image
FROM debian:11

# Expose the HTTPS port
EXPOSE 443

# Install NGINX and OpenSSL
RUN apt update && apt install -y nginx openssl

# Create SSL directory and generate SSL certificate/key
RUN mkdir -p /ssl && \
    cd /ssl && \
    openssl genpkey -algorithm RSA -out nginx.key && \
    openssl req -new -key nginx.key -out nginx.csr -subj "/C=DE/ST=Heilbronn/L=Heilbronn/O=42/CN=42heilbronn.com" && \
    openssl req -x509 -sha256 -days 365 -key nginx.key -in nginx.csr -out nginx.crt

# Copy NGINX configuration files
COPY nginx.conf /etc/nginx/conf.d/wp.conf

# Set the entry point
ENTRYPOINT ["nginx", "-g", "daemon off;"]
