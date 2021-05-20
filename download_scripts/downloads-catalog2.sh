#!/bin/bash
#programa para baixar videos e imagens do site 4chan, do catalogo inteiro
#version: 0.2
#data de criacao: Sat Oct 13 11:13:17 2018 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: Wed Jan 27 19:13:38 2021 - America/Sao Paulo
#alteracao realizada para incluir funcao de salvar arquivo com nome que aparece no site
#alteracao realizada para incluir funcao que possibilita salvar os arquivos com norme completo
#alteracao realizada para incluir funcao para converter a pagina em arquivo pdf para posterior leitura da interacao entre os anons
clear
#setup destination directory
dw=/media/sf_D_DRIVE/y/b/

#The code below is used to download the catalog and extract all the pages inside it.
wget https://boards.4chan.org/gif/catalog -O arq.html

cat arq.html | sed 's/,\"teaser\"/\n/g' | grep -v -E 'count|robots' | awk -F'"' '{print "https://boards.4chan.org/gif/thread/" $4}' >> images-catalog.txt

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
	#-----------------------------------------------------------------------------------------------
	#esse codigo eh para pegar apenas os arquivos de nomes longos
	#filtra pelo tipo de arquivo com grep
	#primeiro awk eh para pegar os campos link, nome curto e nome longo dos arquivo
	#segundo e terceiro awk sao para organizar os daos em link, nome do arquivo, tamanho e resolucao
	#quarto awk eh para o tipo de arquivo e colocar no final
	#quinto awk eh para polir e deixar a linha sem nenhuma informacao depois do tipo de arquivo
	cat arq.html | tr ':' '\012' | grep _blank | grep -E 'webm|gif|jpg|jpeg|png' | sed 's/\ /+/g' | awk -F'"' '{print $7":"$5":"$4":"$2}' | awk -F'>' '{print $2":"$3":"$4}' | grep '(...)' | awk -F':' '{print $5":"$6":"$2}' | sed 's/<\/a//g' | sed 's/<\/div//g' | awk -F'.' '{print $0"."$4}' | awk -F':' '{$4=""; print $0}' | sed 's/\ /+/g' | grep -v 'a+data-utc' | sed 's/is2\.4chan/i\.4cdn/g' > images.txt

	#esse codigo eh para pegar apenas os arquivos de nomes curtos
	#filtra pelo tipo de arquivo com grep
	#primeiro awk eh para pegar os campos link, nome curto e nome longo dos arquivo
	#segundo e terceiro awk sao para organizar os daos em link, nome do arquivo, tamanho e resolucao
	#quarto awk eh para o tipo de arquivo e colocar no final
	#quinto awk eh para polir e deixar a linha sem nenhuma informacao depois do tipo de arquivo
	cat arq.html | tr ':' '\012' | grep _blank | grep -E 'webm|gif|jpg|jpeg|png' | sed 's/\ /+/g' | awk -F'"' '{print $7":"$5":"$4":"$2}' | awk -F'>' '{print $2":"$3":"$4}' | awk -F':' '{print $5":"$1":"$2}' | sed 's/<\/a//g' | sed 's/<\/div//g' | grep -v '(...)' | awk -F'.' '{print $0"."$4}' | awk -F':' '{$4=""; print $0}' | sed 's/\ /+/g' | grep -v 'a+data-utc' | sed 's/is2\.4chan/i\.4cdn/g' >> images.txt
	#--------------------------------------------------------------------------------------------------
	
	#Numero de imgagens encontradas no site
	imgtotal=`cat images.txt | wc -l`
	#Qual arquivo esta baixando agora	
	imgnow=0
	tab=0
	
	#Code para converter a pagina em arquivo pdf
	if [ -f "$dir.pdf" ]
	then
		echo "site $l ja foi salvo em pdf anteriormente!"
	else
		wkhtmltopdf $l "$dir.pdf"
	fi
			
	for i in `cat images.txt` ;do
		link=$(echo $i | cut -d"+" -f1)
		name=$(echo $i | sed 's/).webm+/).webm/g' | sed 's/).gif+/).gif/g' | sed 's/).jpe+/).jpg/g' | sed 's/).jpeg+/).jpeg/g' | sed 's/).png+/).png/g' | sed 's/+/ /g' | cut -d" " -f 2- | sed 's/\//_/g' | sed 's/|/_/g' | sed 's/\\/ /g' | sed 's/</-/g' | sed 's/>/-/g' | sed 's/*/-/g' | sed 's/:/-/g' | sed 's/“/-/g' | sed 's/?/_/g' | sed 's/\ \ / /g')
		
		#sleep 3
		imgtotalgeral=$(($imgtotalgeral+1))
		imgnow=$(($imgnow+1))
		
		#Verificar se o arquivo existe, se nao baixa os arquivos encontrados
		#this 3 lines below exists only to make sure that the file exists or not, if not it'll be downloade
		#Note that it was needed to remove space from both variables, name and filealreadyexists, becoming namewithouspace and filealreadyexistswithoutspace. This was needed because the conditional If doens't accept space in the strings for compare

		#namewhitoutspace=$(echo $name | sed 's/ //g')
		#filealreadyexists=$(ls "$dir/$name" 2> /dev/null)
		#filealreadyexistswithoutspace=$(echo $filealreadyexists | sed 's/ //g' | awk -F'/' '{print $7}')
		
		#if [ $namewithoutspace==$filealreadyexistswithoutspace ]
		if [ "$(ls "$dir/$name" 2> /dev/null | wc -l)" == '1' ]
		then
			#echo "now it works!"
			tab=$(($tab+1))
		#echo "$namewhitoutspace"
		#echo "$filealreadyexistswithoutspace"
		else
			imgtotalbaixados=$(($imgtotalbaixados+1))
			echo "site $sitedown de $sitesfound | $imgtotalgeral arquivos salvos"
			echo "Baixando $imgnow de $imgtotal imagens encontradas no site atual"
			i=https:$link
			curl $i > "$dir/$name"
			echo "Imagem $name foi salva";echo;echo;echo
		fi
	done;
done;
echo "site $sitedown de $sitesfound | $imgtotalbaixados arquivos salvos de $imgtotalgeral"
cat images-catalog.txt >> img-bkp
