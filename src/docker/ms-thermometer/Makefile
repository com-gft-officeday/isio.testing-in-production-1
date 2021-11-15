SHELL := /bin/bash
GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/  */\n/g' ; git rev-parse HEAD  ) | sort -u )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )
PROJECT ?= com.gft.deuba.unity.release-1
COMPONENT ?= ms-thermometer

CP ?= cp -pv
MKDIR ?= mkdir -p
LN ?= ln
RM ?= rm

all: docker

.PHONY: clean distclean docker ls

docker: ../dist/$(COMPONENT)-build.iid ../dist/$(COMPONENT)-v1.iid ../dist/$(COMPONENT)-v2.iid ../dist/$(COMPONENT)-v3.iid

../dist/$(COMPONENT)-build.iid: Dockerfile-build ../../go/$(COMPONENT)/*/*.go \
						 ../../go/$(COMPONENT)/Makefile
	@if [ -f "../dist/$(COMPONENT)-build.iid" ] ; then i=$$( cat "../dist/$(COMPONENT)-build.iid" ); docker image rm -f $$i ; rm -f "../dist/$(COMPONENT)-build.iid"  2>/dev/null ; fi
	@docker image build -f ./Dockerfile-build \
	  --build-arg GITHASH="$(_GITHASH)" \
	  --build-arg TIMESTAMP="$(TIMESTAMP)" \
	  --build-arg COMPONENT=$(COMPONENT) \
	  --tag $(PROJECT).$(COMPONENT):build \
	  --label PROJECT="$(PROJECT)" \
	  --label GITHASH="$(_GITHASH)" \
	  --label COMPONENT=$(COMPONENT) \
	  --label BUILDSTAMP="$(TIMESTAMP)" \
	  --iidfile "../dist/$(COMPONENT)-build.iid" \
	  ../..

../dist/$(COMPONENT)-v1.iid: Dockerfile-v1 ../dist/$(COMPONENT)-build.iid
	@if [ -f "../dist/$(COMPONENT)-v1.iid" ] ; then i=$$( cat "../dist/$(COMPONENT)-v1.iid" ); docker image rm -f $$i ; rm -f "../dist/$(COMPONENT)-v1.iid"  2>/dev/null ; fi
	@docker image build -f ./Dockerfile-v1 \
	  --build-arg GITHASH="$(_GITHASH)" \
	  --build-arg TIMESTAMP="$(TIMESTAMP)" \
	  --build-arg COMPONENT=$(COMPONENT) \
	  --tag $(PROJECT).$(COMPONENT):v1 \
	  --label PROJECT="$(PROJECT)" \
	  --label GITHASH="$(_GITHASH)" \
	  --label COMPONENT=$(COMPONENT) \
	  --label BUILDSTAMP="$(TIMESTAMP)" \
	  --iidfile "../dist/$(COMPONENT)-v1.iid" \
	  ../..

../dist/$(COMPONENT)-v2.iid: Dockerfile-v2 ../dist/$(COMPONENT)-build.iid
	@if [ -f "../dist/$(COMPONENT)-v2.iid" ] ; then i=$$( cat "../dist/$(COMPONENT)-v2.iid" ); docker image rm -f $$i ; rm -f "../dist/$(COMPONENT)-v2.iid"  2>/dev/null ; fi
	@docker image build -f ./Dockerfile-v2 \
	  --build-arg GITHASH="$(_GITHASH)" \
	  --build-arg TIMESTAMP="$(TIMESTAMP)" \
	  --build-arg COMPONENT=$(COMPONENT) \
	  --tag $(PROJECT).$(COMPONENT):v2 \
	  --label PROJECT="$(PROJECT)" \
	  --label GITHASH="$(_GITHASH)" \
	  --label COMPONENT=$(COMPONENT) \
	  --label BUILDSTAMP="$(TIMESTAMP)" \
	  --iidfile "../dist/$(COMPONENT)-v2.iid" \
	  ../..

../dist/$(COMPONENT)-v3.iid: Dockerfile-v3 ../dist/$(COMPONENT)-build.iid
	@if [ -f "../dist/$(COMPONENT)-v3.iid" ] ; then i=$$( cat "../dist/$(COMPONENT)-v3.iid" ); docker image rm -f $$i ; rm -f "../dist/$(COMPONENT)-v3.iid"  2>/dev/null ; fi
	@docker image build -f ./Dockerfile-v3 \
	  --build-arg GITHASH="$(_GITHASH)" \
	  --build-arg TIMESTAMP="$(TIMESTAMP)" \
	  --build-arg COMPONENT=$(COMPONENT) \
	  --tag $(PROJECT).$(COMPONENT):v3 \
	  --label PROJECT="$(PROJECT)" \
	  --label GITHASH="$(_GITHASH)" \
	  --label COMPONENT=$(COMPONENT) \
	  --label BUILDSTAMP="$(TIMESTAMP)" \
	  --iidfile "../dist/$(COMPONENT)-v3.iid" \
	  ../..
clean:
	@for v in build v1 v2 v3 ; do  \
	    if [ -f "../dist/$(COMPONENT)-$$v.iid" ] ; then \
	        i=$$( cat "../dist/$(COMPONENT)-$$v.iid" ); \
	        for container in $$(docker container ls --filter "ancestor=$$i" --format "{{.ID}}" ) ; do \
	            docker container stop --time 5 "$$container" ; \
	        done ; \
	        docker image rm -f $$i ; \
	        rm -f "../dist/$(COMPONENT)-$$v.iid" ; \
	    fi ; \
	done

distclean: clean
	@for image in $$( docker image ls --filter "label=PROJECT=$(PROJECT)" --filter "label=COMPONENT=$(COMPONENT)" --format "{{.ID}}"  ) ; do \
	    for container in $$(docker container ls --filter "ancestor=$$image" --format "{{.ID}}" ) ; do \
	        docker container stop --time 5 "$$container" ; \
	    done ; \
	    docker image rm -f $$image ; \
	done

ls:
	@while read img imgname ; do \
		echo "I $$img $$imgname" ; \
		while read id state name image ; do \
			printf 'C %-7s %-10s %-20s %s\n' "$$id" "$$state" "$$name" "$$image" ; \
		done < <( docker container ls --filter "ancestor=$$img" --format='{{.ID}} {{.State}} {{.Names}} {{.Image}}'  | sort ) ; \
	done < <(docker image ls --filter "label=PROJECT=$(PROJECT)" --filter "label=COMPONENT=$(COMPONENT)" --format='{{.ID}} {{.Repository}}:{{.Tag}}' | sort -k 2 )

test:
	@echo "GITHASH: $(_GITHASH)"
	
-include $(DEPS)
