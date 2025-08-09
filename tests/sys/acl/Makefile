
PACKAGE=	tests

TESTSDIR=	${TESTSBASE}/sys/acl

BINDIR=		${TESTSDIR}

${PACKAGE}FILES+=	tools-crossfs.test
${PACKAGE}FILES+=	tools-posix.test

SCRIPTS+=	run

ATF_TESTS_C+=	acl-api-test

TAP_TESTS_SH+=	00
TAP_TESTS_SH+=	03


.for t in ${TAP_TESTS_SH}
# Tests hard-code a ZFS pool name of "acltools" and so cannot run in parallel.
TEST_METADATA.$t+=	required_user="root" \
			is_exclusive=true
.endfor

_ACL_PROGS=		getfacl setfacl

.for t in 03
TEST_METADATA.$t+=	required_programs="perl zpool ${_ACL_PROGS}"
.endfor

.for t in 00
TEST_METADATA.$t+=	required_programs="perl ${_ACL_PROGS}"
.endfor

.include <bsd.test.mk>
