PACKAGE=runtime
PROG=	umount
SRCS=	umount.c vfslist.c

MOUNT=	${.CURDIR:H}/mount
CFLAGS+= -I${MOUNT}

.PATH: ${MOUNT}

.include <bsd.prog.mk>
