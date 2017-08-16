FROM mikewright/docker-dev-base:latest

MAINTAINER Mike Wright <mkwright@gmail.com>

# Install common dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y perl curl build-essential python libssl-dev git nano && \
    sudo docker-cleanup 

# Install node 

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

RUN sudo apt-get install -y nodejs


# Install vim plugins for node
ADD vimrc.bundles.local $HOME/.vimrc.bundles.local
RUN update-vim 
