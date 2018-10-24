#!/bin/bash

if [ -z "$$1" ]; then
    echo "$$0 start|stop|restart"
    exit 0
fi

ACTION=""
for a in $$*; do
    if [ "$$a" == "start" -o "$$a" == "stop" -o "$$a" == "restart" ]; then
        ACTION="$$a"
    fi
done

if [ "$$ACTION" == "" ]; then
    echo "$$0 start|stop|restart"
    exit 0
fi

if [ "$$a" == "stop" ]; then
    supervisorctl stop ${name}:*
    sleep 2
    apachectl -D 'FOREGROUND' -k stop -f /home/${name}/tryton/etc/apache2/apache2.conf
elif [ "$$a" == "start" ]; then
    supervisorctl start ${name}:*
elif [ "$$a" == "restart" ]; then
    supervisorctl stop ${name}:*
    sleep 2
    apachectl -D 'FOREGROUND' -k stop -f /home/${name}/tryton/etc/apache2/apache2.conf
    sleep 2
    supervisorctl start ${name}:*
fi

exit 0
