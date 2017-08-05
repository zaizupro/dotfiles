#!/bin/sh
nano /tmp/curl_buffer && curl -F 'sprunge=<-' http://sprunge.us < /tmp/curl_buffer  && rm /tmp/curl_buffer
