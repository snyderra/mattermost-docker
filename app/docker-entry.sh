#!/bin/bash
config=/mattermost/config/config.json
echo -ne "Configure database connection..."
if [ ! -f $config ]
then
    cp /config.template.json $config
    sed -Ei "s/DB_ADDR/$DB_PORT_3306_TCP_ADDR/" $config
    sed -Ei "s/DB_PORT/$DB_PORT_3306_TCP_PORT/" $config
    echo OK
else
    echo SKIP
fi

echo -n "Wait until database is ready..."
until nc -z $DB_PORT_3306_TCP_ADDR $DB_PORT_3306_TCP_PORT
do
    echo -n .
    sleep 1
done

# Wait to avoid "panic: Failed to open sql connection pq: the database system is starting up"
sleep 1

echo "OK"

echo "Starting platform"
cd /mattermost/bin
./platform
