#!/bin/bash
# Nome do arquivo: backup.sh
#
# Script que realiza backup dos diretorios ou arquivos
# 
# Versão 1.0: Gera um arquivo .tar.gz dos arquivos originais
#
#################################
# Feito por: Marcello Marafioti #
# Data: 14/11/2018              #
#################################
#
#


MENSAGEM_USO="
Uso: $(basename "$0") [-h | -v]

  -h, --help        Mostra esta tela de ajuda e sai
  -v, --version     Mostra a versao do programa e sai

###### MODO DE USO DO SCRIPT ######
1 - Executar o script
2 - Vai solicitar o diretorio ou arquivo
* Se for DIRETORIO colocar o caminho absoluto
* Se for ARQUIVO colocar o caminho absoluto com o arquivo no final

Exemplo:
Digite o diretorio ou arquivo:
Diretorio = /home/user/Documentos
Arquivo = /home/user/Documentos/Contrato.doc
###################################
"

# Tratamento das opções de linha de comando
case "$1" in
	-h | --help)
		echo "$MENSAGEM_USO"
		exit 0
	;;

	-v | --version)
		echo -n $(basename "$0")
		# Extrai a versão diretamente dos cabeçalhos do programa
		grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
		exit 0
	;;

	*)
		if test -n "$1"
		then
			echo Opção inválida: $1
			exit 1
		fi
	;;
esac

# Processamento do script 

clear
echo "Para obter ajuda execute o script com a opcao -h"
echo
echo Qual o diretorio ou arquivo voce quer fazer o backup?
read PASTA

cd /teste/$PASTA

mkdir /teste/$PASTA-pdf

for i in $(ls *.zip) ; 
do unzip $i -d /teste/$PASTA-pdf/ ;
done 2> /teste/$PASTA-pdf/backup.log

# Filtrando  erros de logs
cat /teste/$PASTA-pdf/backup.log | grep -i unzip > /teste/$PASTA-pdf/backupFiltro.log

# Cortando o que não presta 
cut -d "." -f 1 backupFiltro.log > errorBackup.log

# Removendo o log que e lixo 
rm -rf /teste/$PASTA-pdf/backupFiltro.log
