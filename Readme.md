
[![Build Status](https://travis-ci.org/robertbeal/openconnect.svg?branch=master)](https://travis-ci.org/robertbeal/openconnect)
[![](https://images.microbadger.com/badges/image/robertbeal/openconnect.svg)](https://microbadger.com/images/robertbeal/openconnect "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/robertbeal/openconnect.svg)](https://microbadger.com/images/robertbeal/openconnect "Get your own version badge on microbadger.com")
[![](https://img.shields.io/docker/pulls/robertbeal/openconnect.svg)](https://hub.docker.com/r/robertbeal/openconnect/)
[![](https://img.shields.io/docker/stars/robertbeal/openconnect.svg)](https://hub.docker.com/r/robertbeal/openconnect/)
[![](https://img.shields.io/docker/automated/robertbeal/openconnect.svg)](https://hub.docker.com/r/robertbeal/openconnect/)

Built from https://github.com/dlenski/openconnect to get the additional Palo Alto Networks (PAN) authentication mode.

The below example uses `--read-only` mode (for a tiny bit of additional security, you must include the `--tmpfs` parameter if using read-only mode).

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
    --memory="512m" \
    -v /etc/resolv.conf:/etc/resolv.conf \
    --security-opt="no-new-privileges:true" \
    --interactive \
    --tty \
    robertbeal/openconnect:latest --protocol=gp <ip> --servercert sha256:<sha>
```

## Small Issue

SIGTERM works (ie `docker stop openconnect`) but not in an elegant fashion. The `vpnc-script` doesn't revert the /etc/resolv.conf so you may find your hosts `/etc/resolv.conf` is left in a messy state. When I have time I need to find out why openconnect isn't shutting down cleanly. 

SIGINIT (ie `ctrl+c`) however does fully work.
