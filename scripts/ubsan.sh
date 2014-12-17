#!/bin/bash
sudo apt-get -qq update
sudo apt-get install -y -qq subversion r-base-dev clang-3.4 texlive-fonts-extra texlive-latex-extra
sudo apt-get install -y -qq --no-install-recommends \
bash-completion \
bison \
debhelper \
default-jdk \
groff-base \
libblas-dev \
libbz2-dev \
libcairo2-dev \
libjpeg-dev \
liblapack-dev \
liblzma-dev \
libncurses5-dev \
libpango1.0-dev \
libpcre3-dev \
libpng-dev \
libreadline-dev \
libx11-dev \
libxt-dev \
mpack \
subversion \
tcl8.5-dev \
texinfo \
texlive-base \
texlive-extra-utils \
texlive-fonts-recommended \
texlive-generic-recommended \
texlive-latex-base \
tk8.5-dev \
x11proto-core-dev \
xauth \
xdg-utils \
xfonts-base \
xvfb \
zlib1g-dev

cd /tmp
svn co --quiet http://svn.r-project.org/R/trunk R-devel
cd /tmp/R-devel
R_PAPERSIZE=letter
R_BATCHSAVE="--no-save --no-restore"
R_BROWSER=xdg-open
PAGER=/usr/bin/pager
PERL=/usr/bin/perl
R_UNZIPCMD=/usr/bin/unzip
R_ZIPCMD=/usr/bin/zip
R_PRINTCMD=/usr/bin/lpr
LIBnn=lib
AWK=/usr/bin/awk
echo -e ' \
CC="clang -std=gnu99 -fsanitize=address,undefined" \
\nCFLAGS="-g -pipe -O2" \
\nF77="gfortran" \
\nLIBnn="lib" \
\nLDFLAGS="-L/usr/local/lib64 -L/usr/local/lib" \
\nCXX="clang++ -std=c++11 -fsanitize=address,undefined" \
\nCXXFLAGS="-g -pipe -O2" \
\nFC=${F77}' > config.site

./configure --enable-R-shlib \
            --without-recommended-packages \
            --program-suffix=dev

make -s
sudo make install
sudo make clean

sudo chmod 2777 /usr/local/lib/R /usr/local/lib/R/site-library

mkdir ~/.R
echo -e "CC = clang -std=gnu99 -fsanitize=address,undefined\nCXX = clang++ -fsanitize=address,undefined"  > ~/.R/Makevars
