
.include <src.opts.mk>

PACKAGE=	runtime

NO_OBJ=

CONFGROUPS=	CONFS
CONFS=	README \
	cron \
	imap \
	login \
	other \
	passwd pop3 \
	sshd su system \
	xdm

CONFDIR=	/etc/pam.d
CONFSMODE_README=	444

.if ${MK_AT} != "no"
CONFGROUPS+=	AT
AT+=	atrun
ATPACKAGE+=	at
.endif


.include <bsd.prog.mk>
