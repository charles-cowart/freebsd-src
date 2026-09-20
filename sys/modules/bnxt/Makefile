SYSDIR?=${SRCTOP}/sys
.include "${SYSDIR}/conf/kern.opts.mk"

SUBDIR=	bnxt_en

.if ${MK_OFED} != "no" || defined(ALL_MODULES)
SUBDIR+=	bnxt_re
.endif

.include <bsd.subdir.mk>
