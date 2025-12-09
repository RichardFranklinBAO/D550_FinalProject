DOCKER_IMAGE := richardfbao/d550-final-report:latest
PLATFORM     := linux/amd64

.PHONY: docker-build docker-push docker-report

docker-build:
	DOCKER_DEFAULT_PLATFORM=$(PLATFORM) docker build -t $(DOCKER_IMAGE) .

docker-push:
	docker push $(DOCKER_IMAGE)

# 生成报告到本机 ./report 目录
docker-report:
	mkdir -p report
	docker run --rm \
		-v "$(PWD)":/work \
		-v "$(PWD)/report":/out \
		-w /work \
		-e OUTDIR=/out \
		-e RENV_CONFIG_AUTOLOAD=FALSE \
		$(DOCKER_IMAGE)