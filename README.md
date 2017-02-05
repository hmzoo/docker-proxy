# docker-proxy
```
docker run -d  --name mysite-proxy --restart always\
	-p 80:80 \
	-p 443:443 \
	-v /opt/mysite.com/proxy/letsencrypt:/etc/letsencrypt \
	-v /opt/mysite.com/proxy/conf.d:/etc/nginx/conf.d \
	-v /opt/mysite.com/proxy/html:/usr/share/nginx/html \
	-e DOMAIN=mysite.com \
	-e MOREDOMAINS=www.mysite.com,dev.mysite.com \
	-e EMAIL=me@mysite.com \
	-e DH=2048\
	-e TEST=1 \
	hmzoo/proxy
```
