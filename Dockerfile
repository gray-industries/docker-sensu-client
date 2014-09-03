FROM grayindustries/docker-sensu-base
MAINTAINER: Greg Poirier <grep@gray.industries>

ADD files/settings.json /etc/sensu/settings.json
ADD files/supervisord-sensu-client.conf /etc/supervisord/conf.d/sensu-client.conf

CMD /usr/sbin/supervisord
