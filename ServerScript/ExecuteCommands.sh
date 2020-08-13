#!/bin/bash

echo "Successfully Connected At : [$host] !"
# sudo rm /var/lib/apt/lists/lock
# sudo rm /var/cache/apt/archives/lock
# sudo rm /var/lib/dpkg/lock
# sudo dpkg --configure -a
# sudo apt-get remove mysql-server
pid=$(sudo fuser -v /var/cache/debconf/config.dat | grep -e '[0-9]*')
sudo kill -9 ${pid}
echo "Disconnecting From [$host] ...!" 