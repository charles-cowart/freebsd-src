SYSDIR?=	${SRCTOP}/sys

KMOD=		dtraceall
SRCS=		dtraceall.c

CFLAGS+=	-I${SYSDIR}

.include <bsd.kmod.mk>

CFLAGS+=	-include ${SYSDIR}/cddl/compat/opensolaris/sys/debug_compat.h
