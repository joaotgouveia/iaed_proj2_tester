#!/bin/bash
TESTS=$(ls tests/*.in)
(test -e MyOutput && test -d MyOutput) || mkdir MyOutput
for TEST in $TESTS
do
	TESTNAME=${TEST%.in}
	MYOUT=MyOutput/${TESTNAME#tests/}.myout
	./a.out < $TEST > $MYOUT
	(diff $MYOUT ${TESTNAME}.out > temp.diff && echo "${TESTNAME#tests/} passed.") || echo "${TESTNAME#tests/} failed."
done
rm temp.diff
