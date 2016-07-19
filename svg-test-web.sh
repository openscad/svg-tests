#!/bin/bash -e

while true
do
	echo -n "URL: "
	read url
	wget -O svg-test.tmp "$url"
	N=$(grep class=.d-svg. svg-test.tmp | sed -e 's/.*href="//; s/".*//')
	wget http://www.openclipart.org"$N"
	rm svg-test.tmp
done
