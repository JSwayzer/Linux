#!/bin/bash
#programa para baixar videos e imagens do site 4chan, do catalogo inteiro
#version: 0.2
#data de criacao: Sat Oct 13 11:13:17 2018 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: Sat May 04 00:25:29 2019 - America/Sao Paulo
#alteracao realizada para incluir funcao de salvar arquivo com nome que aparece no site

clear
#setup destination directory
dw=/media/sf_D_DRIVE/y/b/

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
	createDir2=`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d">" -f3 | sed 's/\//_/g' | sed 's/|/_/g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/ /\\ /g' | sed 's/-_title//g'`
	
	dir=$dw$createDir2\_files
	echo $dir

	#Verificar se o diretorio existe, se nao cria o diretorio
	if [ -d "$dir" ]
	then
		echo "diretorio $dir jah exite"
	else
		echo "criando diretorio $dir";echo
		mkdir $dw"`sed 's/=/\n/g' arq.html | grep rss+xml | cut -d">" -f3 | sed 's/\//_/g' | sed 's/|/_/g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/ /\\ /g' | sed 's/-_title//g'`_files"
	fi
	
	#Extrair os links das imagens
	cat arq.html | tr '=' '\012' | grep is2 | grep -v alt | sort -u | cut -d'"' -f2 > images.txt
	cat arq.html | tr '=' '\012' | grep _blank | grep -E 'webm|gif|jpg|jpeg|png' | grep -v alt | cut -d'>' -f2,3 | cut -d'<' -f1,2 | sed 's/<\/a>//g' | sed 's/ /_/g' > imagesname.txt
	cat images.txt | cut -d "." -f4 > filetype.txt
	sed 's/^/./' filetype.txt | cat -n > t3.txt
	cat -n images.txt > t1.txt
	cat -n imagesname.txt > t2.txt
	join t1.txt t2.txt > t4.txt
	join t4.txt t3.txt > t5.txt	
	cat t5.txt | sed 's/ /_/g' | cut -d" " -f 2- > t6.txt
	#Numero de imgagens encontradas no site
	imgtotal=`cat images.txt | wc -l`
	#Qual arquivo esta baixando agora	
	imgnow=0
	tab=0
	for i in `cat t6.txt` ;do
		link=$(echo $i | cut -d"_" -f2)
		name=$(echo $i | sed 's/_/ /g' | sed 's/) \./)\./g' | cut -d" " -f 3-)
		#echo "o que esta em i" $i
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
cat images-catalog.txt >> img-bkp
#echo > images-catalog.txt
