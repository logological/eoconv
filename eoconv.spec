Summary: Convert text files between various Esperanto encodings
Name: eoconv
Version: 1.2
Release: 1
License: GPL
Group: Applications/Text
URL: http://www.nothingisreal.com/eoconv/
Source0: http://www.nothingisreal.com/eoconv/%{name}-%{version}.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
Prefix: %{_prefix}
Requires: perl >= 5.6

%description
eoconv is a tool which converts text files to and from the following
Esperanto text encodings:

  * ASCII postfix h notation
  * ASCII postfix x notation
  * ASCII postfix caret (^) notation
  * ASCII prefix caret (^) notation
  * ISO-8859-3
  * Unicode (UTF-7, UTF-8, UTF-16, UTF-32)
  * HTML entities (decimal or hexadecimal)


%prep
%setup -q

%build

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
cp eoconv.pl %{_prefix}/bin/eoconv
cp doc/eoconv.1 %{_prefix}/man/man1/eoconv.1
gzip %{_prefix}/man/man1/eoconv.1

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%{_prefix}/bin/eoconv
%doc AUTHORS COPYING INSTALL NEWS README THANKS
%doc %{_prefix}/man/man1/eoconv.1.gz



%changelog
* Fri Dec  4 2004 Tristan Miller <psychonaut@nothingisreal.com> - 
- Initial build.

