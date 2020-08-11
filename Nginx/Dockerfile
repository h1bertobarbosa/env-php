FROM nginx:1.13
MAINTAINER MDT <https://mdt.udv.org.br>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y locales cron openssl build-essential wget

RUN openssl dhparam -out /etc/nginx/dhparams.pem 2048

RUN mkdir -p /etc/letsencrypt
RUN wget https://raw.githubusercontent.com/certbot/certbot/master/certbot-auto && mv certbot-auto /usr/local/letsencrypt-auto
RUN chmod a+x /usr/local/letsencrypt-auto
RUN /usr/local/letsencrypt-auto -h

COPY ./entrypoint.sh        /usr/local/entrypoint.sh
COPY ./letsencryptcron.conf /usr/local/letsencryptcron.conf
COPY ./letsencrypt.sh       /usr/local/letsencrypt.sh
COPY ./fastcgi.conf         /etc/nginx/fastcgi.conf

RUN chmod +x /usr/local/entrypoint.sh
RUN chmod +x /usr/local/letsencrypt.sh
RUN crontab  /usr/local/letsencryptcron.conf

RUN usermod -u 1001 www-data

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/entrypoint.sh"]

CMD ["nginx"]
