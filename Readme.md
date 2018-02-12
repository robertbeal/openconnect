
[![Build Status](https://travis-ci.org/robertbeal/openconnect.svg?branch=master)](https://travis-ci.org/robertbeal/openconnect)
[![](https://images.microbadger.com/badges/image/robertbeal/openconnect.svg)](https://microbadger.com/images/robertbeal/openconnect "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/robertbeal/openconnect.svg)](https://microbadger.com/images/robertbeal/openconnect "Get your own version badge on microbadger.com")
[![](https://img.shields.io/docker/pulls/robertbeal/openconnect.svg)](https://hub.docker.com/r/robertbeal/openconnect/)
[![](https://img.shields.io/docker/stars/robertbeal/openconnect.svg)](https://hub.docker.com/r/robertbeal/openconnect/)
[![](https://img.shields.io/docker/automated/robertbeal/openconnect.svg)](https://hub.docker.com/r/robertbeal/openconnect/)

Built from https://github.com/dlenski/openconnect to get the additional Palo Alto Networks (PAN) authentication mode.

The below example uses `--read-only` mode (for a tiny bit of additional security, you must include the `--tmpfs` parameter if using read-only mode). You will get errors that it can't flush or backup resolv.conf (both part of the vpnc script) but it all still works just fine. 

```
docker run \
    --name openconnect \
    --net host \
    --read-only \
    --tmpfs /var/run/vpnc:rw,size=1000k \
    --cap-add=NET_ADMIN \
    --device /dev/net/tun \
    --pids-limit 50 \
    --cpus="1" \
    --memory="256m" \
    -v /etc/resolv.conf:/etc/resolv.conf \
    --interactive \
    --tty \
    robertbeal/openconnect:latest --protocol=gp <ip> --servercert sha256:<sha>
```
