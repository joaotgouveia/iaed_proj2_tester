# Testes para o segundo projeto da cadeira IAED
## Setup:
1. Clonar este repo com:
```
$ git clone https://github.com/joaotgouveia/iaed_proj2_tester.git
```
2. Executar os testes de forma automática com:
```
$ ./test.sh <FLAGS>
```
3. Procurar por memory leaks de forma automática com:
```
$ ./memcheck.sh <FLAGS>
```
## Flags:
* `-b <CAMINHO-PARA-EXECUTAVEL>`: Definir o executável a testar, em caso de omição da flag o default é 'a.out'.
* `-t <CAMINHO-PARA-TESTES>`: Definir os testes, em caso de omição da flag o default é a diretoria 'tests'.
* `-h`: Mostrar utilização.
## test.sh:
Testa o programa normalmente. Executa os testes e vê as diferencas entre o output esperado e o fornecido.
## memcheck.sh:
Executa os testes sem verificar o output. Procura por memory leaks com a ferramenta valgrind.
