#calculadora de IP
clear
read -p 'Qual a rede? ' rede
# para criar um subshell pode-se usar $() ou ``
bits=$(echo "$rede"|cut -d'/' -f2)
echo "a rede sera calculada cusando $bits"
bits=$(( 32 - $bits))
echo "dos 32 bits totais sera usado os $bits bits resultantes do calculo"
hosts=$(( 2 ** $bits -2 ))
echo "$hosts enderecos podem ser emplementados nesta rede"
