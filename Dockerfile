FROM alpine:3.9

LABEL maintainer="Mizore <me@mizore.cn>"

ENV ROOT_PASSWORD root

# RUN echo 'https://mirrors.ustc.edu.cn/alpine/v3.9/main' > /etc/apk/repositories \

RUN apk add --no-cache \
           openssh \
    \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -h /var/cache/nginx -G www-data www-data \
    && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && echo "root:${ROOT_PASSWORD}" | chpasswd \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/

RUN chmod u+x /usr/local/bin/entrypoint.sh

WORKDIR /root

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
