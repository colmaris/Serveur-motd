# Dynamic Message of the day for my Debian server

Screenshot

![logo](/screen_shot.jpg "Screenshot_blank")

## Configuration :

 You have to install the rsb-release package to use it.

 ```
 sudo apt-get install lsb-release
 ```

## Install the developpment release

```
git clone https://framagit.org/draconis/motd.git
```

Disable the SSH's motd

```
sudo sed -i 's/#PrintMotd yes/PrintMotd no/g' /etc/ssh/sshd_config
```

Enable the new motd at start session

```
sudo  echo "/usr/local/bin/coldmotd" > /etc/profile.d/coldmotd.sh
sudo chmod +x /etc/profile.d/coldmotd.sh
```

Copy the new motd

```
sudo cp motd /usr/local/bin/
sudo chmod +x /usr/local/bin/motd
```
# FOR ZSH USERS

Just add this line "/usr/local/bin/motd" in your ~/.ZSHRC. It's recommanded to add it at the end of the file



Sources : https://github.com/jjasghar/scripts/blob/master/dynmotd
