#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright (c) 2015, Joyent, Inc.
#

#
# sdc-portolan-moray Makefile
#


#
# Tools
#

TAPE		:= ./node_modules/tape/bin/tape
NODE_EXEC	:= node
NPM			:= npm


#
# Files
#

JS_FILES	:= $(shell find lib test -name '*.js')
JSON_FILES	 = package.json
JSL_CONF_NODE	 = tools/jsl.node.conf
JSL_FILES_NODE	 = $(JS_FILES)
JSSTYLE_FILES	 = $(JS_FILES)
JSSTYLE_FLAGS	 = -f tools/jsstyle.conf


#
# Repo-specific targets
#

.PHONY: all
all: | $(TAPE)
	$(NPM) rebuild

$(TAPE):
	$(NPM) install

CLEAN_FILES += $(TAP) ./node_modules/tap

.PHONY: test
test: $(TAPE)
	@(for F in test/*.test.js; do \
		echo "# $$F" ;\
		$(NODE_EXEC) $(TAPE) $$F ;\
		[[ $$? == "0" ]] || exit 1; \
	done)


#
# Includes
#

include ./tools/mk/Makefile.deps
include ./tools/mk/Makefile.targ
