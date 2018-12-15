#!/bin/sh

mkdir /var/www/html
if [ "$USE_SIMPLE" = "false" ]; then
	if [ "$USE_SAMPLE" = "true" ]; then
    	echo 'Generating SSL for ' $DOMAIN
		echo 'Generating Website for ' $DOMAIN
		printf "$DOMAIN\ngzip\nlog stdout\nerrors stdout\nroot /var/www/html" > /etc/caddy/Caddyfile
    else
    	echo 'Generating SSL for ' $DOMAIN
    	echo 'You Should insure there is a index.html in the webroot of ' $DOMAIN
    	printf "$DOMAIN\ngzip\nlog stdout\nerrors stdout\nroot /var/www/html" > /etc/caddy/Caddyfile
    	rm -rf /var/www/html/*
    fi
else
	echo 'Generating SSL for ' $DOMAIN
	echo 'Generating Website for ' $DOMAIN
	echo 'Generating the Hole of ' $DOMAIN ' and remember Big Brother is watching you'
	printf "$DOMAIN\ngzip\nlog stdout\nerrors stdout\nroot /var/www/html\n \nforwardproxy {\n    basicauth $USER $PWD\n    ports     $PORT_80 $PORT_443\n    hide_ip\n    hide_via\n    probe_resistance\n    response_timeout 30\n    dial_timeout     30\n}" > /etc/caddy/Caddyfile
fi

dir=$(find /root/.caddy/acme -name $DOMAIN -type d -print)
if [ -d $dir ]
then
  CRT="${dir}/${DOMAIN}.crt"
  KEY="${dir}/${DOMAIN}.key"
  cp $CRT /root/.caddy/acme
  cp $KEY /root/.caddy/acme
fi

/usr/bin/caddy --conf /etc/caddy/Caddyfile --log stdout --agree
