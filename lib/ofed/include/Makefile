OFEDINCS=	${SRCTOP}/contrib/ofed/include
IBVERBS=	${SRCTOP}/contrib/ofed/libibverbs
IBMAD=		${SRCTOP}/contrib/ofed/libibmad
IBUMAD=		${SRCTOP}/contrib/ofed/libibumad
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
${IBUMAD}/umad.h \
${IBUMAD}/umad_cm.h \
${IBUMAD}/umad_sa.h \
${IBUMAD}/umad_sm.h \
${IBUMAD}/umad_str.h \
${IBUMAD}/umad_types.h \
${IBMAD}/mad.h \
${IBMAD}/mad_osd.h \
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

COMPINCS= \
${COMPLIB}/cl_atomic.h \
${COMPLIB}/cl_atomic_osd.h \
${COMPLIB}/cl_byteswap.h \
${COMPLIB}/cl_byteswap_osd.h \
${COMPLIB}/cl_comppool.h \
${COMPLIB}/cl_debug.h \
${COMPLIB}/cl_debug_osd.h \
${COMPLIB}/cl_dispatcher.h \
${COMPLIB}/cl_event.h \
${COMPLIB}/cl_event_osd.h \
${COMPLIB}/cl_event_wheel.h \
${COMPLIB}/cl_fleximap.h \
${COMPLIB}/cl_list.h \
${COMPLIB}/cl_log.h \
${COMPLIB}/cl_map.h \
${COMPLIB}/cl_math.h \
${COMPLIB}/cl_nodenamemap.h \
${COMPLIB}/cl_packoff.h \
${COMPLIB}/cl_packon.h \
${COMPLIB}/cl_passivelock.h \
${COMPLIB}/cl_pool.h \
${COMPLIB}/cl_ptr_vector.h \
${COMPLIB}/cl_qcomppool.h \
${COMPLIB}/cl_qlist.h \
${COMPLIB}/cl_qmap.h \
${COMPLIB}/cl_qpool.h \
${COMPLIB}/cl_spinlock.h \
${COMPLIB}/cl_spinlock_osd.h \
${COMPLIB}/cl_thread.h \
${COMPLIB}/cl_thread_osd.h \
${COMPLIB}/cl_threadpool.h \
${COMPLIB}/cl_timer.h \
${COMPLIB}/cl_timer_osd.h \
${COMPLIB}/cl_types.h \
${COMPLIB}/cl_types_osd.h \
${COMPLIB}/cl_vector.h
COMPINCSDIR=	${INCLUDEDIR}/infiniband/complib

IBAINCS= \
${IBA}/ib_cm_types.h \
${IBA}/ib_types.h
IBAINCSDIR=	${INCLUDEDIR}/infiniband/iba

INCSGROUPS= \
IBINCS \
RDMAINCS \
COMPINCS \
IBAINCS

.include <bsd.prog.mk>
