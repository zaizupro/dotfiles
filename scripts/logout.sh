#!/bin/sh

sudo kill -9 $(ps ax |grep  "login -- $(whoami)" | grep -v 'grep' | awk  '{print $1}' )
