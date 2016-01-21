FROM ubuntu:14.04

RUN apt-get update && apt-get install -y nginx git bc

RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/mattermost /etc/nginx/sites-enabled/mattermost

ADD mattermost /etc/nginx/sites-available/
ADD docker-entry.sh /

#RUN mkdir /cert
#ADD cert/cert.pem /cert/
#ADD cert/private/key-no-password.pem /cert/

RUN chmod +x /docker-entry.sh

RUN git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
#RUN cd /opt/letsencrypt&&./letsencrypt-auto --text -v
RUN echo "cd /opt/letsencrypt&&./letsencrypt-auto --text certonly -a webroot --agree-tos --renew-by-default --webroot-path=/usr/share/nginx/html -d mm.miletwo.us" >> getcert.sh
# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

ENTRYPOINT /docker-entry.sh

EXPOSE 80 443
