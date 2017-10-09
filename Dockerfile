FROM alpine:3.6

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
	&& git checkout c49d46f0a69082d8f402c4a4675e021b481fbcad \
	&& ./autogen.sh \
	&& ./configure --with-vpnc-script=/etc/vpnc/vpnc-script --without-openssl-version-check \
	&& make install \
	&& apk del --purge build-dependencies \
	&& rm -rf /tmp/*

RUN apk add --no-cache \
		openssl \
		libxml2 \
		tini \
		vpnc

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
