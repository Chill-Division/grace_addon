FROM debian:stable-slim

# Install packages
RUN apt-get update && \
    apt-get install -y git nginx php8.2-fpm php8.2-mysql mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Prepare volumes and directories
RUN mkdir -p /var/www/html /data/db /etc/nginx/conf.d

# Copy website and configuration files
RUN git clone https://github.com/Chill-Division/GRACe.git /var/www/html/GRACe
COPY /var/www/html/GRACe/grace_schema.sql /tmp/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY run.sh /run.sh

# Ensure run.sh is executable
RUN chmod +x /run.sh

CMD ["/run.sh"]
