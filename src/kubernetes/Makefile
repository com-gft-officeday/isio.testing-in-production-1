SHELL := /bin/bash

CUSTOMER ?= com.gft.deuba
PROJECT ?= com.gft.deuba.unity.release-1
TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell ( git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

SUBDIRS = local-setup certificates step-1-a step-1-b step-2 step-3 step-4-a step-4-b step-4-c step-4-d

all: local-setup certificates

.PHONY: lib bin docker clean distclean dep include local-setup certificates

lib:

include:

bin:

dist:

dep:

docker:
	@make -C ../docker all

kubernetes: docker 
	@for dir in $(SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir kubernetes; \
	done

certificates:
	@TIMESTAMP="$(TIMESTAMP)" \
	GITHASH="$(GITHASH)" \
	CUSTOMER="$(CUSTOMER)" \
	PROJECT="$(PROJECT)" \
	make -C  $$dir certificates
	
local-setup:
	@TIMESTAMP="$(TIMESTAMP)" \
	GITHASH="$(GITHASH)" \
	CUSTOMER="$(CUSTOMER)" \
	PROJECT="$(PROJECT)" \
	make -C  $$dir local-setup

ls:
	@echo "### KUB / LS    $(KUBERNETES_NAMESPACE)"
	@for o in $$( kubectl api-resources --namespaced=true --verbs=delete -o name | sort ) ; do \
	  kubectl get -n $(KUBERNETES_NAMESPACE) "$$o" 2>/dev/null | sed -e '1i\'$$'\n'"    $$o" -e 's/^/        /' ; \
	done

clean: clean-ns
	@for dir in $(SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir clean ; \
	done

clean-ns:
	@echo "### KUB / NSCLN $(KUBERNETES_NAMESPACE)"
	@kubectl delete namespace "$(KUBERNETES_NAMESPACE)" 2>/dev/null || exit 0
	@kubectl delete -f ../common/  2>/dev/null || exit 0

distclean:
	@for dir in $(SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir distclean ; \
	done

docker-clean:

docker-distclean:

ls:

docker-ls:

test:

docker-test:

