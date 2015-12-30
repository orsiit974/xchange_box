#!/bin/bash

# orsiitbox default directory
mkdir /opt/orsiitbox
# Files uploaded will be stored here
mkdir /var/www/html/files/

apt-get -y install screen

# install lighttpd
apt-get -y install lighttpd
cp ./conf/lighttpd.conf /etc/lighttpd/lighttpd.conf 
cp ./html/index.html /var/www/html/
cp ./html/chat.html /var/www/html/chat.html

# Installing chat
cd /opt/orsiitbox/
git clone https://github.com/orsiit974/simple-websocket-server
cd simple-websocket-server
python setup.py install
cd SimpleWebSocketServer
screen -dm python SimpleExampleServer.py --port 8001 --example chat
cp ./html/chat.html /var/www/html/chat.html

# Installing upload
cd /opt/orsiitbox
git clone https://github.com/orsiit974/Droopy
cd Droopy
screen -dm ./droopy -m "Upload here" -d /var/www/html/files/


echo "done"
echo "Please visit http://localhost:80"
