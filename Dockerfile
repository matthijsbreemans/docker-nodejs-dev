FROM mikewright/docker-dev-base:latest

MAINTAINER Mike Wright <mkwright@gmail.com>

# Install common dependencies
RUN apk add --no-cache perl curl make gcc g++ binutils-gold python linux-headers paxctl libgcc libstdc++ && \
  /cleanup

# Install node 
ENV NODE_VERSION=v5.7.0
ENV NPM_VERSION=3
ENV NODE_PATH=/usr/lib/node_modules/

RUN curl -sSL https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION.tar.gz -o /node.tar.gz && \
  cd / && gunzip node.tar.gz && tar -xvf node.tar && \
  cd /node-$NODE_VERSION && ./configure --prefix=/usr --fully-static --without-npm && \
  make && make install && \
  rm /node.tar 

ENV NPM_VERSION=3.7.5
RUN apk add --no-cache perl && \
    rm -rf /usr/lib/node_modules/npm && \
    mkdir -p /tmp/src && \
    curl -L https://github.com/npm/npm/archive/v$NPM_VERSION.tar.gz -o /npm.tar.gz && \
    cd / && gunzip npm.tar.gz && tar -xvf npm.tar && \
    cd /npm-$NPM_VERSION && ./configure --prefix=/usr &&  make && make install

# Install vim plugins for node
ADD vimrc.bundles.local /root/.vimrc.bundles.local
RUN /update-vim
