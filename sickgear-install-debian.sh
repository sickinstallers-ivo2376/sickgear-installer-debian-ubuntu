sudo apt-get install curl git-core build-essential libsqlite3-dev libbz2-dev libreadline-dev libssl-dev zlib1g-dev

sudo mkdir -p /opt/SickGear/data
sudo chown $USER -R /opt/SickGear

sudo git clone https://github.com/SickGear/SickGear.git /opt/SickGear/app
sudo git clone https://github.com/yyuu/pyenv /opt/SickGear/.pyenv

sudo PYENV_ROOT=/opt/SickGear/.pyenv /opt/SickGear/.pyenv/bin/pyenv install 2.7.13
cd /opt/SickGear/app
sudo /opt/SickGear/.pyenv/versions/2.7.13/bin/pip install --upgrade pip
sudo /opt/SickGear/.pyenv/versions/2.7.13/bin/pip install --upgrade pyopenssl ndg-httpsclient virtualenv lxml
sudo /opt/SickGear/.pyenv/versions/2.7.13/bin/pip install -r requirements.txt

#systemd approach
#start at boot systemd debian or ubuntu systemd
#	sudo cp /opt/SickGear/app/init-scripts/init.systemd /etc/systemd/system/sickgear@.service

#Comments
#Edit the copied /etc/systemd/system/sickgear@.service file
#replace user=sickgear and group=sickgear to fit your set up (e.g. user1)
#replace the entire line ExecStart=/usr/bin/python2 with the following pyenv line...
#ExecStart=/opt/SickGear/.pyenv/versions/2.7.13/bin/python2 /opt/SickGear/app/sickgear.py --systemd --datadir=/opt/SickGear/data --port=%I

#Enable the unit file and define the port that you want sg to run with...
#	sudo systemctl enable sickgear@8081
#Expect output similar to...
#Created symlink from /etc/systemd/system/multi-user.target.wants/sickgear@8081.service to /etc/systemd/system/sickgear@.service.

#systemd usage
#sudo systemctl daemon-reload
#sudo systemctl start sickgear@8081
#sudo systemctl status sickgear@8081

#alternatively just start with start-sickgear.sh cmd
echo "/opt/SickGear/.pyenv/versions/2.7.13/bin/python2 /opt/SickGear/app/sickgear.py --datadir=/opt/SickGear/data" >> /opt/SickGear/start-sickgear.sh
#first edit config.ini to reflect port u need
sudo gedit /opt/SickGear/data/config.ini
sudo chown $USER:$USER -Rf /opt/SickGear
cd /opt/SickGear
screen ./start-sickgear.sh




