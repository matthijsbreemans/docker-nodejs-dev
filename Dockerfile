FROM mikewright/docker-dev-base:ubuntu

MAINTAINER Mike Wright <mkwright@gmail.com>

# Install common dependencies
RUN apt-get update && \
    apt-get install -y perl curl build-essential python libssl-dev git && \
    /cleanup 

# Install node 
ENV NODE_VERSION=5.7.0
ENV NPM_VERSION=3
ENV NODE_PATH=/usr/lib/node_modules/

RUN curl -sSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o /node.tar.gz && \
    cd / && tar -C /usr/local --strip-components 1 -xzf node.tar.gz && \
    rm -f /node.*

ENV NPM_VERSION=3.7.5
ENV npm_install=$NPM_VERSION
RUN curl -L https://npmjs.org/install.sh | sh

# Install vim plugins for node
ADD vimrc.bundles.local /root/.vimrc.bundles.local
RUN /update-vim
