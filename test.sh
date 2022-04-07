#!/bin/bash

# Show usage
help() {
	[ "$1" = "" ] || printf "%s\n\n" "Erro: A flag '$1' nao existe."
	echo "Utilizacao:"
	echo "-b <Caminho-para-o-executavel>: Definir o executavel a testar, em caso de omicao da flag o default e' 'a.out'."
	echo "-t <Caminho-para-a-diretoria-dos-testes>: Definir os testes, em caso de omicao da flag o default e' 'tests'."
	echo "-h: Mostrar utilizacao."
}

# Check for flags
while getopts b:t:h FLAG; do
	case $FLAG in
		b) BIN="$OPTARG";;
		t) TESTDIR="$OPTARG";;
		h) help;;
		?) help "$OPTARG";;
	esac
done

# Default values if a flag is not provided
[ "$BIN" = "" ] && BIN="a.out"
[ "$TESTDIR" = "" ] && TESTDIR="tests"

# Getting tests from the test directory
TESTS=$(ls "$TESTDIR"/*.in)

# Creating MyOutput directory if it doestn exist
{ test -e MyOutput && test -d MyOutput; } || mkdir MyOutput

# Executing all tests
for TEST in $TESTS; do
	TESTNAME=${TEST%.in}
	MYOUT=MyOutput/"${TESTNAME#tests/}".myout
	./"$BIN" < "$TEST" > "$MYOUT"
	{ diff "$MYOUT" "${TESTNAME}".out > /dev/null && echo "${TESTNAME#tests/ } passed."; } || echo "${TESTNAME#tests/} failed."
done
