System requirements
-------------------

eoconv requires Perl 5.20 or higher.  It's been tested with Unix-like
systems, but will probably run on other platforms as well.


Installation
------------

For many Unix-like systems the following should work:

    $ make && sudo make install

If you want eoconv installed somewhere other than the default prefix
(`/usr/local`) then you can specify this with the `PREFIX` variable:

   $ make && sudo make PREFIX=/some/path install


Running
-------

The program should be invoked from the command line.  Brief help is
available with the `--help` command-line option; a detailed man page is
available with the `--man` command-line option.
