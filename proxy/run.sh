#!/bin/sh

echo "starting first socat"
socat TCP4-LISTEN:8080,reuseaddr,fork TCP4:oa-server:8080 &

echo "starting second socat"
socat TCP4-LISTEN:4200,reuseaddr,fork TCP4:oa-web:4200

