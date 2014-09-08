#!/usr/bin/env bash

# For dynamic configuration of containers when sensu-client is started for the first time
# by supervisord.
if [ ! -f /etc/sensu/conf.d/client.json ]; then
    cat > /etc/sensu/conf.d/client.json << EOF
{
    "client": {
        "name": "${HOSTNAME}",
        "address": "$(awk \"/$HOSTNAME/ \"\'{ print $1 }\' /etc/hosts)",
        "subscriptions": [ "base" ]
    }
}
EOF
fi

/opt/sensu/bin/sensu-client -c /etc/sensu/settings.json -d /etc/sensu/conf.d -e /etc/sensu/extensions.d ${SENSU_FLAGS}

# This is particularly useful when you are first bringing up a sensu pod in a
# set of containers. RabbitMQ (and really all) of the dependent containers must
# be up and running before you start sensu-client.
sleep 15
