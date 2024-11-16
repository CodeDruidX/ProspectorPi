#!/bin/bash
echo Enter bridge 123
read bridge

echo Installing tor and bridges
apt install tor
apt install obfs4proxy
systemctl stop tor.service
mkdir /etc/tor/keys
chmod 700 /etc/tor/keys
echo HiddenServiceDir keys >> torrc
echo HiddenServicePort 443 127.0.0.1:443 >> torrc

echo ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy >> torrc
echo UseBridges 1 >> torrc
echo "Bridge obfs4 $bridge" >> torrc

rm /etc/tor/torrc
cp torrc /etc/tor/torrc
systemctl restart tor.service
