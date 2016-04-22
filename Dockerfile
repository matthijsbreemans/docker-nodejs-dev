FROM mikewright/docker-dev-base:latest

MAINTAINER Mike Wright <mkwright@gmail.com>

# Install common dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y perl curl build-essential python libssl-dev git && \
    sudo docker-cleanup 

# Install node 
ENV NODE_VERSION=5.7.0
ENV NPM_VERSION=3
ENV NODE_PATH=/usr/lib/node_modules/

ENV NODE_HOME $HOME/node
RUN curl -sSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o $HOME/node.tar.gz && \
    mkdir -p $HOME/node && \
    cd $HOME && sudo tar -C /usr/local --strip-components 1 -xzf node.tar.gz && \
    rm -f $HOME/node.*

ENV PATH $PATH:$HOME/node

ENV NPM_VERSION=3.7.5
ENV npm_install=$NPM_VERSION
RUN curl -L https://npmjs.org/install.sh | sudo sh && \
    mkdir -p $(npm config get prefix)/lib/node_modules && \
    sudo chown -R docker-user $(npm config get prefix)/lib/node_modules && \
    sudo chown -R docker-user $(npm config get prefix)/bin && \
    sudo chown -R docker-user $(npm config get prefix)/share

# Install vim plugins for node
ADD vimrc.bundles.local $HOME/.vimrc.bundles.local
RUN update-vim 
