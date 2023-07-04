FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV PUID 1000
ENV PGID 1000
ENV USER_NAME backups

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server rsync && \
    apt-get clean && \
    mkdir /var/run/sshd && \
    mv /etc/ssh /etc/ssh-template && \
    ln -s /config /etc/ssh && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
