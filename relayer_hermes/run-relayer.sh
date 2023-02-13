#!/bin/sh

hermes keys add --chain appchain --mnemonic-file "alice.json"
hermes keys add --chain theta-testnet-001 --mnemonic-file "alice.json"

hermes create channel --a-chain appchain --b-chain theta-testnet-001 --a-port transfer --b-port transfer --new-client-connection
hermes start