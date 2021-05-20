#!/bin/bash
#programa para baixar paginas web completas com imagens e outros arquivos
#version: 0.1
#data de criacao: Wed Jan 27 17:38:17 2021 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: 
#
#
clear
#setup destination directory
dw=/media/sf_D_DRIVE/Documents/Read/

#Verificar quantos sites foram encontrados
sitesfound=`cat images-catalog.txt | wc -l`

#Ler cada linha dentro do arquivo images-catalog.txt
for l in `cat images-catalog.txt` ;do
	#qual o numero do site a ser baixado agora
	sitedown=$(($sitedown+1))
	echo $sitedown
	#"Now dowloading... "
	curl $l -o arq.html
		
	#Identificar o nome do link para criar o diretorio com o mesmo nome
	createDir2=`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d">" -f3 | sed 's/\//_/g' | sed 's/|/_/g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/ /\\ /g' | sed 's/-_title//g' | sed 's/ /_/g'`
	
	dir=$dw$createDir2\_files
	echo $dir

	#Verificar se o diretorio existe, se nao cria o diretorio
	if [ -d "$dir" ]
	then
		echo "diretorio $dir jah exite"
	else
		echo "criando diretorio $dir";echo
		mkdir $dw"`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d">" -f3 | sed 's/\//_/g' | sed 's/|/_/g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/ /\\ /g' | sed 's/-_title//g' | sed 's/ /_/g'`_files"
	fi
	

			imgtotalbaixados=$(($imgtotalbaixados+1))
			#echo "site $sitedown de $sitesfound | $imgtotalgeral arquivos salvos"
			#echo "Baixando $imgnow de $imgtotal imagens encontradas no site atual"
			#i=https:$link
#			wget --adjust-extension --span-hosts --convert-links --backup-converted --no-directories --timestamping --page-requisites --directory-prefix=$dir $l 
			wkhtmltopdf $l $dir.pdf
			#echo "Imagem $name foi salva";echo;echo;echo
done;
#echo "site $sitedown de $sitesfound | $imgtotalbaixados arquivos salvos de $imgtotalgeral"
#cat images-catalog.txt2 >> img-bkp
