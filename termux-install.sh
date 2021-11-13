#!/bin/bash

# Colores
r="\e[1;91m"
v="\e[1;92m"
a="\e[1;93m"
b="\e[1;39m"
m="\e[1;96m"
z="\e[1;94m"
y='\e[1;33m'

# Pequeñas variables
folder=`pwd`
utils="$folder/utils"

net(){
  
  echo -e $a"Chequeando conexion a internet"
  sleep 2
  ping -c 1 ifconfig.me > /dev/null 2>&1
  if [[ "$?" != 0 ]]
  then
    echo -e $a"Estado de conexion a internet: ${r}Desconectado"
    echo
    echo -e $r"Se necesita que tenga conexion a internet"
    echo
    echo -e $y"Saliendo de el instalador "
    echo && sleep 3
    exit
  else

    echo -e $a"Estado de conexion a internet: ${v}Conectado"
    sleep 2
  fi
}

requerimientos(){
banner
echo -e $m"Actualizando repositorios" 
sleep 5
banner
apt-get update
banner
echo -e $m"Instalando y comprobando requerimientos"
sleep 2
echo -e "$b"

# Instalacion python
if ! [ -x "$(command -v python)" ]; then
  echo 'Python no instalado. Se instalara.' >&2
  apt-get install python -y &> /dev/null && echo "Python se instalo" || echo "Python no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos
else
echo "Python ya esta instalado"
sleep 2
fi

# Instalacion wget
if ! [ -x "$(command -v wget)" ]; then
  echo 'Wget no instalado. Se instalara.' >&2
  apt-get install wget -y &> /dev/null && echo "Wget se instalo" || echo "Wget no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos
else
echo "Wget ya esta instalado"
sleep 1
fi

# Instalacion curl
if ! [ -x "$(command -v curl)" ]; then
  echo 'Curl no instalado. Se instalara.' >&2
  apt-get install curl -y &> /dev/null && echo "Curl se instalo" || echo "Curl no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos
else
echo "Curl ya esta instalado"
sleep 1
fi

# Instalacion openssl
if ! [ -x "$(command -v openssl)" ]; then
  echo 'Openssl no instalado. Se instalara.' >&2
  apt-get install openssl-tool -y &> /dev/null && echo "Openssl se instalo" || echo "Openssl no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos
else
echo "Openssl ya esta instalado"
sleep 1
fi

# Instalacion php
if ! [ -x "$(command -v php)" ]; then
  echo 'Php no instalado. Se instalara.' >&2
  apt-get install php -y &> /dev/null && echo "Php se instalo" || echo "Php no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos
else
echo "Php ya esta instalado"
sleep 1
fi

#Instalacion 7z
if [ "$(dpkg -l | awk '/p7zip/ {print }'|wc -l)" -ge 1 ]; then
echo "7z ya esta instalado"
sleep 1
else
echo "7z no instalado. Se instalara".
apt-get install p7zip -y &> /dev/null && echo "7z se instalo" || echo "7z no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && gnome_terminal
fi

}

requerimientos2(){
echo ""
echo -e $z"Instalando requerimientos pip"
echo -e "$b "
pip install bs4 requests Django==2.2.19
echo ""
  echo -e $a"Todos los requerimientos fueron instalados exitosamente"
  sleep 5
  banner
}

# Opcion principal/Instalacion
principal(){    
    banner
    echo -e "$v¿Que deseas?\n"
    echo -e "$v[$b 1$v ] Instalacion normal"
    echo -e "$v[$b 2$v ] Arreglar problemas con AIOPhish\n"
        
    read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' opc_principal    
    if [[ $opc_principal == "1" || $opc_principal == "01" ]];then
        basica

    elif [[ $opc_principal == "2" || $opc_principal == "02" ]];then
        ayuda    	  

    else
        echo -e "$r[!]$b Opción invalida"
        sleep 1
        principal
    fi

}

basica(){
  
  banner
  net
  requerimientos 
  banner
  requerimientos2
  files
  tunnel
  banner
  finish

}

tunnel(){
cd $folder/servidores && unzip .servidores.zip > /dev/null 2>&1
rm tunnel_gnome_terminal.sh tunnel_qterminal.sh tunnel_xfce4_terminal.sh rm tunnel.sh > /dev/null 2>&1
mv tunnel_termux.sh tunnel.sh

}

findlocalxpose(){
cd $folder
printf "Configurando LocalXpose "
sleep 0.5
printf "."
sleep 0.5
printf "."
sleep 0.5
printf "."
sleep 0.5
printf "."
sleep 0.5
printf "."
echo ""
if [[ -e loclx ]]; then
else
archa=$(uname -a | grep -o 'arm' | head -n1)
arch2a=$(uname -a | grep -o 'Android' | head -n1)
if [[ $archa == *'arm'* ]] || [[ $arch2a == *'Android'* ]] ; then
echo -e "$v[*]$b Instalando LocalXpose..."
curl -LO https://lxpdownloads.sgp1.digitaloceanspaces.com/cli/loclx-linux-arm.zip > /dev/null 2>&1
if [[ -e loclx-linux-arm.zip ]]; then
unzip loclx-linux-arm.zip > /dev/null 2>&1
rm -rf loclx-linux-arm.zip
chmod +x loclx
else
echo -e "$r Error, intentar de nuevo"
exit 1
fi
else
echo -e "$v[*]$b Instalando LocalXpose..."
curl -LO https://lxpdownloads.sgp1.digitaloceanspaces.com/cli/loclx-linux-386.zip > /dev/null 2>&1 
if [[ -e loclx-linux-386.zip ]]; then
unzip loclx-linux-386.zip > /dev/null 2>&1
rm -rf loclx-linux-386.zip
chmod +x loclx
else
echo -e "$r Error, intentar de nuevo"
exit 1
      fi

                fi

        fi
}

ayuda(){
  
    banner
    echo -e "$v¿Que problemas tienes?\n"
    echo -e "$v[$b 1$v ] Problemas con Ngrok"
    echo -e "$v[$b 2$v ] Problemas con LocalXpose"
    echo -e "$v[$b 3$v ] Otro"
    echo -e "$v[$b 4$v ] Volver atras\n"

    read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' ayuda
    
    if [[ $ayuda == "1" || $ayuda == "01" ]];then
    banner
    cd $utils && cat .ngrok.txt
    echo ""
    echo ""
    read -p $'\e[1;77m[Pulse enter para continuar] \e[0m' -n 1 -r
    ayuda

    elif [[ $ayuda == "2" || $ayuda == "02" ]];then
    banner
    cd $utils && cat .xpose.txt
    echo ""
    echo ""
    read -p $'\e[1;77m[Pulse enter para continuar] \e[0m' -n 1 -r
    ayuda


    elif [[ $ayuda == "3" || $ayuda == "03" ]];then
    banner
    cd $utils && cat .dm.txt
    echo ""
    echo ""
    read -p $'\e[1;77m[Pulse enter para continuar] \e[0m' -n 1 -r
    ayuda

    elif [[ $ayuda == "4" || $ayuda == "04" ]];then
    principal

    else
        echo -e "$r[!]$b Opción invalida"
        sleep 1
        ayuda
	 fi

}


banner(){
clear

echo -e '\e[\e[1;94m
     ____           __        __           _           
    /  _/___  _____/ /_____ _/ /___ ______(_)___  ____ 
    / // __ \/ ___/ __/ __ `/ / __ `/ ___/ / __ \/ __ \
  _/ // / / (__  ) /_/ /_/ / / /_/ / /__/ / /_/ / / / /
 /___/_/ /_/____/\__/\__,_/_/\__,_/\___/_/\____/_/ /_/ 
                                                                   
          ___    ________  ____  __    _      __  
         /   |  /  _/ __ \/ __ \/ /_  (_)____/ /_ 
        / /| |  / // / / / /_/ / __ \/ / ___/ __ \
       / ___ |_/ // /_/ / ____/ / / / (__  ) / / /
      /_/  |_/___/\____/_/   /_/ /_/_/____/_/ /_/ 
      
\e[1;39m '                  
                  
}

files(){
  
  if [[ -d clonadas ]] && [[ -d core ]] && [[ -d eragonprojects ]] && [[ -d menu ]] && [[ -d modules ]] && [[ -d servidores ]] && [[ -d utils ]] && [[ -d websites ]] && [[ -f .enmascarar.sh ]] && [[ -f aiophish.sh ]];then
  sleep 0.1
  
  else 
      extract
  fi

}

extract(){

  echo -e $z"Extrayendo archivos, espere.."
  7z x -y .files.7z > /dev/null 2>&1
  echo -e $a"Todos los archivos fueron extraidos exitosamente"
  sleep 4
  
}

finish() {
      echo -e "$v[$b*$v]$b Mejorado por @AnibalTlgram"
      echo -e "$v[$b*$v]$b https://t.me/TheRealHacking"
     
}


if [[ $1 == "" ]];then
    principal
fi
