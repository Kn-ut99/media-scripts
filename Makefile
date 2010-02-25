#
# Makefile
# Adrian Perez, 2010-02-18 16:38
#

include Makefile.local

DESTDIR ?=
PREFIX  ?= ~/.local
bindir   = $(PREFIX)/bin
mandir   = $(PREFIX)/share/man

dest_bindir = $(DESTDIR)$(bindir)
dest_mandir = $(DESTDIR)$(mandir)

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

define install-man-t
install: $$(dest_mandir)/man$1/$2
$$(dest_mandir)/man$1/$2: $2
	$(echo) " [1;32m*[0;0m install-man [1;33m $$@[0;0m"
	mkdir -p $$(dir $$@)
	cp $$< $$@
endef

all:
	@echo "Maybe you wanted to say 'make install'..."


all_man = $(INSTALL_MAN1)

man: $(all_man)

%.1: %.pod
	$(echo) " [1;32m*[0;0m pod2man     [1;33m $@[0;0m"
	pod2man --section=1 --center="User Commands" --release="Media scripts" $< $@

%.gz: %
	$(echo) " [1;32m*[0;0m gzip --best [1;33m $@[0;0m"
	gzip --best -c $< > $@

install:

$(foreach X,$(INSTALL_BIN),$(eval $(call install-bin-t,$X)))
$(foreach X,$(INSTALL_MAN1),$(eval $(call install-man-t,1,$X)))

# vim:ft=make
#

