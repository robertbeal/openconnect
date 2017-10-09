Built from https://github.com/dlenski/openconnect to get the additional Palo Alto Networks (PAN) authentication mode.

The below example uses `--read-only` mode (for a tiny bit of additional security). You will get errors that it can't flush or backup resolv.conf (both part of the vpnc script) but it all still works just fine. 

Use `-e ARGS=` for passing in command line parameters. 

```
docker run \
	--name openconnect \
	--net host \
	--read-only \
	--cap-add=NET_ADMIN \
	--device /dev/net/tun \
        -e ARGS="--protocol=gp <ip> --servercert sha256:<sha>" \
	-it robertbeal/openconnect:latest
```
