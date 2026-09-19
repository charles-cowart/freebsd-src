#!/bin/sh

set -e

MD=99
ME=98
s=1m
mdconfig -d -u $MD || true
mdconfig -d -u $ME || true
mdconfig -a -t malloc -s $s -u $MD
mdconfig -a -t malloc -s $s -u $ME
gpart create -s bsd md$MD
gpart add -t freebsd-ufs md$MD
gpart create -s bsd md$ME
gpart add -t freebsd-ufs md$ME
./newfs -R /dev/md${MD}a
./newfs -R /dev/md${ME}a
if cmp /dev/md${MD}a /dev/md${ME}a ; then
	echo "Test passed"
	e=0
else
	echo "Test failed"
	e=1
fi
mdconfig -d -u $MD || true
mdconfig -d -u $ME || true
exit $e
