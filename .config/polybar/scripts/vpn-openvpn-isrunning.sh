#!/bin/sh

connection=$(pgrep -a openvpn | head -n 2 | rg --only-matching --replace '$1' 'remote ([a-zA-Z\.]+)')

if [ -n "$connection" ]; then
    echo "VPN: $connection"
else
    echo ""
fi
