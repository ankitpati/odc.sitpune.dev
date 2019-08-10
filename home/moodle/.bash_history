sudo apt install apache2 aspell build-essential certbot ghostscript graphviz libapache2-mod-php mysql-server opendkim opendkim-tools php php-curl php-gd php-intl php-ldap php-mbstring php-mysql php-pspell php-soap php-xml php-xmlrpc php-zip screen sendmail tree vim-gtk3
sudo a2disconf other-vhosts-access-log
sudo a2dissite 000-default.conf
sudo a2enmod ssl
sudo mysql_secure_installation
sudo mysql
sudo letsencrypt --email 'contact@ankitpati.in' --domains 'civil.sitpune.dev' --agree-tos --renew-by-default --manual certonly --preferred-challenges 'dns-01' --server 'https://acme-v02.api.letsencrypt.org/directory' && sudo bash -c 'cat /etc/letsencrypt/live/civil.sitpune.dev/fullchain.pem > /etc/ssl/certs/moodle.pem' && sudo bash -c 'cat /etc/letsencrypt/live/civil.sitpune.dev/privkey.pem > /etc/ssl/private/moodle.key'
sudo usermod -a -G ssl-cert www-data
sudo chown root:ssl-cert /etc/ssl/private/moodle.key
sudo chmod 640 /etc/ssl/private/moodle.key
sudo a2ensite moodle.conf
sudo sendmailconfig 
git clone --depth=1 --branch=MOODLE_37_STABLE https://github.com/moodle/moodle.git
mv moodle/ /opt/
sudo chown www-data:www-data -hR /opt/moodle/ /opt/moodledata/
sudo -u www-data /usr/bin/php /opt/moodle/admin/cli/install.php
sudo chown ankitpati:ankitpati -hR /opt/moodle/
publishify /opt/moodle/
sudo systemctl restart apache2.service
sudo systemctl restart mysql.service
sudo systemctl restart sendmail.service 
sudo systemctl restart opendkim.service 
openssl s_client -connect civil.sitpune.dev:443
opendkim-genkey -t -s default -d civil.sitpune.dev
sudo tail -F /var/log/messages
sudo tail -F /var/log/mail.log
sudo grep dkim -i /var/log/syslog
