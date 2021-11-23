SHELL := /bin/bash

CUSTOMER ?= com.gft.deuba
PROJECT ?= com.gft.deuba.unity.release-1
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
	@echo "### KUB / CLEAN $(PROJECT).$(MODULE).$(COMPONENT) - step-1-a"
	@CMD="" ; \
	while read f ; do \
	    CMD="$$CMD -f $$f" ; \
	done < <( find . -type f \( -name "*.yml" -o -name "*.yaml" \) ) ; \
	kubectl delete $$CMD 2>/dev/null || exit 0

distclean: clean

docker-clean:

docker-distclean:

ls:

docker-ls:

test:

docker-test:

