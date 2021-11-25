SHELL := /bin/bash

CUSTOMER ?= com.gft.deuba
PROJECT ?= com.gft.deuba.unity.release-1
MODULE ?= frontend
COMPONENT ?= fe-weatherstation
TARGET ?= $(PROJECT).$(MODULE).$(COMPONENT)

TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell (  git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

CP ?= cp -pv
MKDIR ?= mkdir -p
LN ?= ln
RM ?= rm

BUILD_DIR ?= ./build/

DOCKER_DIR   ?= $(BUILD_DIR)/docker
DOCKER_VARIANT ?= alpine
DOCKER_IMAGES:= gcp kubernetes-nodeport kubernetes-istio docker-compose development

SRCS := $(shell (find ../../angular/$(COMPONENT)  -type f -not -path '*/node_modules/*' ) )
all: docker

.PHONY: docker-clean clean docker-distclean distclean docker docker-ls ls docker-test test

docker: $(DOCKER_DIR)/$(TARGET)-gcp.iid \
	$(DOCKER_DIR)/$(TARGET)-kubernetes-nodeport.iid \
	$(DOCKER_DIR)/$(TARGET)-kubernetes-istio.iid \
	$(DOCKER_DIR)/$(TARGET)-docker-compose.iid \
	$(DOCKER_DIR)/$(TARGET)-development.iid 

gcp:                 $(DOCKER_DIR)/$(TARGET)-gcp.iid
kubernetes-nodeport: $(DOCKER_DIR)/$(TARGET)-kubernetes-nodeport.iid
kubernetes-istio:    $(DOCKER_DIR)/$(TARGET)-kubernetes-istio.iid
docker-compose:      $(DOCKER_DIR)/$(TARGET)-docker-compose.iid
development:         $(DOCKER_DIR)/$(TARGET)-development.iid

$(DOCKER_DIR)/$(TARGET)-%.iid: Dockerfile \
	$(SRCS) 
	@echo "### DOCK/DOCK  $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT) - $*"
	@$(MKDIR) "$(DOCKER_DIR)"
	@if [ -f "$(DOCKER_DIR)/$(TARGET)-$*.iid" ] ; then i=$$( cat "$(DOCKER_DIR)/$(TARGET)-$*.iid" ); docker image rm -f $$i ; rm -f "$(DOCKER_DIR)/$(TARGET)-$*.iid"  2>/dev/null ; fi
	@docker image build -f ./Dockerfile* \
	  --build-arg GITHASH="$(_GITHASH)" \
	  --build-arg COMPONENT=$(COMPONENT) \
	  --build-arg MODULE=$(MODULE) \
	  --build-arg PROJECT=$(PROJECT) \
	  --build-arg CUSTOMER=$(CUSTOMER) \
	  --build-arg VARIANT="$*" \
	  --tag $(TARGET):$* \
	  --label GITHASH="$(_GITHASH)" \
	  --label COMPONENT=$(COMPONENT) \
	  --label MODULE=$(MODULE) \
	  --label PROJECT=$(PROJECT) \
	  --label CUSTOMER=$(CUSTOMER) \
	  --label VARIANT="$*" \
	  --iidfile "$(DOCKER_DIR)/$(TARGET)-$*.iid" \
	  ../../..

docker-clean clean:
	@echo "### DOCK/DOCLN $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT)"
	@while read img imgname ; do \
	    while read id state name image ; do \
	        printf 'C %-7s %-10s %-20s %s\n' "$$id" "$$state" "$$name" "$$image" ; \
	        echo docker container stop --time 5 "$$id" ; \
	    done < <( docker container ls --filter "ancestor=$$img" --format='{{.ID}} {{.State}} {{.Names}} {{.Image}}'  | sort ) ; \
	    echo "I $$img $$imgname" ; \
	    echo docker image rm -f $$img ; \
	done < <(for v in $(DOCKER_IMAGES) ; do docker image ls --filter "label=PROJECT=$(PROJECT)" --filter "label=COMPONENT=$(COMPONENT)" --filter "label=MODULE=$(MODULE)" --filter "label=CUSTOMER=$(CUSTOMER)" --format='{{.ID}} {{.Repository}}:{{.Tag}}' "$(TARGET):$$v" ; done | sort -k 2) 
	@for v in $(DOCKER_IMAGES) ; do \
	    if [ -f "$(DOCKER_DIR)/$(TARGET)-$$v.iid" ] ; then \
	        i=$$( cat "$(DOCKER_DIR)/$(TARGET)-$$v.iid" ) ; \
	        docker image rm -f $$i 2>/dev/null ; \
	        rm -f "$(DOCKER_DIR)/$(TARGET)-$$v.iid"  2>/dev/null ; \
	    fi ; \
	done

docker-distclean distclean: clean
	@echo "### DOCK/DDICL $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT)"

docker-ls ls:
	@echo "### DOCK/DOLS  $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT)"
	@while read img imgname ; do \
		echo "I $$img $$imgname" ; \
		while read id state name image ; do \
			printf 'C %-7s %-10s %-20s %s\n' "$$id" "$$state" "$$name" "$$image" ; \
		done < <( docker container ls --filter "ancestor=$$img" --format='{{.ID}} {{.State}} {{.Names}} {{.Image}}'  | sort ) ; \
	done < <(docker image ls --filter "label=PROJECT=$(PROJECT)" --filter "label=COMPONENT=$(COMPONENT)" --format='{{.ID}} {{.Repository}}:{{.Tag}}' | sort -k 2)

docker-test test:
	@echo "### DOCK/TEST  $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT)"
	@echo "GITHASH: $(_GITHASH)"
	
-include $(DEPS)
