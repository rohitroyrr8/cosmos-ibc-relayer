# Cosmos IBC Relayers local setup

Hands-on [Cosmos](https://cosmos.network) IBC Relayers setup (Hermes & Cosmos Go) for relaying packets, e.g. token transfers, between a local Cosmos/Ignite-based appchain and the CosmosHub Testnet (Theta, `theta-testnet-001`).

## IBC

Relayer algorithms provide the essential off-chain processes that share data between chains running the IBC protocol by scanning the state of each chain, constructing appropriate datagrams, and executing them on the opposite chain as permitted by the protocol.

Relaying is permissionless and trustless (the light client verification provides the trust).

The Inter-Blockchain Communication protocol ([IBC](https://ibcprotocol.org/)) is the basis for interoperability in Cosmos. 

## IBC Relayers

### Cosmos Go Relayer

Site: [IBC Go](https://ibc.cosmos.network/)

Maintainers: [Cosmos community](https://github.com/cosmos)

Github repo: [cosmos/relayer](https://github.com/cosmos/relayer)

Doc: [Cosmos tutorial](https://tutorials.cosmos.network/hands-on-exercise/5-ibc-adv/3-go-relayer.html)

Version used: `v2.2.0`

### Hermes Relayer

Web site: [Hermes](https://hermes.informal.systems/)

Maintainers: [Informal Systems](https://informal.systems)

Open-Source code repository: [informalsystems/ibc-rs](https://github.com/informalsystems/ibc-rs)

Doc: [commands](https://hermes.informal.systems/commands/index.html)

Version used: `hermes-cli@1.2.0`


## Build of Docker images

Refer to each dedicated `Dockerfile`
* appchain/Dockerfile: Your local Cosmos appchain image to build, via `appchain/build-image.sh`, `appchain/Makefile` or `docker-compose`
* relayer_go/Dockerfile: The IBC Go relayer to be cloned, installed and configured based on `relayer_go/configs`, via `docker-compose`
* relayer_hermes/Dockerfile: The Hermes IBC Relayer to be installed via Cargo and configured using `relayer_hermes/config.toml`, via `docker-compose`

To manually build your appchain **image** (actual default is the ICA Checkers game), by cloning an appchain code repository, run:

```
$ cd appchain
$ ./build-image.sh
```


## Start the network

You can use the provided compose file to spin up a network with 1 local blockchain and 1 IBC relayer. Specify the IBC relayer using the flag `--profile`. 

For the [`Cosmos Go relayer`](https://github.com/cosmos/relayer), use:

```
$ docker-compose --profile go up

```

For the [`Hermes`](https://github.com/informalsystems/hermes) relayer:

```
$ docker-compose --profile hermes up
```

Using `docker-compose up` the appchain container is instantiated, and the local blockchain ran via the generic command `ignite chain serve`.


## Start the relayer

When the chain is ready, you can start the relayer process. In a new terminal, jump into the relayer container:

```
$ docker exec -it relayer bash
```

And initialize and start the relayer process:

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
$ docker exec relayer hermes tx ft-transfer --src-chain appchain --dst-chain theta-testnet-001 --src-port transfer --src-channel channel-0 --amount 100 --denom token --timeout-height-offset 1000
```

And, check for the balances again. 

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
