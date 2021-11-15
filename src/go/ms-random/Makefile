TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/  */\n/g' ; git rev-parse HEAD  ) | sort -u )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )
SRCS:=$(shell find . -name "*.go" )
COMPONENT ?= ms-random
TARGET ?= $(COMPONENT)

GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOMOD=$(GOCMD) mod
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get

BASE_BIN_DIR ?= ../../../bin
BIN_DIR ?= ../dist/bin
OBJ_DIR ?= ../dist/obj/$(COMPONENT)

CP ?= cp -pv
MKDIR ?= mkdir -p
LN ?= ln
RM ?= rm

all: bin

.PHONY: clean docker dist dep lib include distclean bin

bin: $(BIN_DIR)/$(TARGET)
lib:
include:

$(BIN_DIR)/$(TARGET): $(SRCS) Makefile
	@$(MKDIR) $(BIN_DIR) $(BASE_BIN_DIR)
	$(GOBUILD) -tags osusergo,netgo \
	  -ldflags "\
	    -linkmode external \
	    -extldflags \
	    -static \
	    -X com.gft.tsbo-training.src.go/common/ms-framework/microservice._build_stamp="$(TIMESTAMP)" \
	    -X com.gft.tsbo-training.src.go/common/ms-framework/microservice._build_commit="$(_GITHASH)" \
	  " \
	  -a \
	  -o "$@" \
	  "cmd/main.go"
	@$(CP) $@ $(BASE_BIN_DIR)

dep:
#	@cd .. && $(GOMOD) init gft.com/m/v2
	@cd .. && $(GOMOD) download golang.org/x/net
	@cd .. && $(GOGET) golang.org/x/crypto/bcrypt
	@cd .. && $(GOGET) github.com/prometheus/client_golang/prometheus/promhttp

docker:
	@docker image build -f ../../docker/$(COMPONENT)/Dockerfile \
	  --build-arg GITHASH="$(_GITHASH)" \
	  --build-arg TIMESTAMP="$(TIMESTAMP)" \
	  --build-arg COMPONENT=$(COMPONENT) \
      --tag $(COMPONENT):latest \
      --tag $(COMPONENT):"$(_GITHASH)" \
      --label GITHASH="$(_GITHASH)" \
      --label COMPONENT=$(COMPONENT) \
      --label BUILDSTAMP="$(TIMESTAMP)" \
      ../..

clean:
	$(RM) -f $(BIN_DIR)/$(TARGET)

distclean:
	$(RM) -f $(BIN_DIR)/$(TARGET) $(BASE_BIN_DIR)/$(TARGET)

test:
	@echo "GITHASH: $(_GITHASH)"
	
-include $(DEPS)
