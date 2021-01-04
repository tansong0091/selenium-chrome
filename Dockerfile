FROM selenium/4.0.0-beta-1-prerelease-20201208

#COPY entrypoint.sh /entrypoint.sh
WORKDIR /app
USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils openssh-server procps vim python3-pip \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && mkdir -p /var/run/sshd \
    # SSH login fix. Otherwise user is kicked off after login
    && sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd \
    && pip3 install selenium

COPY sshd_config /etc/ssh/sshd_config

USER seluser
EXPOSE 4444 5900 10022 
#ENTRYPOINT ["/entrypoint.sh"]
