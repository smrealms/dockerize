# SSL stuff only

# Only use strong protocols and ciphers
ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers 'AES128+EECDH:AES128+EDH';
add_header Strict-Transport-Security "max-age=31536000";

# Certificates managed by Certbot
ssl_certificate /etc/letsencrypt/live/smrealms.de/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/smrealms.de/privkey.pem;
include /etc/letsencrypt/options-ssl-nginx.conf;
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

# Redirect http to https
if ($scheme != "https") {
    return 301 https://$host$request_uri;
}

# For renewing with certbot
location /.well-known/acme-challenge {
    alias /www-certbot/.well-known/acme-challenge;
}
