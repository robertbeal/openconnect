Built from https://github.com/dlenski/openconnect to get the additional Palo Alto Networks (PAN) authentication mode.

```
docker run \
	--name openconnect \
	--net host \
	--cap-add=NET_ADMIN \
	--device /dev/net/tun \
	-it robertbeal/openconnect:latest \
	--protocol=gp <ip> \
	--servercert sha256:<sha>
```
