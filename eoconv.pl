#!/usr/bin/perl

# This script converts between the various Esperanto orthographies

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
