.PHONY : docker-status docker-create docker-stop docker-rm-container docker-rm-image docker-build-image docker-create docker-start

DOCKER_LABEL = appchain
DOCKER_IMG = $(DOCKER_LABEL)_i
WORK_DIR = /home/appchain
APP_EXEC = checkersd

build-image:
	docker build -f Dockerfile . -t $(DOCKER_IMG) --build-arg configyml=./config.yml
	docker image ls $(DOCKER_IMG)
	docker exec --rm -it $(DOCKER_IMG) ignite version

create:
	docker create --name $(DOCKER_LABEL) -i \
		-p 1317:1317 -p 4500:4500 -p 26657:26657 -p 9090:9090 \
		$(DOCKER_IMG)
#		-v $(PWD):$(WORK_DIR) \
#		-w $(WORK_DIR) \

start:
	docker start $(DOCKER_LABEL)

sh:
	docker exec -it $(DOCKER_LABEL) /bin/bash

stop:
	docker stop $(DOCKER_LABEL)

rm: stop-container
	docker container rm -f $(DOCKER_LABEL)

rm-image: docker-rm-container
	docker image rm -f $(DOCKER_IMG)

#	---------------------------------------------------------------
#
#	Targets to be initiated from workspace/$(WORK_DIR)
#

docker-serve-tmp:
	docker run --rm -it \
		-v $(PWD):$(WORK_DIR) \
		-w $(WORK_DIR) \
		-p 1317:1317 -p 4500:4500 -p 26657:26657 -p 9090:9090 \
		--name $(DOCKER_LABEL)-tmp \
		$(DOCKER_IMG) \
		ignite chain serve

docker-create-net:
	docker network create $(DOCKER_LABEL)_net

docker-rm-net:
	docker network rm $(DOCKER_LABEL)_net

docker-serve-net:
	docker run --rm -it \
		-v $(PWD):/$(WORK_DIR) \
		-w /$(WORK_DIR) \
		--network $(DOCKER_LABEL)_net \
		--name $(DOCKER_LABEL)-serve \
		$(DOCKER_IMG) \
		ignite chain serve

docker-serve:
	docker exec -it $(DOCKER_LABEL) ignite chain serve

docker-serve-reset:
	docker exec -it $(DOCKER_LABEL) ignite chain serve --reset-once

docker-status-chain:
	docker exec -it $(DOCKER_LABEL) $(APP_EXEC) status 2>&1 | jq


docker-client-test-net:
	cd $(WORK_CLIENT_DIR)
	docker run --rm \
		-v $(PWD)/$(WORK_CLIENT_DIR):/$(WORK_CLIENT_DIR) \
		-w /$(WORK_CLIENT_DIR) \
		--network $(DOCKER_LABEL)-net \
		node:18.7 \
		npm test

#
# Keys management - utilities
#

shexport-addr:
	export alice=`checkersd keys show alice -a`
	export bob=`checkersd keys show bob -a`

chown:
	sudo chown -R `whoami`:`whoami` $(PWD)/*
