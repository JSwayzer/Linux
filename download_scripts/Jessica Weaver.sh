==> jessica-weaver-listal2.sh <==
#!/bin/bash
#programa para baixar livros as Fotos da Jessica Weaver do Site yostagram
#version: 0
#data de criacao: Mon Apr 20 21:47:33 EDT 2020 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: - America/Sao Paulo
#
#
clear
#setup destination directory
dw=/media/sf_D_DRIVE/y/'Jessica Weaver2'

#Verificar quantos sites foram encontrados
sitesfound=`cat 'yostagram.txt' | wc -l`
echo $sitesfound
#Ler cada linha dentro do arquivo images-catalog.txt
for l in `cat jessica-listal.txt` ;do
#	#qual o numero do site a ser baixado agora
	i=$(($i+1))
#	echo $sitedown
#	#"Now dowloading... "
#	echo $l > springer
#	link=`cat springer | sed 's/+/ /g' | awk -F'!' '{print $3}'`
#	echo $link
#	name=`cat springer | sed 's/+/ /g' | awk -F'!' '{print $1}'`
#	echo $name
#	
		wget $l -O jessicaweaver.html
		
		grep "pure-img" jessicaweaver.html  | awk -F"'" '{print $4}' | xargs curl > "740full-jessica-weaver$i.jpg"
done;

==> jessica-weaver-listal.sh <==
#!/bin/bash
#programa para baixar livros as Fotos da Jessica Weaver do Site listal 
#version: 0
#data de criacao: Mon Apr 20 23:25:19 EDT 2020 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: - America/Sao Paulo
#
#
clear
#setup destination directory
dw=/media/sf_D_DRIVE/y/'Jessica Weaver2'

#Verificar quantos sites foram encontrados
sitesfound=`cat 'yostagram.txt' | wc -l`
echo $sitesfound
#Ler cada linha dentro do arquivo images-catalog.txt
for l in {1..12} ;do
		wget https://www.listal.com/jessica-weaver/pictures/$l -O jessicaweaver.html
		
		grep "'https://www.listal.com/viewimage/" 1  | awk -F"'" '{print $6}' >> jessica-listal.txt
#		cp livro "$dw$name.html"
#		sleep 100
done;

==> jessica-weaver-yostagram.sh <==
#!/bin/bash
#programa para baixar livros as Fotos da Jessica Weaver do Site yostagram
#version: 0
#data de criacao: Mon Apr 20 21:47:33 EDT 2020 - America/Sao Paulo
#autor: Johnny S.
#data de alteracao: - America/Sao Paulo
#
#
clear
#setup destination directory
dw=/media/sf_D_DRIVE/y/'Jessica Weaver'

#Verificar quantos sites foram encontrados
sitesfound=`cat 'yostagram.txt' | wc -l`
echo $sitesfound
#Ler cada linha dentro do arquivo images-catalog.txt
for l in {1..633} ;do
#	#qual o numero do site a ser baixado agora
#	sitedown=$(($sitedown+1))
#	echo $sitedown
#	#"Now dowloading... "
#	echo $l > springer
#	link=`cat springer | sed 's/+/ /g' | awk -F'!' '{print $3}'`
#	echo $link
#	name=`cat springer | sed 's/+/ /g' | awk -F'!' '{print $1}'`
#	echo $name
#	
	if [ -f "$dw/jessica-weaver-$l.jpg" ] ;then
		echo "$dw/jessica-weaver-$l.jpg"
		echo "image already downloaded!"
	else
		echo "$dwjessica-weaver-$l.jpg"
		wget https://yostagram.com/jessica-weaver-instagram-$l/ -O jessicaweaver.html
		
		grep -i 'a class="dwnldButton"' jessicaweaver.html  | awk -F'"' '{print $4}' | xargs curl > "jessica-weaver-$l.jpg"
#		grep '/download/epub/10' livro | sed 's/ /\n/g' | grep 'href' | head -n1 | awk -F'"' '{print "https://link.springer.com"$2}' | xargs curl > "$dw$name.epub" 
#		cp livro "$dw$name.html"
#		sleep 100
	fi
done;
