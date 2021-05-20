#!/bin/bash
#programa para baixar videos e imagens do site 4chan, do catalogo inteiro
#version: 0.2
#data de criacao: Sat Oct 13 11:13:17 2018 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: Sat May 04 00:25:29 2019 - America/Sao Paulo
#alteracao realizada para incluir funcao de salvar arquivo com nome que aparece no site
#alteracao realizada para incluir funcao que possibilita salvar os arquivos com norme completo
clear
#Ler cada linha dentro do arquivo images-catalog.txt
for i in `cat ~/wonderwoman.txt` ;do
	echo "o que esta em i" $i;echo
	link=$(echo $i | cut -d":" -f1)
	name=$(echo $i | cut -d":" -f2 | sed 's/_/ /g')
	#sleep 3
	echo $name
	i=http:$link
	wget $i -O "$name"
	echo "Imagem $name foi salva";echo;echo;echo
done;
echo "site $sitedown de $sitesfound | $imgtotalbaixados arquivos salvos de $imgtotalgeral"
