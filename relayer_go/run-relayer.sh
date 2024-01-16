#!/bin/sh

rly config init
rly chains add-dir configs
rly paths add-dir paths

rly keys restore appchain alice "cinnamon legend sword giant master simple visit action level ancient day rubber pigeon filter garment hockey stay water crawl omit airport venture toilet oppose"
rly keys restore theta-testnet-001 alice "cinnamon legend sword giant master simple visit action level ancient day rubber pigeon filter garment hockey stay water crawl omit airport venture toilet oppose"

rly tx link demo -d -t 3s
rly start demo