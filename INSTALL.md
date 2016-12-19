System requirements
-------------------

eoconv requires Perl 5.20 or higher.  It's been tested with Unix-like
systems, but will probably run on other platforms as well.


Installation
------------

1. If you are using a Unix-like system and have Perl installed
somewhere other than `/usr/bin/perl`, open the file `eoconv.pl` in an
editor and modify the first line as appropriate.

2. Copy the `eoconv.pl` file to somewhere in your path.  For example,
on a Unix-like system, you might type the following:

   $ sudo cp eoconv.pl /usr/local/bin/eoconv

3. Documentation in various formats is available in the `doc`
subdirectory; you can install this where desired.  For example, on a
Unix-like system, the man page might be installed as follows:

   $ sudo cp doc/eoconv.1 /usr/local/man/man1


Running
-------

The program should be invoked from the command line.  Brief help is
available with the `--help` command-line option; a detailed man page is
available with the `--man` command-line option.
