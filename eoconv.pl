#!/usr/bin/perl

# Copyright (C) 2004 Tristan Miller <psychonaut@nothingisreal.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.

use Getopt::Long;
use Pod::Usage;

my $man = 0;
my $help = 0;
my $version = 0;
my $ver='$Id: eoconv.pl,v 1.6 2004-09-10 21:43:53 psy Exp $';

GetOptions('help|?' => \$help,
	   man => \$man,
	   version => \$version
	  ) or pod2usage(2);

# Display help/man page
pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Display version information
if ($version) {
  $_ = substr $ver, 5;
  s/ ....\/..\/.. .*//;
  s/\.pl,v//;
  print <<EOF;
$_
Copyright (C) 2004 Tristan Miller
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOF
  exit 0;
}

# To do:
# - First, convert string to Unicode
# - Then, use the Encode module to encode to whatever
#   encoding is desired (utf-8, utf-7, utf-16, etc.)
#   e.g. 
#      use Encode 'from_to';
#      from_to($data, "iso-8859-3", "utf-8");

@enc_x = ("cx", "gx", "hx",
	  "jx", "sx", "ux",
	  "Cx", "Gx", "Hx",
	  "Jx", "Sx", "Ux");

@enc_h = ("ch", "gh", "hh",
	  "jh", "sh", "uh",
	  "Ch", "Gh", "Hh",
	  "Jh", "Sh", "Uh");

@enc_pre_caret = ("c^", "g^", "h^",
	   "j^", "s^", "u^",
	   "C^", "G^", "H^",
	   "J^", "S^", "U^");

@enc_post_caret = ("^c", "^g", "^h",
	   "^j", "^s", "^u",	
	   "^C", "^G", "^H",
	   "^J", "^S", "^U");

@enc_html_hex = ("&#x109;", "&#x11d;", "&#x125;",
		 "&#x135;", "&#x15d;", "&#x16d;",
		 "&#x108;", "&#x11c;", "&#x124;",
		 "&#x134;", "&#x15c;", "&#x16c;");

@enc_html_dec = ("&#265;", "&#285;", "&#293;",
		 "&#309;", "&#349;", "&#365;",
		 "&#264;", "&#284;", "&#292;",
		 "&#308;", "&#348;", "&#364;");

@enc_iso_8859_3 = ("\xe6", "\xf8", "\xb6",
		   "\xbc", "\xfe", "\xfd",
		   "\xc6", "\xd8", "\xa6",
		   "\xac", "\xde", "\xdd");

@enc_utf_8 = ("\x{0109}", "\x{011d}", "\x{0125}",
	     "\x{0135}", "\x{015d}", "\x{016d}",
	     "\x{0108}", "\x{011c}", "\x{0124}",
	     "\x{0134}", "\x{015c}", "\x{016c}");

$from = \@enc_x;
$to   = \@enc_iso_8859_3;

foreach $line (<>) {

  for($i = 0; $i < @$from ; $i++)
    {
      $line =~ s/$$from[$i]/$$to[$i]/g;
    }

  print $line;
}

__END__

=head1 NAME

eoconv - Convert text files between various Esperanto encodings

=head1 SYNOPSIS

eoconv [options] [file]

 Options:
   --from      specify input encoding (see below)
   --to        specify output encoding (see below)

   --help      detailed help message
   --man       full documentation
   --version   display version information

 Valid encodings:
   h x pre-caret post-caret
   iso-8859-3 utf-7 utf-8 utf-16
   html-hex html-dec

=head1 OPTIONS

=over 12

=item B<--from>

Specify character encoding for input

=item B<--to>

Specify character encoding for output

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print the manual page and exit.

=item B<--version>

Print version information and exit.

=back

=head2 CHARACTER ENCODINGS

=over 12

=item B<h>

Postfix h notation

=item B<x>

Postfix x notation

=item B<pre-caret>

Prefix caret (^) notation

=item B<post-caret>

Postfix caret (^) notation

=item B<iso-8859-3>

ISO-8859-3

=item B<utf-7>

Unicode UTF-7

=item B<utf-8>

Unicode UTF-8

=item B<utf-16>

Unicode UTF-16

=item B<html-hex>

HTML hexadecimal entities

=item B<html-dec>

HTML decimal entities

=back

=head1 DESCRIPTION

B<eoconv> will read the given input file (or stdin if no file is
specified) containing Esperanto text in the encoding specified by
B<--from>, and then output it in the encoding specified by B<--to>.

=cut
