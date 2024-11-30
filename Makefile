# Makefile for sig2dot package

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

install: sig2dot-custom sig2dot2
	install -d $(BINDIR)
	install -m 755 sig2dot-custom $(BINDIR)/sig2dot-custom
	install -m 755 sig2dot2 $(BINDIR)/sig2dot2

uninstall:
	rm -f $(BINDIR)/sig2dot-custom
	rm -f $(BINDIR)/sig2dot2

.PHONY: install uninstall
