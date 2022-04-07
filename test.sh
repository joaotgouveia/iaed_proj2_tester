#!/bin/bash
# test.sh - Simple testing script for projects

# Defining colors
BOLD=$(tput bold)
RES=$(tput sgr0)
FAILED="${BOLD}$(tput setaf 1)failed$RES" # Bold red
PASSED="${BOLD}$(tput setaf 2)passed$RES" # Bold green
ERROR="${BOLD}$(tput setaf 1)Erro: a flag '$1' nao existe.$RES"

# Show usage
help() {
	[ "$1" = "" ] || printf "\t%s\n" "$ERROR"
	printf "\t%s\n" "Flags:"
	printf "\t%s\n" "-b <Caminho-para-o-executavel>: Definir o executavel a testar, em caso de omicao da flag o default eh 'a.out'."
	printf "\t%s\n" "-t <Caminho-para-a-diretoria-dos-testes>: Definir os testes, em caso de omicao da flag o default eh 'tests'."
	printf "\t%s\n" "-h: Mostrar utilizacao."
	exit 0
}

# Check for flags
while getopts :b:t:h FLAG; do
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
	TESTNUM="${TESTNAME#tests/}"
	{ diff "$MYOUT" "${TESTNAME}".out > /dev/null && echo "$TESTNUM $PASSED"; } || echo "$TESTNUM $FAILED"
done
