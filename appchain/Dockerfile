# This Dockerfile will: 
# set up a Golang environment(using Golang Docker Image)
# install Ignite
# clone the appchain repository
# start a appchain blockchain
# expose api endpoints

# Use Golang Docker Image
FROM golang:1.18

# Set working dir
WORKDIR /home/appchain

# Install tools
RUN apt-get install curl git

# Install ignite
RUN curl -L https://get.ignite.com/cli@v0.22.1! | bash

# Clone your appchain repository
RUN git clone -b wager-denomination https://github.com/cosmos/b9-checkers-academy-draft.git /home/appchain

# Copy Config.yml
ARG configyml
COPY ${configyml} /home/appchain/config.yml

# Optional - Build the appchain for an initial snapshot (and installing the dependencies)
RUN ignite chain build

# copy entrypoint script
COPY ./run-appchain.sh /home/appchain
RUN chmod +x ./run-appchain.sh

ENTRYPOINT ["/bin/bash", "-c", "/home/appchain/run-appchain.sh"]
EXPOSE 26657 1317 4500 9090

# Build with ./build-image.sh
