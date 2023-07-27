# cp_lovelace
Shell script para transferência de dados entre o servidor e a máquina local.

Esse script pode ser usado para transferência de arquivos para e a partir do ambiente lovelace (CENAPAD). É preciso ter na home da lovelace um diretório chamado "Troca". 

O script "cp_lovelace.tcsh"  deve estar no $PATH para poder ser utilizado de qualquer lugar na máquina local.

Antes de usar é preciso também trocar o nome do usuário dentro do script (deve ser o usuário da lovelace). Depois de executar o comando basta entrar com a senha e autenticação.

Para simplicar ainda mais a utilização do script é possível incluir no ".bashrc":

```
alias send="cp_lovelace.tcsh send"
alias get="cp_lovelace.tcsh get"
```

Assim, para enviar um arquivo para a lovelace é só fazer:

```
send file <nome_do_arquivo>
```

Ou se for um diretório:

```
send dir <nome_do_diretório>
```

E para baixar basta:

```
get file <nome_do_arquivo>
get dir <nome_do_diretório>
```

Se o arquivo for enviado a partir da máquina locar vai cair em "~/homelovelace/Troca" ou, se for baixado, o arquivo (ou diretório) deve estar nessa pasta também. Ao ser baixado, o arquivo cai na pasta atual (não é preciso criar um diretório "~/Troca" na máquina local). Se o arquivo que precisa ser baixado a lovelace for muito grande para ser copiado para o diretório Troca, basta criar links simbólicos que apontam para ele usando "ln -s".

Esse mesmo script pode ser adaptado para outros clusters também.
