.SUFFIXES: .x

RPCCOM=	RPCGEN_CPP=${CPP:Q} rpcgen -C

HDRS= key_prot.h rex.h rnusers.h \
	rquota.h rstat.h rwall.h spray.h bootparam_prot.h crypt.h
XFILES= bootparam_prot.x key_prot.x rex.x rnusers.x rquota.x rstat.x rwall.x spray.x \
	crypt.x

CLEANFILES+= ${HDRS}

INCSGROUPS=	INCS RPCHDRS
INCS=		${XFILES} ${HDRS}
INCSDIR=	${INCLUDEDIR}/rpcsvc
RPCHDRS=	key_prot.h
RPCHDRSDIR=	${INCLUDEDIR}/rpc

.x.h:
	${RPCCOM} -h ${.IMPSRC} -o ${.TARGET}

.include <bsd.prog.mk>
