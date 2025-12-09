# Makefile
.PHONY: docker-build docker-report report clean help

IMG = richardfbao/d550-final-report:latest

docker-build:
	docker build --platform=linux/amd64 -t $(IMG) .

# 评分使用的目标：挂载本地 report/，生成报告到本地
docker-report:
	mkdir -p report
	docker run --rm \
		-v "$(PWD)":/work \
		-v "$(PWD)/report":/out \
		-w /work \
		-e OUTDIR=/out \
		$(IMG)

# 便捷别名
report: docker-report

clean:
	rm -rf report

help:
	@echo "make docker-build  # building docker"
	@echo "make report        # generating report to ./report/R_Project.html"
	@echo "make clean         # deleting report/"