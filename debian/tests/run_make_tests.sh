#!/bin/sh
set -e

srcdir=$(pwd)

trap 'rm -f "$srcdir/config.status" "$srcdir/config.log" "$srcdir/tests/config-flags.pm"' EXIT HUP INT QUIT ABRT KILL ALRM TERM

./configure --no-create "$1" "$(dpkg-buildflags --export=cmdline)"
./config.status tests/config-flags.pm

cd tests
./mkshadow "$AUTOPKGTEST_TMP"

cd "$AUTOPKGTEST_TMP/tests"
./run_make_tests -srcdir "$srcdir" -make /usr/bin/make
