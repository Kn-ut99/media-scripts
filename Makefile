#
# Makefile
# Adrian Perez, 2010-02-18 16:38
#

include Makefile.local

DESTDIR ?=
PREFIX  ?= ~/.local
bindir   = $(PREFIX)/bin

dest_bindir = $(DESTDIR)$(bindir)

ifneq ($(strip $V),1)
  MAKEFLAGS += s
  echo := @echo
else
  echo := @:
endif

define install-bin-t
install: $$(dest_bindir)/$1
$$(dest_bindir)/$1: $1
	$(echo) " [1;32m*[0;0m install-bin [1;33m $$@[0;0m"
	mkdir -p $$(dir $$@)
	cp $$< $$@
	chmod +x $$@
endef

all:
	@echo "Maybe you wanted to say 'make install'..."

install:

$(foreach X,$(INSTALL_BIN),$(eval $(call install-bin-t,$X)))

# vim:ft=make
#

