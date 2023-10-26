FROM alpine:latest
MAINTAINER GoodbyeNJN <cc@fuckwall.cc>

ARG USE_PRE_RELEASE="0"

RUN pkg_name=$(if [ -z "$USE_PRE_RELEASE" ] || [ "$USE_PRE_RELEASE" -eq 0 ]; then echo "tinc"; elif [ "$USE_PRE_RELEASE" -eq 1 ]; then echo "tinc-pre"; fi) && \
    apk add --no-cache "$pkg_name"

EXPOSE 655
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/sbin/tinc" ]
CMD [ "start", "-D" ]
