#!/usr/bin/perl
#
# $Id: eoconv.pl,v 1.22 2004-09-18 17:41:21 psy Exp $
#
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
use Encode 'from_to';

my @enc_post_x = ("cx", "gx", "hx",
		  "jx", "sx", "ux",
		  "Cx", "Gx", "Hx",
		  "Jx", "Sx", "Ux");

my @enc_post_h = ("ch", "gh", "hh",
		  "jh", "sh", "u",
		  "Ch", "Gh", "Hh",
		  "Jh", "Sh", "U");

my @enc_post_caret = ("c^", "g^", "h^",
		      "j^", "s^", "u^",
		      "C^", "G^", "H^",
		      "J^", "S^", "U^");

my @enc_pre_caret = ("^c", "^g", "^h",
		     "^j", "^s", "^u",	
		     "^C", "^G", "^H",
		     "^J", "^S", "^U");

my @enc_html_hex = ("&#x109;", "&#x11d;", "&#x125;",
		    "&#x135;", "&#x15d;", "&#x16d;",
		    "&#x108;", "&#x11c;", "&#x124;",
		    "&#x134;", "&#x15c;", "&#x16c;");

my @enc_html_dec = ("&#265;", "&#285;", "&#293;",
		    "&#309;", "&#349;", "&#365;",
		    "&#264;", "&#284;", "&#292;",
		    "&#308;", "&#348;", "&#364;");

my @enc_iso_8859_3 = ("\xe6", "\xf8", "\xb6",
		      "\xbc", "\xfe", "\xfd",
		      "\xc6", "\xd8", "\xa6",
		      "\xac", "\xde", "\xdd");

my @enc_utf7 = ("\\+AQk-", "\\+AR0-", "\\+ASU-",
		"\\+ATU-", "\\+AV0-", "\\+AW0-",
		"\\+AQg-", "\\+ARw-", "\\+ASQ-",
		"\\+ATQ-", "\\+AVw-", "\\+AWw-");

my @enc_utf8 = ("\x{0109}", "\x{011d}", "\x{0125}",
		 "\x{0135}", "\x{015d}", "\x{016d}",
		 "\x{0108}", "\x{011c}", "\x{0124}",
		 "\x{0134}", "\x{015c}", "\x{016c}");

my %encodings = (
		 'post-x'     => \@enc_post_x,
		 'post-h'     => \@enc_post_h,
		 'post-caret' => \@enc_post_caret,
		 'pre-caret'  => \@enc_pre_caret,
		 'html-hex'   => \@enc_html_hex,
		 'html-dec'   => \@enc_html_dec,
		 'iso-8859-3' => \@enc_iso_8859_3,
		 'utf7'       => \@enc_utf7,
		 'utf8'       => \@enc_utf8,
		 'utf16'      => \@enc_utf8,
		 'utf32'      => \@enc_utf8
		);

# Parse command-line options
my $man = 0;
my $help = 0;
my $version = 0;
my $from = 0;
my $to = 0;
my $quiet = 0;

GetOptions('help|?' => \$help,
	   man => \$man,
	   'quiet|q' => \$quiet,
	   version => \$version,
	   'from=s' => \$from,
	   'to=s' => \$to,
	  ) or pod2usage(1);

# Display help/man page
pod2usage(0) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Incorrect invocation
if (!($from && $to)) {
  pod2usage(-exitstatus => 1, -verbose => 0,
	    -msg => "eoconv: must specify both an input and output encoding");
}
if (!exists $encodings{$from} || !exists $encodings{$to}) {
  pod2usage(-exitstatus => 1, -verbose => 0,
	    -msg => "eoconv: invalid encoding specified");
}

# Warning against using postfix-h
if (!$quiet && ($from eq "post-h")) {
  print STDERR "eoconv: warning: conversion from postfix-h notation is not recommended\n"
}

# Display version information
if ($version) {
  print <<EOF;
eoconv 1.0
Copyright (C) 2004 Tristan Miller
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOF
  exit 0;
}

# Set Perl's input/output encoding
my $enc_from = "ascii";
$enc_from = $from if $from =~ /^utf|^iso/;

my $enc_to = "ascii";
$enc_to = $to if $to =~ /^utf|^iso/;

use encoding 'ascii', STDOUT => $to, STDIN => $from;

# Case: both encodings are ISO/UTF
if ($enc_from =~ /^utf|^iso/ && $enc_to =~ /^utf|^iso/) {
  foreach $line (<>) {
    from_to($line, $enc_from, $enc_to);
    print $line;
  }
  exit;
}

# Case: both encodings are ASCII
if ($enc_from =~ /^ascii/ && $enc_to =~ /^ascii/) {
  $from = $encodings{$from};
  $to   = $encodings{$to};
  foreach $line (<>) {
    for($i = 0; $i < @$from ; $i++)
      {
	$line =~ s/$$from[$i]/$$to[$i]/g;
      }
    print $line;
  }
  exit;
}

