#!/usr/bin/tcsh

# Esse script pode ser usado para transferência de dados entre a sua máquina local e o cenapad.

# use: tcsh cp_lovelace.tcsh <job> <type> <arquivo_ou_diretório>
# examplo: tcsh cp_lovelace.tcsh send file <arquivo>
# examplo: tcsh cp_lovelace.tcsh get  dir  <diretório>

set user_name = 'felipecr' # nome do usuário na lovelace
echo User: $user_name

set job = $1 # 'send' ou 'get'
echo Job: $job

set type = "$2" # 'file' ou 'dir'
echo Type: $type

set name = $3 # nome do arquivo ou diretório
echo A ser copiado: $name

set DIR = "~/homelovelace/Troca" # caminho na lovelace (Atenção: Não ponha '/' no final do caminho)

if ( $type == 'file' ) then
  goto copy_file
else if ( $type == 'dir' ) then
  goto copy_directory
else if
  echo O parâmetro 'Type' deve ser 'file' ou 'dir'.
  exit
endif

copy_file:

if ( $job == 'send' ) then
  echo Copiando arquivo para a lovelace...
  echo Caminho na lovelace: $DIR
  scp -P 31459 $name $user_name'@cenapad.unicamp.br:'$DIR
  exit
else if ( $job == 'get' ) then 
  echo Copiando arquivo da lovelace...
  echo Caminho na lovelace: $DIR
  scp -P 31459 $user_name'@cenapad.unicamp.br:'$DIR/$name .
  exit
else 
  echo O parâmetro 'Job' deve ser 'send' or 'get'.
endif

copy_directory:

if ( $job == 'send' ) then
  echo Copiando arquivo para a lovelace...
  echo Caminho na lovelace: $DIR
  scp -rP 31459 $name $user_name'@cenapad.unicamp.br:'$DIR
  exit
else if ( $job == 'get' ) then 
  echo Copiando arquivo da lovelace...
  echo Caminho na lovelace: $DIR
  scp -rP 31459 $user_name'@cenapad.unicamp.br:'$DIR/$name .
  exit
else
  echo O parâmetro 'Job' deve ser 'send' or 'get'.
  exit
endif

