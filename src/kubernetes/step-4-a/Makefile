SHELL := /bin/bash

CUSTOMER ?= com.gft.deuba
PROJECT ?= com.gft.deuba.unity.release-1
MODULE ?= infrastructure
COMPONENT ?= step-4-a
TARGET ?= $(PROJECT).$(MODULE).$(COMPONENT)
KUBERNETES_NAMESPACE :=$(shell echo "$$PROJECT" | sed 's/[^a-zA-Z0-9_-]/-/g' )

TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell ( git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

all: 

.PHONY: lib bin docker clean distclean dep include

lib:

include:

bin:

dist:

dep:

docker:

kubernetes: 

clean:
	@echo "### KUB / CLEAN $(KUBERNETES_NAMESPACE)"
	@CMD="" ; \
	while read f ; do \
	    CMD="$$CMD -f $$f" ; \
	done < <( find . -type f  -not -name "*namespace*" \( -name "*.yml" -o -name "*.yaml" \) ) ; \
	kubectl delete $$CMD 2>/dev/null || exit 0

distclean: clean
	@echo "### KUB / DCLN  $(KUBERNETES_NAMESPACE)"
	@kubectl delete namespace $(KUBERNETES_NAMESPACE).step-4 2> /dev/null || exit 0

docker-clean:

docker-distclean:

ls:

docker-ls:

test:

docker-test:

