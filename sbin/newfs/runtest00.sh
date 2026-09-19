#!/bin/sh

set -e

MD=99
(
for s in 1m 4m 60m 120m 240m 1g
do
	(
	mdconfig -d -u $MD || true
	mdconfig -a -t malloc -s $s -u $MD
	gpart create -s bsd md$MD
	gpart add -t freebsd-ufs md$MD
	./newfs -R /dev/md${MD}a
	) 1>&2
	md5 < /dev/md${MD}a
done
mdconfig -d -u $MD 1>&2 || true
) 
