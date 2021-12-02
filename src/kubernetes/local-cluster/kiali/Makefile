SHELL := /bin/bash

CUSTOMER ?= com.gft.tsbo
PROJECT ?= com.gft.tsbo.source
MODULE ?= infrastructure
COMPONENT ?= dashboard
TARGET ?= $(PROJECT).$(MODULE).$(COMPONENT)
KUBERNETES_NAMESPACE :=$(shell echo "$PROJECT" | sed 's/[^a-zA-Z0-9_-]/-/g' )

TIMESTAMP ?= $(shell date +%Y%m%d%H%M%S)
GITHASH ?= $(shell (  git rev-parse HEAD  ) )
_GITHASH := $(shell ( echo "$(GITHASH)" | sed 's/^ *//; s/  *$$//; s/  */\\|/g') )

BUILD_DIR ?= ./build/

CP ?= cp -pv
MKDIR ?= mkdir -p
LN ?= ln
RM ?= rm

all: kubernetes

.PHONY: clean kubernetes docker dist dep lib include distclean bin

kubernetes: \
	$(BUILD_DIR)/$(TARGET)-kubernetes-dashboard \
	$(BUILD_DIR)/$(TARGET)-istio-dashboard

manifests/downloaded/kiali.yaml:
	@mkdir -p manifests/downloaded/
	@ curl 'https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/kiali.yaml' > manifests/downloaded/kiali.yaml

manifests/downloaded/prometheus.yaml:
	@mkdir -p manifests/downloaded/
	@curl 'https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/prometheus.yaml' > manifests/downloaded/prometheus.yaml

manifests/downloaded/jaeger.yaml:
	@mkdir -p manifests/downloaded/
	@curl 'https://raw.githubusercontent.com/istio/istio/release-1.12/samples/addons/jaeger.yaml' > manifests/downloaded/jaeger.yaml

manifests/downloaded/kubernetes-dashboard.yaml:
	@mkdir -p manifests/downloaded/
	@curl https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml > "$@"

$(BUILD_DIR)/$(TARGET)-kubernetes-dashboard: manifests/downloaded/kubernetes-dashboard.yaml \
	                                     manifests/kubernetes-dashboard-user.yaml
	@echo "### KUB / DASH  $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT)"
	@$(MKDIR) "$(BUILD_DIR)"
	@kubectl apply -f manifests/downloaded/kubernetes-dashboard.yaml
	@kubectl apply -f manifests/kubernetes-dashboard-user.yaml
	@kubectl -n kubernetes-dashboard get secret $$(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}" > kubernetes-token.txt


$(BUILD_DIR)/$(TARGET)-istio-dashboard: manifests/downloaded/kiali.yaml \
	                                manifests/downloaded/prometheus.yaml \
	                                manifests/downloaded/jaeger.yaml
	@kubectl apply -f manifests/downloaded/kiali.yaml
	@kubectl apply -f manifests/downloaded/prometheus.yaml
	@kubectl apply -f manifests/downloaded/jaeger.yaml
ls:

docker-ls:

dist:

docker: 

clean:
	@echo "### KUB /CLEAN $(PROJECT).$(MODULE).$(COMPONENT) - $(DOCKER_VARIANT)"
	@if [[ -f "manifests/kubernetes-dashboard-user.yaml" ]] ; then kubectl delete -f manifests/kubernetes-dashboard-user.yaml 2>/dev/null || exit 0; fi
	@if [[ -f "manifests/downloaded/kubernetes-dashboard.yaml" ]] ; then kubectl delete -f manifests/downloaded/kubernetes-dashboard.yaml 2>/dev/null || exit 0; fi
	@if [[ -f "manifests/downloaded/kiali.yaml" ]] ; then kubectl delete -f manifests/downloaded/kiali.yaml 2>/dev/null || exit 0; fi
	@if [[ -f "manifests/downloaded/prometheus.yaml" ]] ; then kubectl delete -f manifests/downloaded/prometheus.yaml 2>/dev/null || exit 0; fi
	@if [[ -f "manifests/downloaded/jaeger.yaml" ]] ; then kubectl delete -f manifests/downloaded/jaeger.yaml 2>/dev/null || exit 0; fi
	@$(RM) -rf $(BUILD_DIR)
	@$(MKDIR) $(BUILD_DIR)
	@$(MKDIR) manifests/downloaded

docker-clean:

distclean:

docker-distclean: docker-clean

test:
	
docker-test:
