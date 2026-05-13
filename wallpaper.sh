######################################################################################################################
############################################ SCRIPT PARA WALLPAPER ##################################################
######################################################################################################################
#!/bin/bash

#cria variaveis das cores: Vermelho, Verde, texto_normal
RED="\e[31m"
GREEN="\e[32m"
RESET="\e[0m"
YELLOW="\x1b[33m"

#verifica se o mpvpaper esta instalado
if ! command -v mpvpaper >/dev/null; then
  echo -e "${RED}mpvpaper nao instalado${RESET}"
  exit 1
fi

if ! command -v awww >/dev/null; then
  echo -e "${RED}awww nao instalado${RESET}"
  exit 1
fi

#cria variável para receber o caminho do wallpaper
PATH_WALLPAPER=$1

#verifica se a variavel PATH_WALLPAPER esta vazia
if [[ -z "$PATH_WALLPAPER" ]]; then
  echo -e "${YELLOW}Use: wallpaper <caminho do arquivo>${RESET}"
  exit 1
fi

if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
  echo -e "${YELLOW}Uso: wallpaper <caminho_do_arquivo>${RESET}"
  echo -e ""
  echo -e "Descrição: Altera o wallpaper da area de trabalho para imagens ou vídeos."
  echo -e ""
  echo -e "Exemplo: wallpaper ~/Imagens/meu_video.mp4"
  echo -e
  echo -e "${GREEN}Opções:${RESET}"
  echo -e " -h, --help Mostra mensagem de ajuda"
  exit 0
fi

#verifica se o arquivo existe e se eh valido
if [[ -f "$PATH_WALLPAPER" ]]; then

  #Acha a extensao do arquivo
  EXTENSAO="${PATH_WALLPAPER##*.}"
  #Utiliza o ##*. --> pega o valor da variavel e tira tudo antes dele ficando so a extensao
  #encerra o mpvpaper antes de iniciar
  pkill mpvpaper

  #Tomar decisao para usar video ou imagem
  if [[ "$EXTENSAO" = "mp4" ]]; then
    nohup mpvpaper -o "loop" '*' "${PATH_WALLPAPER}" &>/dev/null &
  elif [[ "$EXTENSAO" = "jpeg" || "$EXTENSAO" = "png" || "$EXTENSAO" = "jpg" ]]; then
    awww img "${PATH_WALLPAPER}"
  else
    echo -e "${RED}Formato invalido {$EXTENSAO}${RESET}"
  fi
else
  echo -e "${RED}Arquivo nao existe${RESET}"
  exit 1
fi
