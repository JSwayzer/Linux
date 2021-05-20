#!/bin/bash
##Programa para comparação de arquivos
read -p 'Digite o 1o arquivo	' arq1
read -p 'Digite o 2o arquivo	' arq2

if test -f $arq1 && test -f $arq2
then
	if test $arq1 -ot $arq2
	then
		echo "$arq1 é mais velho que $arq2"
	else if test $arq1 -ef $arq2
	then
		echo "$arq1 é o mesmo arquivo que $arq2"
	else
		echo "$arq1 é mais novo que $arq2"
	fi
fi
else
	echo "um dos arquivos não exite"
fi
