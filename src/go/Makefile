TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/  */\n/g' ; git rev-parse HEAD  ) | sort -u )

LIBS := 
BINS := ms-random ms-thermometer fe-weather

LIBS_SUBDIRS := $(addprefix ./lib,$(LIBS))
BINS_SUBDIRS := $(addprefix ./,$(BINS))

SUBDIRS = $(LIBS_SUBDIRS) $(BINS_SUBDIRS)

all: dep lib bin

.PHONY: lib bin docker clean distclean dep include

lib:

include:

bin:
	@for dir in $(BINS_SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
		make -C  $$dir bin ; \
	done

dep:
	@for dir in $(BINS_SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
		make -C  $$dir dep ; \
	done

docker:
	@for dir in $(BINS_SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
		make -C  $$dir docker; \
	done

clean:
	@for dir in $(SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
		make -C  $$dir clean ; \
	done

distclean:
	@for dir in $(SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
		make -C  $$dir distclean ; \
	done

test:
	@echo "GITHASH: $(GITHASH)"
	@for dir in $(BINS_SUBDIRS) ; do \
	    TIMESTAMP="$(TIMESTAMP)" \
	    GITHASH="$(GITHASH)" \
  		  make -C $$dir test; \
	done
