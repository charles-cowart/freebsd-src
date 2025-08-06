#! /bin/sh

. $(dirname $0)/../../common.sh

# Description
DESC="Select the builtin sh shell."

# Run
TEST_N=2
TEST_1="sh_test"
TEST_2="ksh_test"
TEST_2_SKIP="no ksh on FreeBSD"

eval_cmd $*
