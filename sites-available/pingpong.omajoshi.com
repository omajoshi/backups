server {

        server_name pingpong.omajoshi.com;

        location / {
                include proxy_params;
                proxy_pass http://unix:/run/gunicorn.sock;
        }

        location /static/ {
            alias /home/omajoshi9/pingpong/pingpong/static/;
        }

    listen [::]:443 ssl; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/omajoshi.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/omajoshi.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}

server {
    if ($host = pingpong.omajoshi.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


        listen 80;
        listen [::]:80;

        server_name pingpong.omajoshi.com;
    return 404; # managed by Certbot


}
