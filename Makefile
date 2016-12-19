PREFIX=/usr/local
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

install: eoconv.1.gz eoconv.pl $(DOCS)
	install -D eoconv.pl $(PREFIX)/bin/eoconv
	mkdir -p $(PREFIX)/share/man/man1
	cp eoconv.1.gz $(PREFIX)/share/man/man1
	mkdir -p $(PREFIX)/share/doc/eoconv
	cp $(DOCS) $(PREFIX)/share/doc/eoconv

uninstall:
	rm -f $(PREFIX)/share/man/man1/eoconv.1.gz
	rm -f $(PREFIX)/bin/eoconv
	$(foreach file,$(DOCS),rm -f $(PREFIX)/share/doc/eoconv/$(file);)
