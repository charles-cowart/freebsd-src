OFEDINCS=	${SRCTOP}/contrib/ofed/include
IBVERBS=	${SRCTOP}/contrib/ofed/libibverbs
IBCM=		${SRCTOP}/contrib/ofed/libibcm
RDMACM=		${SRCTOP}/contrib/ofed/librdmacm
RDMA=		${SRCTOP}/sys/ofed/include/uapi/rdma
COMPLIB=	${SRCTOP}/contrib/ofed/opensm/include/complib
IBA=		${SRCTOP}/contrib/ofed/opensm/include/iba

IBINCS= \
${OFEDINCS}/byteorder.h \
${OFEDINCS}/byteswap.h \
${OFEDINCS}/endian.h \
${OFEDINCS}/types.h \
${OFEDINCS}/udma_barrier.h \
${IBVERBS}/arch.h \
${IBVERBS}/driver.h \
${IBVERBS}/kern-abi.h \
${IBVERBS}/marshall.h \
${IBVERBS}/opcode.h \
${IBVERBS}/sa-kern-abi.h \
${IBVERBS}/sa.h \
${IBVERBS}/verbs.h \
${IBCM}/cm.h \
${IBCM}/cm_abi.h \
${RDMACM}/ib.h
IBINCSDIR=	${INCLUDEDIR}/infiniband

RDMAINCS= \
${RDMACM}/rdma_cma.h \
${RDMACM}/rdma_cma_abi.h \
${RDMACM}/rdma_verbs.h \
${RDMACM}/rsocket.h \
${RDMA}/ib_user_cm.h \
${RDMA}/ib_user_sa.h \
${RDMA}/ib_user_verbs.h	\
${RDMA}/rdma_user_cm.h \
${RDMA}/mlx4-abi.h \
${RDMA}/mlx5-abi.h
RDMAINCSDIR=	${INCLUDEDIR}/rdma

IBAINCS= \
${IBA}/ib_cm_types.h \
${IBA}/ib_types.h
IBAINCSDIR=	${INCLUDEDIR}/infiniband/iba

INCSGROUPS= \
IBINCS \
RDMAINCS \


.include <bsd.prog.mk>
