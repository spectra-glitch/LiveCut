#!/usr/bin/make -f
# Makefile for DPF #
# ---------------- #
# Created by falkTX
#

include dpf/Makefile.base.mk

all: dgl plugins gen

# --------------------------------------------------------------

ifneq ($(CROSS_COMPILING),true)
CAN_GENERATE_TTL = true
else ifneq ($(EXE_WRAPPER),)
CAN_GENERATE_TTL = true
endif

dgl:
ifeq ($(HAVE_DGL),true)
	$(MAKE) -C dpf/dgl opengl FILE_BROWSER_DISABLED=true
endif

plugins: dgl
	$(MAKE) all -C plugins/LiveCut

ifeq ($(CAN_GENERATE_TTL),true)
gen: plugins dpf/utils/lv2_ttl_generator
	@$(CURDIR)/dpf/utils/generate-ttl.sh

dpf/utils/lv2_ttl_generator:
	$(MAKE) -C dpf/utils/lv2-ttl-generator
else
gen:
endif

tests: dgl
	$(MAKE) -C tests

# --------------------------------------------------------------

clean:
	$(MAKE) clean -C dpf/dgl
	$(MAKE) clean -C plugins/LiveCut
	$(MAKE) clean -C dpf/utils/lv2-ttl-generator
	rm -f dpf-widgets/opengl/*.d
	rm -f dpf-widgets/opengl/*.o
	rm -rf bin build

# --------------------------------------------------------------

# macOS Installation Target
install-macos:
	@echo "Installing LiveCut plugins for macOS..."
	@./install-macos.sh

# --------------------------------------------------------------

.PHONY: dgl plugins tests install-macos
