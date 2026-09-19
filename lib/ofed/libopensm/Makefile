_spath=	${.CURDIR}
.PATH:	${_spath}

SHLIBDIR?=	/usr/lib
LIB=		opensm
SHLIB_MAJOR=	5

SRCS= \
osm_log.c \
osm_mad_pool.c \
osm_helper.c

LIBADD=		pthread
CFLAGS+=	-I${SRCTOP}/contrib/ofed/opensm -DHAVE_CONFIG_H=1
CFLAGS+=	-I${SYSROOT:U${DESTDIR}}/${INCLUDEDIR}/infiniband
VERSION_MAP=	${_spath}/libopensm.map

.include <bsd.lib.mk>
