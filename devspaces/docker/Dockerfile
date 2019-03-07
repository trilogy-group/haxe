FROM buildpack-deps:stretch-scm

# ensure local haxe is preferred over distribution haxe
ENV PATH /usr/local/bin:$PATH

# runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgc1c2 \
        zlib1g \
        libpcre3 \
        libmariadb2 \
        libsqlite3-0 \
        libmbedcrypto0 \
        libmbedtls10 \
        libmbedx509-0 \
        rsync \
        vim \
        python3 \
        \
        # Haxe Target languages
        mono-devel mono-mcs \
        \
    && apt-get install -qq -yy pkg-config \
    && rm -rf /var/lib/apt/lists/*
#
# install neko, which is a dependency of haxelib
#
ENV NEKO_VERSION 2.2.0
RUN set -ex \
    && buildDeps=' \
        gcc \
        make \
        cmake \
        libgc-dev \
        libssl-dev \
        libpcre3-dev \
        zlib1g-dev \
        apache2-dev \
        libmariadb-client-lgpl-dev-compat \
        libsqlite3-dev \
        libmbedtls-dev \
        libgtk2.0-dev \
    ' \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    \
    && wget -O neko.tar.gz "https://github.com/HaxeFoundation/neko/archive/v2-2-0/neko-2.2.0.tar.gz" \
    && echo "cf101ca05db6cb673504efe217d8ed7ab5638f30e12c5e3095f06fa0d43f64e3 *neko.tar.gz" | sha256sum -c - \
    && mkdir -p /usr/src/neko \
    && tar -xC /usr/src/neko --strip-components=1 -f neko.tar.gz \
    && rm neko.tar.gz \
    && cd /usr/src/neko \
    && cmake -DRELOCATABLE=OFF . \
    && make \
    && make install \
    \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /usr/src/neko ~/.cache \
    && rm -rf /var/lib/apt/lists/*

#
# Install haxe deps
#
ENV AXE_DIR=/data 
WORKDIR $AXE_DIR

RUN set -ex \
    && buildDeps=' \
        make \
        ocaml-nox \
        ocaml-native-compilers \
        camlp4 \
        ocaml-findlib \
        zlib1g-dev \
        libpcre3-dev \
        libxml-light-ocaml-dev \
        \
    ' \
    && cd $AXE_DIR \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf $AXE_DIR ~/.cache

# install opam
RUN apt-get update && apt-get install -y --no-install-recommends \
    opam \
    && rm -rf /var/lib/apt/lists/* \
    && opam init -a && eval `opam config env` \
    && opam depext conf-pkg-config.1.1

ENV HAXE_VERSION 3.4.8
ENV HAXE_STD_PATH=/usr/lib/haxe/std
ENV HAXEPATH=/usr/lib/haxe
ENV HAXE_HOME=$HAXEPATH
ENV HAXELIB_PATH=/usr/lib/haxe/lib
ENV PATH=$PATH:$HAXEPATH:$HAXELIB_PATH

#
# Install Target runtime nodejs
#
RUN mkdir -p /tmp/node \
    && curl -sL https://deb.nodesource.com/setup_10.x > /tmp/node/setup_10.x \
    && chmod +x /tmp/node/setup_10.x \
    && /tmp/node/setup_10.x \
    && apt-get -qq update \
    && apt-get -qqy install nodejs \
    && rm -rf /tmp/node \
    && rm -rf /var/lib/apt/lists/*

CMD tail -f /dev/null
