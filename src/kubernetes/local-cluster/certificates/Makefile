SHELL := /bin/bash

CUSTOMER ?= com.gft.officeday
PROJECT ?= com.gft.officeday.isio.testing-in-production-1
MODULE ?= infrastructure
COMPONENT ?= certificates
TARGET ?= $(PROJECT).$(MODULE).$(COMPONENT)
KUBERNETES_NAMESPACE :=$(shell echo "$$PROJECT" | sed 's/[^a-zA-Z0-9_-]/-/g' )

TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell ( git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

all: terraform

.PHONY: lib bin docker clean distclean dep include

terraform: terraform.state
terraform.state: 10-ca.tf 20-app.tf
	@terraform init
	@terraform apply -auto-approve
	@kubectl delete  -n istio-system secret app.localgft || exit 0
	@kubectl create -n istio-system secret tls app.localgft --key=data/app.key.private --cert=data/app.cert

secret:
	@kubectl delete  -n istio-system secret app.localgft || exit 0
	@kubectl create -n istio-system secret tls app.localgft --key=data/app.key.private --cert=data/app.cert

lib:

include:

bin:

dist:

dep:

docker:

kubernetes: 

ls:

clean: 
	@echo "### KUB / CLEAN $(KUBERNETES_NAMESPACE) - certificates"
	@ rm -f data/*

clean-ns:

distclean: clean
	@echo "### KUB / DCLN  $(KUBERNETES_NAMESPACE) - certificates"
	@rm -rf .terraform terraform.tfstate* .terraform.lock.hcl
	@kubectl delete  -n istio-system secret app.localgft

docker-clean:

docker-distclean:

ls:

docker-ls:

test:

docker-test:

