#!/bin/bash
set -eo pipefail

# create SSH host keys
mkdir -p "/hostkeys/etc/ssh/"
/usr/bin/ssh-keygen -A -f /hostkeys

# remove any old keys and reset authorized_keys
rm -rf /home/borg/.ssh/*
touch "/home/borg/.ssh/authorized_keys"

# recreate keys 
for file in /config/hosts/*.pub; do
    [ -e "$file" ] || continue
    name=$(basename "${file}" .pub)
    key=$(<"$file")
    
    mkdir -p "/data/$name"

    line="command=\"cd /data/${name};borg serve --restrict-to-repository /data/${name}\",restrict ${key}"
    echo "$line" >> "/home/borg/.ssh/authorized_keys"
done

# set correct permissions
chown -R borg:borg /home/borg
chown -R borg:borg /data

chmod 700 /home/borg/.ssh
chmod 600 /home/borg/.ssh/authorized_keys

# start ssh server (exec replaces the shell so tini receives signals correctly)
exec /usr/sbin/sshd -D -e -p 2222