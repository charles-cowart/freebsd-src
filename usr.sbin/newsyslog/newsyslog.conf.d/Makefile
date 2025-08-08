
.include <src.opts.mk>

PACKAGE=	newsyslog
CONFSDIR=	/etc/newsyslog.conf.d

CONFGROUPS=	CONFS
CONFS=



.if ${MK_OFED} != "no"
CONFS+=		opensm.conf
.endif



.if ${MK_SENDMAIL} != "no"
CONFGROUPS+=		SENDMAIL
SENDMAIL+=		sendmail.conf
SENDMAILPACKAGE=	sendmail
SENDMAILDIR=		/etc/newsyslog.conf.d
.endif

.include <bsd.prog.mk>
