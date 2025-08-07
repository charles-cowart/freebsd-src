
PROG=	fifolog_writer

CFLAGS+= -I${.CURDIR:H}/lib

MAN=

LIBADD=	fifolog

regress:
	date | ./${PROG} -z 0 /tmp/fifolog.0
	jot -b X 65 | ./${PROG} -z 9 /tmp/fifolog.1

.include <bsd.prog.mk>
