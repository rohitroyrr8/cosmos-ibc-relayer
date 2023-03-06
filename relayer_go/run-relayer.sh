#!/bin/sh

rly config init
rly chains add-dir configs
rly paths add-dir paths

rly keys restore appchain alice "cinamon legend ..."
rly keys restore theta-testnet-001 alice "cinamon legend ..."

rly tx link demo -d -t 3s
rly start demo