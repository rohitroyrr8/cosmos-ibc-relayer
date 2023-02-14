# cosmos-ibc-relayer
IBC relayers setup (Hermes & ibc-go) for testing the relay of token transfers from a local appchain to the CosmosHub testnet (Theta)


## Build Docker images

to build your appchain **image** (default is the ICA Checkers game here), clone the repository and run:

```
$ cd appchain
$ ./build-image.sh
```

## Start the network

You can use the provided compose file to spin up a network with 1 local blockchain and a relayer. You can determine with the `--profile` flag, which relayer should be used. 

For the [`ibc-go`](https://github.com/cosmos/relayer) relayer, use:

```
$ cd cosmos-ibc-docker/tokentransfer
$ docker-compose --profile go up

```

For the [`Hermes`](https://github.com/informalsystems/hermes) relayer:

```
$ docker-compose --profile hermes up
```


## Start the relayer

When the chain is ready, you can start the relayer process. In a new terminal, jump into the relayer container:

```
$ docker exec -it relayer bash
```

in it, initialize and start the relayer process:

```
$ ./run-relayer.sh 
```

## Transfer some token (Hermes Relayer)

The chain has pre-created accounts with some token. In a new terminal, check the balance of the accounts:

```
$ docker exec appchain checkersd query bank balances cosmos14y0kdvznkssdtal2r60a8us266n0mm97r2xju8
```

You can use the relayer to send an IBC transaction:

```
$ docker exec relayer hermes tx ft-transfer --src-chain appchain --dst-chain theta-testnet-001 --src-port transfer --src-channel channel-000 --amount 100 --denom token --timeout-height-offset 1000
```

And, check the balances again. 

## Transfer some token (Go Relayer)

The chains have pre-created accounts with some token. In a new terminal, check the balance of the accounts:

```
$ docker exec relayer rly q bal appchain
$ docker exec relayer rly q bal theta-testnet-001
```

You can check the addresses with:

```
$ docker exec relayer rly chains address appchain
$ docker exec relayer rly chains address theta-testnet-001
```

You can use the relayer to send an IBC transaction:

```
$ docker exec relayer rly tx transfer checkers theta-testnet-001 10token cosmos173czeq76k0lh0m6zcz72yu6zj8c6d0tf294w5k channel-000
```

And, check the balances again. 
