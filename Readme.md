docker run \
	--name openconnect \
	--net host \
	--cap-add=NET_ADMIN \
	--device /dev/net/tun \
	-it robertbeal/openconnect:latest \
	--protocol=gp <ip> \
	--servercert sha256:<sha>
