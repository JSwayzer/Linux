#!/bin/bash
#programa para baixar videos e imagens do site 4chan, do catalogo inteiro
#version: 0.2
#data de criacao: Sat Oct 13 11:13:17 2018 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: Sat May 04 00:25:29 2019 - America/Sao Paulo
#alteracao realizada para incluir funcao de salvar arquivo com nome que aparece no site
#alteracao realizada para incluir funcao que possibilita salvar os arquivos com norme completo
clear
#setup destination directory
dw=/media/sf_D_DRIVE/y/KOF/

#Verificar quantos sites foram encontrados
sitesfound=`cat snkfandom.catalog.txt | wc -l`

#Ler cada linha dentro do arquivo images-catalog.txt
for l in `cat snkfandom.catalog.txt` ;do
	#qual o numero do site a ser baixado agora
	sitedown=$(($sitedown+1))
	echo $sitedown
	#"Now dowloading... "
	curl $l -o arq.html
		
	#Identificar o nome do link para criar o diretorio com o mesmo nome
	createDir2=`grep '<h1' arq.html | grep 'title">' | awk -F'/' '{print $1}' | awk -F'>' '{print $2}'`
	
	dir=$dw$createDir2
	echo $dir

	#Verificar se o diretorio existe, se nao cria o diretorio
	if [ -d "$dir" ]
	then
		echo "diretorio $dir jah exite"
	else
		echo "criando diretorio $dir";echo
		mkdir $dw"`grep '<h1' arq.html | grep 'title">' | awk -F'/' '{print $1}' | awk -F'>' '{print $2}'`"
	fi
	echo $dw
	

	#Extrair os links das imagens
	#-----------------------------------------------------------------------------------------------
	#filtra pelo tipo de arquivo com grep
	#primeiro awk eh para pegar os campos link, nome curto e nome longo dos arquivo
	#segundo e terceiro awk sao para organizar os daos em link, nome do arquivo, tamanho e resolucao
	#quarto awk eh para o tipo de arquivo e colocar no final
	#quinto awk eh para polir e deixar a linha sem nenhuma informacao depois do tipo de arquivo
	cat arq.html | tr ':' '\012' | grep -E 'webm|gif|jpg|jpeg|png' | grep 'scale-to-width-down' | awk -F'"' '{print $1}' | sed 's/\/scale-to-width-down\/...//g' > images.txt
	#--------------------------------------------------------------------------------------------------
	
	#Numero de imgagens encontradas no site
	imgtotal=`cat images.txt | wc -l`
	#Qual arquivo esta baixando agora	
	imgnow=0
	tab=0
	for i in `cat images.txt` ;do
		#echo "o que esta em i" $i;echo
		link=$(echo $i | cut -d":" -f1)
		name=$(echo $i | awk -F'/' '{print $8}' | sed 's/_/ /g')
		#echo "o que esta em i" $i;echo;echo;echo
		#echo "Link >>>> " $link
		#echo "Name >>>> " $name
		#sleep 3
		imgtotalgeral=$(($imgtotalgeral+1))
		imgnow=$(($imgnow+1))
		#Verificar se o arquivo existe, se nao baixa os arquivos encontrados
		if [ -f "$dir/$name" ]
		then
			tab=$(($tab+1))
			#echo $tab
		else
			imgtotalbaixados=$(($imgtotalbaixados+1))
			echo "site $sitedown de $sitesfound | $imgtotalgeral arquivos salvos"
			echo "Baixando $imgnow de $imgtotal imagens encontradas no site atual"
			i=http:$link
			curl $i > "$dir/$name"
			#echo "Complete Link >>>>> "$i
			echo "Imagem $name foi salva";echo;echo;echo
		fi
	done;
done;
echo "site $sitedown de $sitesfound | $imgtotalbaixados arquivos salvos de $imgtotalgeral"
#echo > images-catalog.txt
