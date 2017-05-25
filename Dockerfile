FROM alpine:latest

WORKDIR /tmp

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk add --update --no-cache --virtual=build-dependencies \ 
		automake \
		autoconf \	
		gcc \
		g++ \
		gettext \
		git \
		linux-headers \
		libtool \
		libxml2-dev \
		make \
		openssl-dev \
		pkgconfig \
		wget \
		vpnc \
	
	&& git clone https://github.com/dlenski/openconnect.git \
	&& cd openconnect \
	&& git checkout b700994403b5a755550645d8e6ad0f7b14e31493 \
	&& ./autogen.sh \
	&& ./configure --with-vpnc-script=/etc/vpnc/vpnc-script --without-openssl-version-check \
	&& make install \
	&& apk del --purge build-dependencies \
	&& rm -rf /tmp/*

RUN apk add --no-cache \
		openssl \
		libxml2 \
		vpnc

ENTRYPOINT ["/usr/local/sbin/openconnect"]
CMD ["--help"]
