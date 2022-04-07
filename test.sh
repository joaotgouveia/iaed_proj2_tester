#!/bin/bash

while getopts b:t: FLAG; do
	case $FLAG in
		b) BIN=$OPTARG;;
		t) TESTDIR=$OPTARG;;
		?) echo "Invalid flag"
	esac
done

# Default values
[ "$BIN" = "" ] && BIN="a.out"
[ "$TESTDIR" = "" ] && TESTDIR="tests"

# Getting tests from the test directory
TESTS=$(ls "$TESTDIR"/*.in)

# Creating MyOutput directory if it doestn exist
{ test -e MyOutput && test -d MyOutput; } || mkdir MyOutput

# Executing all tests
for TEST in $TESTS
do
	TESTNAME=${TEST%.in}
	MYOUT=MyOutput/"${TESTNAME#tests/}".myout
	./"$BIN" < "$TEST" > "$MYOUT"
	{ diff "$MYOUT" "${TESTNAME}".out > /dev/null && echo "${TESTNAME#tests/ } passed."; } || echo "${TESTNAME#tests/} failed."
done
