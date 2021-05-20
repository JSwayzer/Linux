#!/bin/bash
#programa para baixar videos e imagens do site 4chan
#version: 0.2
#data de criacao: 01/09/2018 - 15:23h America/Sao Paulo
#autor: Johnny S.
#data de alteracao: 03/09/2018 - 17:06 America/Sao Paulo
#data de alteracao: 05/09/2018 - 15:50 America/Sao Paulo

clear
dw=/media/sf_D_DRIVE/y/b/
#echo "setting directory...";sleep 2;ls -lhd $dw;sleep 1;echo "Done!"; clear

read -p 'Insira o link: ' link
#echo "Now dowloading... ";echo
curl $link -o arq.html
#clear

#createDir=\_`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d"/" -f3 | sed 's/\//_/g' | sed 's/:/_/g' | sed 's/?/_/g'| sed 's/<//g' | sed 's/ /\\ /g'` #extrair o titulo da pagina para nomear o arquivo html e o diretorio
#echo $createDir

createDir2=`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d">" -f3 | sed 's/\//_/g' | sed 's/|/_/g' | sed '/\\/_/g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/ /\\ /g' | sed 's/-_title//g'`
echo $createDir2

createDir3=\_`sed 's/=/\n/g' arq.html | grep rss+xml` 
#echo $createDir3

dir=$dw$createDir2\_files
#echo $dir

if [ -d "$dir" ]
then
	echo "diretorio $dir jah exite"
else
	echo "criando diretorio $dir";echo
#	mkdir $dw"_`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d"/" -f3,4 | sed 's/\//_/g' | sed 's/:/_/g' | sed 's/?/_/g'| sed 's/<//g' | sed 's/ /\\ /g'`_files"
	mkdir $dw"`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d">" -f3 | sed 's/\//_/g' | sed 's/|/_/g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/ /\\ /g' | sed 's/-_title//g'`_files"
#	echo "Extraindo os links das imagens..."
fi

cat arq.html  | tr '=' '\012' | grep i.4cdn | grep -v s. | sort -u | cut -d'"' -f2 > images.txt
numimg=`cat images.txt | wc -l`
imgNumb=0
for i in `cat images.txt` ;do
	name=$(echo $i | cut -d"/" -f5)
#	echo "$dir/$name"
	img=$(($img+1))
	if [ -f "$dir/$name" ]
	then
		echo "$name jah existe"
		echo "Baixando $img de $numimg imagens econtradas"
##		echo "esse arquivo nao existe"
##		echo "o nome do arquivo eh: " $name
##		i=http:$i
##		echo "encontrada a imagem $i"
##		echo "baixando imagem..."; echo
##		curl $i > $dw$createDir\_files\/$name
##		echo "Imagem $name foi salva";echo;echo;echo
	else
#		$imgNumb=$(($imgNumb+1))
		echo "Baixando $img de $numimg imagens encontradas"
		echo "$name"
		i=http:$i
		curl $i > "$dir/$name"
		echo "Imagem $name foi salva";echo;echo;echo
	fi
done;
