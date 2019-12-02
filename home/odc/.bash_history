sudo apt install apache2 tree vim-gtk3
sudo a2disconf other-vhosts-access-log
sudo a2dissite 000-default.conf
sudo a2enmod ssl
sudo a2ensite odc.conf
sudo chmod 640 /etc/ssl/private/odc.key
sudo chown root:ssl-cert /etc/ssl/private/odc.key
sudo lsof -i :80
sudo systemctl restart apache2.service
sudo usermod -a -G ssl-cert www-data
openssl s_client -connect odc.sitpune.dev:443
