FROM alpine:3.5

# Environnment variables

# root main domain
ENV DOMAIN ""
# subdomains 
ENV MOREDOMAINS ""
# email for cert registration
ENV EMAIL ""
# diffie hellman key size
ENV DH 2048
# staging is false by default
ENV TEST 0


# packages needed
RUN apk add --no-cache --update bash nginx openssl certbot


# needed for nging pid
RUN mkdir -p /run/nginx

# copy nginx config
COPY nginx /etc/nginx

# create simple html root folder
RUN mkdir -p /usr/share/nginx/html
COPY html /usr/share/nginx/html

# usefool scripts
COPY scripts scripts

# templates
COPY templates templates

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Expose ports
EXPOSE 80 443

# Entry point
#ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD START