# Case: ASCII => ISO/UTF
if ($enc_from =~ /^ascii/ && $enc_to =~ /^utf|^iso/) {
  $from = $encodings{$from};
  $to   = $encodings{"iso-8859-3"};
  foreach $line (<>) {
    for($i = 0; $i < @$from ; $i++)
      {
	$line =~ s/$$from[$i]/$$to[$i]/g;
      }
    from_to($line, 'iso-8859-3', $enc_to);
    print $line;
  }
}

# Case: ISO/UTF => ASCII
  $from = $encodings{'utf7'};
  $to   = $encodings{$to};
  foreach $line (<>) {
    from_to($line, $enc_from, 'utf7');
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

eoconv [-q] --from=I<encoding> --to=I<encoding> [F<file> ...]

 Options:
   --from       specify input encoding (see below)
   --to         specify output encoding (see below)
   -q, --quiet  suppress warnings

   --help       detailed help message
   --man        full documentation
   --version    display version information

 Valid encodings:
   post-h post-x post-caret pre-caret html-hex html-dec
   iso-8859-3 utf7 utf8 utf16 utf32

=head1 DESCRIPTION

B<eoconv> will read the given input files (or stdin if no files are
specified) containing Esperanto text in the encoding specified by
B<--from>, and then output it in the encoding specified by B<--to>.

=head1 OPTIONS

=over 17

=item B<--from=>I<encoding>

Specify character encoding for input

=item B<--to=>I<encoding>

Specify character encoding for output

=item B<-q>
B<--quiet>

Suppress non-essential warning messages

=item B<-?>
B<--help>

Print a brief help message and exit.

=item B<--man>

Print the manual page and exit.

=item B<--version>

Print version information and exit.

=back

=head2 CHARACTER ENCODINGS

=over 17

=item I<post-h>

ASCII postfix h notation

=item I<post-x>

ASCII postfix x notation

=item I<post-caret>

ASCII postfix caret (^) notation

=item I<pre-caret>

ASCII prefix caret (^) notation

=item I<html-hex>

ASCII HTML hexadecimal entities

=item I<html-dec>

ASCII HTML decimal entities

=item I<iso-8859-3>

ISO-8859-3

=item I<utf7>

Unicode UTF-7

=item I<utf8>

Unicode UTF-8

=item I<utf16>

Unicode UTF-16

=item I<utf32>

Unicode UTF-32

=back

=head1 ESPERANTO ORTHOGRAPHY

Esperanto is written in an alphabet of 28 letters.  However, only 22
of these letters can be found in the standard ASCII character set.
The remaining six -- `c', `g', `h', `j', and `s' with circumflex, and
`u' with breve -- are not available in ASCII; neither are they among
the characters available in the common 8-bit ISO-8859-1 character
encoding.  Therefore, while the six special Esperanto characters pose
no problem for handwritten texts, they were impossible to represent on
standard typewriters, and are somewhat problematic even on modern-day
computers.  Various encoding systems have been developed to represent
Esperanto text in printed and typed text.

=head2 POSTFIX-h NOTATION

This was the solution proposed by the creator of Esperanto,
L. L. Zamenhof.  He recommended using `u' for `u-breve' and appending
an `h' to a letter to indicate that it should have a circumflex.
However, the letters `u' and `h' are already part of the Esperanto
alphabet, so using them for another purpose invites ambiguity and
mispronunciation.  It also makes conversion of Esperanto text to
postfix-h notation `lossy' or one-way; it is generally not possible to
convert from postfix-h notation via automated means.  This notation
suffers from the additional drawback that the text cannot be sorted
with standard rules for ASCII text.

=head2 POSTFIX-x NOTATION

This is the most common ASCII notation encountered today.  It involves
appending an `x' to a letter to indicate that it should have an accent
(be it circumflex or breve).  Since `x' is not a letter in the
Esperanto alphabet, no ambiguity results.  However, ASCII sorting
algorithms still fail with postfix-x text.

=head2 PREFIX- AND POSTFIX-CARET NOTATION

Two slightly less popular ASCII encodings are to prepend or append a
caret (`^') to a letter to indicate that it should have an accent.

=head2 ISO-8859-3 (LATIN-3)

ISO 8859-3, also known as Latin-3 or South European, is an 8-bit
character encoding for Turkish, Maltese, and Esperanto.  High-bit
characters are used to encode the accented Esperanto letters.

=head2 UNICODE (ISO/IEC 10646)

Unicode is a standard for matching every character of every human
language to a specific code.  The mapping methods are known as Unicode
Transformation Formats (UTF). Among them are UTF-32, UTF-16, UTF-8 and
UTF-7, where the numbers indicate the number of bits in one unit.

=head2 HTML ENTITIES

Unicode codes for Esperanto characters can be escaped in HTML
documents by using HTML entities.  The codes can be represented in
either decimal (base-10) or hexadecimal (base-16) notation; the two
are functionally equivalent.

=head1 BUGS

Because postfix-h notation is inherently ambiguous, conversion from
postfix-h text is unlikely to result in coherent text.  Use at your
own risk, and carefully proofread the results.

Report bugs to E<lt>psychonaut@nothingisreal.comE<gt>.

=head1 COPYRIGHT

Copyright (C) 2004 Tristan Miller.

Permission is granted to make and distribute verbatim or modified
copies of this manual provided the copyright notice and this
permission notice are preserved on all copies.

=cut
