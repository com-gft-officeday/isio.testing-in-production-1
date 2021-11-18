SHELL := /bin/bash

CUSTOMER ?= com.gft.deuba
PROJECT ?= com.gft.deuba.unity.release-1

TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell (  git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

COMPONENTS := ms-measure ms-random fe-measure

all: docker

.PHONY: docker docker-clean clean docker-distclean distclean $(COMPONENTS) docker-ls ls docker-test test 

docker:
	@pwd
	@for dir in $(COMPONENTS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  ../go/$$dir docker ; \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir all ; \
	done

docker-clean clean:
	@for dir in $(COMPONENTS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  ../go/$$dir docker-clean ; \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir clean ; \
	done

docker-distclean distclean:
	@for dir in $(COMPONENTS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C ../go/$$dir docker-distclean ; \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C $$dir distclean ; \
	done
	@for image in $$( docker image ls --filter "label=PROJECT=$(PROJECT)" --format "{{.ID}}" ) ; do \
		for container in $$(docker container ls --filter "ancestor=$$image" --format "{{.ID}}" ) ; do \
			docker container stop --time 5 "$$container" ; \
		done ; \
		docker image rm -f $$image ; \
	done

docker-ls ls:
	@for dir in $(COMPONENTS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C  $$dir ls ; \
	done

docker-test test:
	@echo "GITHASH: $(GITHASH)"
	@for dir in $(BINS_SUBDIRS) $(LIBS_SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C ../go/$$dir docker-test; \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
	    CUSTOMER="$(CUSTOMER)" \
	    PROJECT="$(PROJECT)" \
		make -C $$dir test; \
	done
