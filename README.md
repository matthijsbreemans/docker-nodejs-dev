JS Development Environment
----------------------------------

This is a docker container that I use as my js development environment.  This allows me to have a system fully catered towards
js development (including vim as the ide).  

## Usage

To start up just the node shell to try out this container, run the following command

    docker run -it mikewright/js-dev erl

If you are using this as your development environment just attach the volume with your source code to the container and
you can start coding.  This volume can be mapped anywhere, but the image is specifically setup to have the volume mounted
at `/src`    

    docker run -it -v $PWD:/src mikewright/js-dev

## Pieces

Based on a common dev image


