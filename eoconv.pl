#!/usr/bin/perl

# $Id: eoconv.pl,v 1.4 2004-09-10 20:59:53 psy Exp $

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

GetOptions('help|?' => \$help, man => \$man) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

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

@enc_ca = ("c^", "g^", "h^",
	   "j^", "s^", "u^",
	   "C^", "G^", "H^",
	   "J^", "S^", "U^");

@enc_cb = ("^c", "^g", "^h",
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

@enc_utf8 = ("\x{0109}", "\x{011d}", "\x{0125}",
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

sample - Using Getopt::Long and Pod::Usage

=head1 SYNOPSIS

sample [options] [file ...]

 Options:
   -helpbrief help message
   -man full documentation

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and do someting
useful with the contents thereof.

=cut
