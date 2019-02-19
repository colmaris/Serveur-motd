#!/bin/bash

HOMEDIR=$HOME
USERNAME=$(whoami)

#USE_SUDO=''
if [ $USERNAME != "root" ];
then
  echo "run this script with root priviliges !"
else

# install the motd
echo "Installing motd..."
cp motd /usr/local/bin/
cp lxc /usr/local/bin/


#install the maintenance file
cp motd-maint /etc/motd-maint

#Disable the motd in SSH Server
sed -i 's/#PrintMotd yes/PrintMotd no/g' /etc/ssh/sshd_config
#Enable motd for bash user
echo "/usr/local/bin/motd" > /etc/profile.d/motd.sh
chmod +x /etc/profile.d/motd.sh
# for zsh users
if [ -f "/usr/bin/zsh" ];then
echo "/usr/local/bin/motd" >> ~/.zprofile;
fi
#disable the system motd
echo "" > /etc/motd
chmod +x /usr/local/bin/motd
chmod +x /usr/local/bin/lxc
fi
