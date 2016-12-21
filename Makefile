PREFIX?=/usr/local
MAN1DIR=$(DESTDIR)$(PREFIX)/share/man/man1
DOCDIR=$(DESTDIR)$(PREFIX)/share/doc
BINDIR=$(DESTDIR)$(PREFIX)/bin

DOCS=eoconv.html AUTHORS COPYING INSTALL.md NEWS README.md THANKS

all: eoconv.1 eoconv.html

clean:
	rm -f eoconv.1 eoconv.txt eoconv.html eoconv.1.gz

eoconv.1: eoconv.pl
	pod2man $< >$@

eoconv.txt: eoconv.pl
	pod2text <$< >$@

eoconv.html: eoconv.pl
	pod2html $< >$@
	rm pod2htm?.tmp

eoconv.1.gz: eoconv.1
	gzip -f eoconv.1

install-bin: eoconv.pl
	install -D eoconv.pl $(BINDIR)/eoconv

install-man: eoconv.1.gz
	mkdir -p $(MAN1DIR)
	cp eoconv.1.gz $(MAN1DIR)

install-docs: $(DOCS)
	mkdir -p $(DOCDIR)/eoconv
	cp $(DOCS) $(DOCDIR)/eoconv

install: install-bin install-man install-docs

uninstall:
	rm -f $(MAN1DIR)/eoconv.1.gz
	rm -f $(BINDIR)/eoconv
	$(foreach file,$(DOCS),rm -f $(DOCDIR)/eoconv/$(file);)
	rmdir --ignore-fail-on-non-empty $(DOCDIR)/eoconv
