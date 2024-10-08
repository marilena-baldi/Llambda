.DEFAULT_GOAL := help
SHELL := /bin/bash

include .env

help: ## Show this help
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

build: ## Build docker containers
	docker build -t ${SERVICE} .

download: ## Download model
	curl -L "${MODEL_URL}" -o ./modelfile.gguf

ecr-login: ## Login into ECR
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(ECR)

tag: ## Tag docker containers
	docker tag $(SERVICE) $(ECR)/$(REPOSITORY):$(TAG)

push: ## Push docker containers
	docker push $(ECR)/$(REPOSITORY):$(TAG)
