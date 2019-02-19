#!/usr/bin/env bash

HOMEDIR=$HOME
USERNAME=$(whoami)

USE_SUDO=''
if [ $USERNAME != "root" ];
then
  USE_SUDO="sudo "
fi

# install the motd
cp motd /usr/local/bin/
chmod +x /usr/local/bin/motd

#install the maintenance file
cp motd-maint /etc/motd-maint
