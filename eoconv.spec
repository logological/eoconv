Summary: Convert text files between various Esperanto encodings
Name: eoconv
Version: 1.5
Release: 1
License: GPL
Group: Applications/Text
URL: http://www.nothingisreal.com/eoconv/
Source0: https://github.com/logological/%{name}/archive/%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
Prefix: %{_prefix}
Requires: perl >= 5.20
Distribution: openSUSE Tumbleweed
BuildArch: noarch

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
  * LaTeX sequences


%prep
%setup -q

%build
make

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
make PREFIX=%{_prefix} DESTDIR=$RPM_BUILD_ROOT install-bin
make PREFIX=%{_prefix} DESTDIR=$RPM_BUILD_ROOT install-man

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%{_prefix}/bin/eoconv
%doc AUTHORS COPYING INSTALL.md NEWS README.md THANKS
%doc %{_prefix}/share/man/man1/eoconv.1.gz



%changelog
* Mon Dec 19 2016 Tristan Miller <psychonaut@nothingisreal.com> - 
- Initial build.

