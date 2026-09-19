.include <src.opts.mk>

.if ${MK_OFED_EXTRA} != "no"
SUBDIR= \
	dump_fts \
	ibcacheedit \
	iblinkinfo \
	ibnetdiscover \
	ibqueryerrors
.endif

SUBDIR_PARALLEL=

.include <bsd.subdir.mk>
