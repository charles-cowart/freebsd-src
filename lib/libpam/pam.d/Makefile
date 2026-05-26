.include <src.opts.mk>

NO_OBJ=

CONFGROUPS=	CONFS
CONFS=	README \
	imap \
	login \
	other \
	passwd pop3 \
	sshd su system \
	xdm

CONFDIR=	/etc/pam.d
CONFSMODE_README=	444

CONFGROUPS+=	CRON
CRON=		cron
CRONPACKAGE=	cron

CONFGROUPS.${MK_AT}+=	AT
AT=		atrun
ATPACKAGE=	at


.include <bsd.prog.mk>
