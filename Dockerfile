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
    sed \
    wget \
    vpnc \
  && git clone https://github.com/dlenski/openconnect.git \
  && cd openconnect \
  && git checkout 89b4f414b75cf684f1d055f720b4686f603461f4 \
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

# suppress read-only flush errors
RUN sed -i '/$IPROUTE route flush cache/d' /etc/vpnc/vpnc-script

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
