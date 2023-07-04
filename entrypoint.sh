#!/bin/bash
set -e

if [ -e "/config" ]; then
  if [ ! -e "/config/sshd_config" ]; then
    print "Copying initial ssh config"
    cp -a /etc/ssh-template/* /config/
  fi
else
  print "No /config folder found"
  exit 1
fi


if [ ! -e /home/$USER_NAME ]; then
  print "Creating user $USER_NAME"
  adduser --disabled-password --gid $PGID --uid $PUID $USER_NAME
fi

if [ ! -e /config/dot-ssh ]; then
  print "Creating /config/dot-ssh"
  mkdir -p /config/dot-ssh
  chown $USER_NAME:$USER_NAME /config/dot-ssh
  chmod 750 /config/dot-ssh
fi

if [ ! -e /config/dot-ssh/authorized_keys ]; then
  print "Creating /config/dot-ssh/authorized_keys"
  touch /config/dot-ssh/authorized_keys
  chown $USER_NAME:$USER_NAME /config/dot-ssh/authorized_keys
  chmod 400 /config/dot-ssh/authorized_keys
fi

if [ ! -e /home/$USER_NAME/.ssh ]; then
  ln -s /config/dot-ssh /home/$USER_NAME/.ssh
fi

exec /usr/sbin/sshd -D -e -p 2222
