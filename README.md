# tinc for Docker

> [tinc](http://www.tinc-vpn.org) is a Virtual Private Network (VPN) daemon that uses tunnelling and encryption to create a secure private network between hosts on the Internet.

This Dockerfile is used to build a tinc image, where tinc is packaged by Alpine.

This image has two main tags: `stable` for latest stable version 1.0.36, `pre` for latest pre-release version 1.1pre18.

## Usage

The default entrypoint is `/usr/sbin/tinc`, you can pass command directly to it, for example: `docker run goodbyenjn/tinc init`. The configuration directory of tinc is `/etc/tinc` and is persisted as a volume.

Tinc requires access permission of `/dev/net/tun` device to create interface. To allow the container to access the device and grant `NET_ADMIN` capability, use `--device=/dev/net/tun --cap-add NET_ADMIN`.

To make VPN accessible to host, the network mode needs to be set to `host`, use `--net=host`.

Example:

```shell
docker run -d \
    --name tinc \
    --net=host \
    --device=/dev/net/tun \
    --cap-add NET_ADMIN \
    --volume /data/tinc:/etc/tinc \
    goodbyenjn/tinc start -D
```

If using docker-compose, example:

```yaml
version: "3"
services:
  app:
    image: goodbyenjn/tinc
    container_name: tinc
    devices:
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    network_mode: host
    restart: always
    volumes:
      - /data/tinc:/etc/tinc
    command: start -D
```
