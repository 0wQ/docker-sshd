FROM alpine:3.10

LABEL maintainer="Mizore <me@mizore.cn>"

ENV ROOT_PASSWORD root

RUN echo 'https://mirrors.ustc.edu.cn/alpine/v3.10/main' > /etc/apk/repositories \

RUN apk add --no-cache \
           openssh \
    \
    && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "root:${ROOT_PASSWORD}" | chpasswd \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/

RUN chmod u+x /usr/local/bin/entrypoint.sh

WORKDIR /root

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
