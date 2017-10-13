#!/bin/sh
#nano /tmp/curl_buffer && curl -F 'sprunge=<-' http://sprunge.us < /tmp/curl_buffer  && rm /tmp/curl_buffer

nano /tmp/curl_buffer && nc termbin.com 9999 < /tmp/curl_buffer  && rm /tmp/curl_buffer

