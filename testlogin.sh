#!/bin/bash
##Programa para testar a existência do arquivo /etc/nologin
file=/etc/nologin
if test -f /etc/nologin
then
	echo "Apenas o root poderá fazer o login"
else if test -d /etc/nologin
then
	echo "$file é um diretório"
else
	echo "Login liberado para todos os usuários"
fi
fi
