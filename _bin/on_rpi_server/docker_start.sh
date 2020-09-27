docker run -d \
--name www_houen_net \
--restart always \
-v /home/houen/www.houen.net/site:/var/www/html \
-v /home/houen/www.houen.net/bin/Caddyfile:/etc/caddy/Caddyfile \
-v /home/houen/www.houen.net/caddy_data:/data \
-p 0.0.0.0:80:80 -p 0.0.0.0:443:443 \
caddy