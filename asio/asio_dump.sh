#!/bin/bash

CONFIG_FILE="asio.conf"
if [ ! -f $CONFIG_FILE ]; then
    echo "Config file $CONFIG_FILE does not exist"
    exit 1
fi

while read var value
do
    export "$var"="$value"
done < $CONFIG_FILE

if [ -z ${asio_id+x} ]; then echo "asio_id is unset!"; exit 1; fi
if [ -z ${asio_pass+x} ]; then echo "asio_pass is unset!"; exit 1; fi

response=$(curl -sL --w "%{http_code}\\n" -o /dev/null --user "$asio_id:$asio_pass" https://asio.kajak.fi/pls/asio/asio_os.os_suoritukset?lang=f)

if [[ "$response" -ne "200" ]]; then 
    echo "Invalid asio_id/asio_pass"
    exit 1;
fi



