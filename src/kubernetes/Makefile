SHELL := /bin/bash

CUSTOMER ?= com.gft.deuba
PROJECT ?= com.gft.deuba.unity.release-1
TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell ( git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

SUBDIRS = local-setup step-1-a step-1-b step-2 step-3 step-4-a step-4-b step-4-c step-4-d

all: 

.PHONY: lib bin docker clean distclean dep include

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

clean:
	@for dir in $(SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir clean ; \
	done

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

