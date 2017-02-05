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
# modified nginx.conf 
COPY nginx/nginx.conf /etc/nginx/nginx.conf
# needed for nginx pid
RUN mkdir -p /run/nginx
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
# create simple html root folder
RUN mkdir -p /usr/share/nginx/html && touch /usr/share/nginx/html/index.html

# usefool scripts
COPY scripts scripts
# templates
COPY templates templates

# Expose ports
EXPOSE 80 443

# Volumes
#VOLUME /etc/nginx/conf.d
#VOLUME /usr/share/nginx/html
#VOLUME /etc/letsencrypt

# Entry point
ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

#TODO template simple.conf used by default
#CMD ["simple"]


