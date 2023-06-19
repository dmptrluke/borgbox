FROM alpine:3.18.2

# install dependencies 
RUN apk add --no-cache --update openssh-server borgbackup bash tini

# set init
ENTRYPOINT ["/sbin/tini", "--"]

# set work directory
WORKDIR /code

# create a persistent volume to hold host keys
VOLUME ["/hostkeys/"]

# Do SSHD setup
COPY sshd_config /etc/ssh/sshd_config 

# Do user setup
RUN addgroup -g 1005 borg && adduser borg -D -G borg -h /home/borg -u 1000 && \
    sed -i s/borg:!/"borg:*"/g /etc/shadow && \
    mkdir /home/borg/.ssh 

# copy code to work directory
COPY . ./

CMD ["bash", "/code/borgbox.sh"]