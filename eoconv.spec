Summary: Convert text files between various Esperanto encodings
Name: eoconv
Version: 1.5
Release: 0
License: GPL-3.0+
Group: Applications/Text
URL: https://logological.org/eoconv
Source0: https://files.nothingisreal.com/software/eoconv/%{name}-%{version}.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-build
Prefix: %{_prefix}
Requires: perl >= 5.20
BuildRequires: perl(Pod::Man)
BuildRequires: gzip
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
%{__make}

%install
[ "%{buildroot}" != "/" ] && %{__rm} -rf %{buildroot}
%{__make} PREFIX=%{_prefix} DESTDIR=%{buildroot} install-bin
%{__make} PREFIX=%{_prefix} DESTDIR=%{buildroot} install-man

%clean
[ "%{buildroot}" != "/" ] && %{__rm} -rf %{buildroot}


%files
%defattr(-,root,root,-)
%{_bindir}/%{name}
%doc AUTHORS COPYING INSTALL.md NEWS README.md THANKS
%doc %{_mandir}/man1/%{name}.1*


%changelog
* Mon Dec 26 2016 Tristan Miller <psychonaut@nothingisreal.com> - 
- Clean up RPM for OBS.
- Update URLs.
- Update license header per SPDX Specification.

* Mon Dec 19 2016 Tristan Miller <psychonaut@nothingisreal.com> - 
- Initial build.

