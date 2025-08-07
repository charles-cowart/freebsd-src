.include <src.opts.mk>

TESTSDIR=${TESTSBASE}/sys/netpfil

.if ${MK_IPFW} != "no"
TESTS_SUBDIRS+=ipfw
.endif

.include <bsd.test.mk>

