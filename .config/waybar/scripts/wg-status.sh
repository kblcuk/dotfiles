#!/bin/bash
ls /sys/class/net | grep wg > /dev/null \
&& echo '{"text":"Connected","class":"connected","percentage":100}' \
|| echo '{"text":"Disconnected","class":"disconnected","percentage":0}'
