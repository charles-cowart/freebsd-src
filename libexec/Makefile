#	@(#)Makefile	8.1 (Berkeley) 6/4/93

.include <src.opts.mk>

.include <bsd.compat.pre.mk>

SUBDIR= ${_atf} \
        ${_atrun} \
        ${_blacklistd-helper} \
        ${_comsat} \
        ${_dma} \
        flua \
        getty \
        ${_hyperv} \
        kgdb \
        ${_mail.local} \
        ${_mknetid} \
        ${_phttpget} \
        rc \
        revnetgroup \
        ${_rlogind} \
        rpc.rquotad \
        rpc.rstatd \
        rpc.rusersd \
        rpc.rwalld \
        rpc.sprayd \
        ${_rshd} \
        ${_rtld-elf} \
        save-entropy \
        ${_nuageinit} \
        ${_smrsh} \
        ${_tests} \
        ulog-helper \
        ${_ypxfr}

.if ${MK_AT} != "no"
_atrun=		atrun
.endif

.if ${MK_BLACKLIST} != "no"
_blacklistd-helper+=	blacklistd-helper
.endif

.if ${MK_BOOTPD} != "no"
SUBDIR+=	bootpd
.endif


.if ${MK_FREEBSD_UPDATE} != "no"
_phttpget=	phttpget
.endif


.if ${MK_MAIL} != "no"
_comsat=	comsat
.endif

.if ${MK_DMAGENT} != "no"
_dma=		dma
.endif

.if ${MK_HYPERV} != "no"
_hyperv+=	hyperv
.endif

.if ${MK_NIS} != "no"
_mknetid=	mknetid
_ypxfr=		ypxfr
.endif


.if !defined(NO_PIC) && !defined(NO_RTLD)
_rtld-elf=	rtld-elf
.for LIBCOMPAT libcompat in ${_ALL_LIBCOMPATS_libcompats}
SUBDIR.${MK_LIB${LIBCOMPAT}}+=	rtld-elf${libcompat}
.endfor
.endif

.if ${MK_RBOOTD} != "no"
SUBDIR+=	rbootd
.endif

.if ${MK_SENDMAIL} != "no"
_mail.local=	mail.local
_smrsh=		smrsh
.endif


.if ${MK_TALK} != "no"
SUBDIR+=	talkd
.endif

.if ${MK_TCP_WRAPPERS} != "no"
SUBDIR+=	tcpd
.endif

.if ${MK_TFTP} != "no"
SUBDIR+=	tftpd
.endif

.if ${MK_TESTS} != "no"
_tests=		tests
.endif

.if ${MK_TESTS_SUPPORT} != "no"
_atf=		atf
.endif

.if ${MK_NUAGEINIT} != "no"
_nuageinit=	nuageinit
.endif

.include <bsd.arch.inc.mk>

.include <bsd.subdir.mk>
