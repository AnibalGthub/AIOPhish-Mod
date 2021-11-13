#!/bin/bash

# Colores
r="\e[1;91m"
v="\e[1;92m"
a="\e[1;93m"
b="\e[1;39m"
m="\e[1;96m"
z="\e[1;94m"
y='\e[1;33m'

# Condicion de root
if [ $(id -u) -ne 0 ]; then
echo -e "$v Ejecuta este script con permisos root"
exit 1
fi

# Pequeñas variables
folder=`pwd`
user=`logname`
user2=`echo $user |tr '[a-z]' '[A-Z]'`
utils="$folder/utils"
execute="cd $folder && bash aiophish.sh"
	
# Borar archivos para evitar errores
delete(){
sudo rm /usr/share/applications/AIOPhish.desktop > /dev/null 2>&1
rm /usr/local/sbin/aiophish > /dev/null 2>&1

}

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

# Instalacion python3
    if ! [ -x "$(command -v python3)" ]; then
    echo 'Python3 no instalado. Se instalara.' >&2
    apt-get install python3 -y &> /dev/null && echo "Python3 se instalo" || echo "Python3 no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos

else
      echo "Python3 ya esta instalado"
      sleep 1
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
    apt-get install openssl -y &> /dev/null && echo "Openssl se instalo" || echo "Openssl no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos

else
      echo "Openssl ya esta instalado"
      sleep 1
fi

# Instalacion php
    if ! [ -x "$(command -v php)" ]; then
    echo 'Php no instalado. Se instalara.' >&2
    apt-get install git -y &> /dev/null && echo "Php se instalo" || echo "Php no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos

else
      echo "Php ya esta instalado"
      sleep 1
fi

# Instalacion python3-pip
    if ! [ -x "$(command -v pip3)" ]; then
    echo 'Python3-pip no instalado. Se instalara.' >&2
    apt-get install python3-pip -y &> /dev/null && echo "Python3-pip se instalo" || echo "Python3-pip no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && requerimientos

else
      echo "Python3-pip ya esta instalado"
      sleep 1
fi

#Instalacion 7z
    if [ "$(dpkg -l | awk '/p7zip-full/ {print }'|wc -l)" -ge 1 ]; then
    echo "7z ya esta instalado"
    sleep 1

else
      echo "7z no instalado. Se instalara".
      apt-get install p7zip-full -y &> /dev/null && echo "7z se instalo" || echo "7z no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && gnome_terminal
fi

}

requerimientos2(){
    echo ""
    echo -e $z"Instalando requerimientos pip3"
    echo -e "$b "
    sudo -u $user pip3 install bs4 requests Django==2.2.19
echo ""
      echo -e $a"Todos los requerimientos fueron instalados exitosamente"
      sleep 5
      banner
}

# Configurar el acceso rapido
acceso(){

    sudo rm -f /usr/local/sbin/aiophish
    sudo touch /usr/local/sbin/aiophish
    sudo cp $utils/AIOPhish.png /usr/share/icons/
    sudo echo "#!/bin/bash" > /usr/local/sbin/aiophish
    sudo echo "$execute" >> /usr/local/sbin/aiophish
    sudo chmod +x /usr/local/sbin/aiophish

}

# Opcion principal/Instalacion
principal(){    
    banner
    echo -e "$v¿Que deseas $a$user2?\n"
    echo -e "$v[$b 1$v ] Instalacion normal"
    echo -e "$v[$b 2$v ] Instalar y cambiar terminal que usa AIOPhish (Acceso desde las apps)"
    echo -e "$v[$b 3$v ] Añadir / Cambiar terminal flotante para los portforwarding"
    echo -e "$v[$b 4$v ] Quitar terminal flotante"
    echo -e "$v[$b 5$v ] Configurar cuenta de LocalXpose (Viene en opcion 1)"
    echo -e "$v[$b 6$v ] Arreglar problemas con AIOPhish\n"
        
    read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' opc_principal    
    if [[ $opc_principal == "1" || $opc_principal == "01" ]];then
        basica

    elif [[ $opc_principal == "2" || $opc_principal == "02" ]];then
        terminales

    elif [[ $opc_principal == "3" || $opc_principal == "03" ]];then
    	  terminal_flotante
    
    elif [[ $opc_principal == "4" || $opc_principal == "04" ]];then
        quitar_flotantes

    elif [[ $opc_principal == "5" || $opc_principal == "05" ]];then
        x
        
    elif [[ $opc_principal == "6" || $opc_principal == "06" ]];then
        ayuda

    else
        echo -e "$r[!]$b Opción invalida"
        sleep 1
        principal
    fi

}

tunnel(){
cd $folder/servidores && sudo -u $user unzip .servidores.zip > /dev/null 2>&1
rm tunnel_gnome_terminal.sh tunnel_qterminal.sh tunnel_xfce4_terminal.sh > /dev/null 2>&1

}

basica(){

    remove_qterminal_warning
    banner
    net
    requerimientos 
    banner
    requerimientos2
    files
    x
    tunnel
    basica2

}

basica2(){
  
    banner
    echo -e "$v¿Quieres crear un acceso directo a AIOPhish en tu sistema?"
    echo -e "$v¡Podras ejecutar AIOPhish desde cualquier lugar de tu terminal y escritorio!\n"
    echo -e "$v[$b 1$v ] Si, quiero el acceso directo"
    echo -e "$v[$b 2$v ] No"
    echo -e "$v[$b 3$v ] Volver atras\n"

    read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' acceso1    
    if [[ $acceso1 == "1" || $acceso1 == "01" ]];then
    
    delete
    banner
    acceso
    sudo echo "[Desktop Entry]" > /usr/share/applications/AIOPhish.desktop
	  sudo echo "Version=1.0" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Type=Application" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Name=AIOPhish" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Comment=Social Toolkit for Phishing" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Exec=bash aiophish.sh" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Icon=/usr/share/icons/AIOPhish.png" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Path=$folder" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "Terminal=true" >> /usr/share/applications/AIOPhish.desktop
	  sudo echo "StartupNotify=false" >> /usr/share/applications/AIOPhish.desktop
	  sudo chmod +x /usr/share/applications/AIOPhish.desktop        
      short
      finish
    
    elif [[ $acceso1 == "2" || $acceso1 == "02" ]];then
    finish

    elif [[ $acceso1 == "3" || $acceso1 == "03" ]];then
    principal

    else
        echo -e "$r[!]$b Opción invalida"
        sleep 1
        basica2
	fi

}
  
terminales(){  
 
    banner
    echo -e "$v¿Que terminal te gustaria para usar AIOPhish?\n"
    echo -e "$v[$b 1$v ] Gnome-Terminal"
    echo -e "$v[$b 2$v ] Xfce4-terminal"
    echo -e "$v[$b 3$v ] Qterminal"
    echo -e "$v[$b 4$v ] Volver atras\n"
    
    read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' terminal      
   
    if [[ $terminal == "1" || $terminal == "01" ]];then
    gnome_terminal
  
    elif [[ $terminal == "2" || $terminal == "02" ]];then
    xfce4_terminal
    
    elif [[ $terminal == "3" || $terminal == "03" ]];then        
    qterminal
    
    elif [[ $terminal == "4" || $terminal == "04" ]];then        
    principal

    else
        echo -e "$r[!]$b Opción invalida"
        sleep 1
        terminales
  fi

} 

gnome_terminal(){
  
    remove_qterminal_warning
    banner
    net
    banner
    requerimientos
    
    #Instalacion gnome-terminal
    if ! [ -x "$(command -v gnome-terminal)" ]; then
    echo 'Gnome-terminal no instalado. Se instalara.' >&2
    apt-get install gnome-terminal -y &> /dev/null && echo "Gnome-terminal se instalo" || echo "Gnome-terminal no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && gnome_terminal

  else
      echo "Gnome-terminal ya esta instalado"
      sleep 2
  fi

    #Instalacion dbus-x11
    if [ "$(dpkg -l | awk '/dbus-x11/ {print }'|wc -l)" -ge 1 ]; then
    echo "Dbus-x11 ya esta instalado"
    sleep 1

  else
      echo "Dbus-x11 no instalado. Se instalara".
      apt-get install dbus-x11 -y &> /dev/null && echo "Dbus-x11 se instalo" || echo "Dbus-x11 no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && gnome_terminal
  fi

      banner
      requerimientos2
      x
      banner
      files
      delete
      banner
      acceso	

  	  echo "[Desktop Entry]" > /usr/share/applications/AIOPhish.desktop
	    echo "Version=1.0" >> /usr/share/applications/AIOPhish.desktop
	    echo "Type=Application" >> /usr/share/applications/AIOPhish.desktop
	    echo "Name=AIOPhish" >> /usr/share/applications/AIOPhish.desktop
	    echo "Comment=Social Toolkit for Phishing" >> /usr/share/applications/AIOPhish.desktop
	    echo "Exec=gnome-terminal --maximize -t AIOPhish -- bash aiophish.sh" >> /usr/share/applications/AIOPhish.desktop
	    echo "Icon=/usr/share/icons/AIOPhish.png" >> /usr/share/applications/AIOPhish.desktop
	    echo "Path=$folder" >> /usr/share/applications/AIOPhish.desktop
	    echo "Terminal=false" >> /usr/share/applications/AIOPhish.desktop
	    echo "StartupNotify=false" >> /usr/share/applications/AIOPhish.desktop
	    chmod +x /usr/share/applications/AIOPhish.desktop  
      short
      finish

}

xfce4_terminal(){
     
      remove_qterminal_warning
      banner
      net
      banner
      requerimientos

      #Instalacion xfce4-terminal
      if ! [ -x "$(command -v xfce4-terminal)" ]; then
      echo 'Xfce4-terminal no instalado. Se instalara.' >&2
      apt-get install xfce4-terminal -y &> /dev/null && echo "Xfce4-terminal se instalo" || echo "Xfce4-terminal no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && xfce4_terminal

    else
        echo "Xfce4-terminal ya esta instalado"
        sleep 2
  fi

      #Instalacion dbus-x11
      if [ "$(dpkg -l | awk '/dbus-x11/ {print }'|wc -l)" -ge 1 ]; then
      echo "Dbus-x11 ya esta instalado"
      sleep 1

  else
      echo "Dbus-x11 no instalado. Se instalara".
      apt-get install dbus-x11 -y &> /dev/null && echo "Dbus-x11 se instalo" || echo "Dbus-x11 no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && gnome_terminal
  fi
        
      banner
      requerimientos2
      x
      banner
      files
      delete
      banner 
      acceso
	
    	echo "[Desktop Entry]" > /usr/share/applications/AIOPhish.desktop
	    echo "Version=1.0" >> /usr/share/applications/AIOPhish.desktop
	    echo "Type=Application" >> /usr/share/applications/AIOPhish.desktop
	    echo "Name=AIOPhish" >> /usr/share/applications/AIOPhish.desktop
	    echo "Comment=Social Toolkit for Phishing" >> /usr/share/applications/AIOPhish.desktop
    	echo "Exec=xfce4-terminal --maximize -T AIOPhish -x bash aiophish" >> /usr/share/applications/AIOPhish.desktop
	    echo "Icon=/usr/share/icons/AIOPhish.png" >> /usr/share/applications/AIOPhish.desktop
	    echo "Path=$folder" >> /usr/share/applications/AIOPhish.desktop
	    echo "Terminal=false" >> /usr/share/applications/AIOPhish.desktop
	    echo "StartupNotify=false" >> /usr/share/applications/AIOPhish.desktop
	    chmod +x /usr/share/applications/AIOPhish.desktop
      short
      finish

}

qterminal_warning(){
 
    banner
    cd $folder
    if [[ -f aiophish.sh ]]; then
            rm aiophish.sh
        fi

    cd $utils && unzip .aio.zip > /dev/null 2>&1 
    rm aiophish.sh > /dev/null 2>&1 
    mv aiophish_qterminal.sh $folder/aiophish.sh
    echo -e "$r No ejecutar este AIOPhish con qterminal como root, ya que la qterminal se rompe como root"
    echo -e "$r Por seguridad, se pondra una condicion en AIOPhish, para que no se ejecute como root"
    read -p $' \e[1;77m[Pulse enter para continuar] \e[0m' -n 1 -r
}

remove_qterminal_warning(){
 cd $folder
    if [[ -f aiophish.sh ]]; then
            rm aiophish.sh
        fi

    cd $utils  > /dev/null 2>&1 
    unzip .aio.zip > /dev/null 2>&1 
    rm aiophish_qterminal.sh > /dev/null 2>&1 
    mv aiophish.sh $folder/aiophish.sh > /dev/null 2>&1 
}

qterminal(){

    banner
    qterminal_warning
    banner
    net
    sleep 5
    banner
    requerimientos
  
    #Instalacion qterminal
     if [ "$(dpkg -l | awk '/qterminal/ {print }'|wc -l)" -ge 1 ]; then
      echo "Qterminal ya esta instalado"
      sleep 1

  else
        echo "Qterminal no instalado. Se instalara".
        apt-get install qterminal -y &> /dev/null && echo "Qterminal se instalo" || echo "Qterminal no se instalo. Se intentara nuevamente, si no instala Ctrl + C " && sleep 6 && qterminal
  fi

    banner
    requerimientos2
    x
    banner
    files
    delete
    banner
    acceso

	  echo "[Desktop Entry]" > /usr/share/applications/AIOPhish.desktop
	  echo "Version=1.0" >> /usr/share/applications/AIOPhish.desktop
	  echo "Type=Application" >> /usr/share/applications/AIOPhish.desktop
	  echo "Name=AIOPhish" >> /usr/share/applications/AIOPhish.desktop
	  echo "Comment=Social Toolkit for Phishing" >> /usr/share/applications/AIOPhish.desktop
	  echo "Exec=bash aiophish.sh" >> /usr/share/applications/AIOPhish.desktop
	  echo "Icon=/usr/share/icons/AIOPhish.png" >> /usr/share/applications/AIOPhish.desktop
	  echo "Path=$folder" >> /usr/share/applications/AIOPhish.desktop
	  echo "Terminal=true" >> /usr/share/applications/AIOPhish.desktop
	  echo "StartupNotify=false" >> /usr/share/applications/AIOPhish.desktop
	  chmod +x /usr/share/applications/AIOPhish.desktop
    short
    finish

}

terminal_flotante(){
    
    banner
    echo -e "$v¿Que terminal te gustaria para usar en los portforwarding de AIOPhish?\n"
    echo -e "$v[$b 1$v ] Gnome-Terminal"
    echo -e "$v[$b 2$v ] Xfce4-terminal"
    echo -e "$v[$b 3$v ] Qterminal"
    echo -e "$v[$b 4$v ] Volver atras\n"

    read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' flotante
    
    if [[ $flotante == "1" || $flotante == "01" ]];then
    delete_tunnel
    unzip .servidores.zip > /dev/null 2>&1 
    rm tunnel.sh tunnel_qterminal.sh tunnel_xfce4_terminal.sh > /dev/null 2>&1 
    mv tunnel_gnome_terminal.sh tunnel.sh > /dev/null 2>&1 
    chown $user:$user tunnel.sh > /dev/null 2>&1 
    echo ""
    finish

    elif [[ $flotante == "2" || $flotante == "02" ]];then
    delete_tunnel
    unzip .servidores.zip > /dev/null 2>&1 
    rm tunnel.sh tunnel_qterminal.sh tunnel_gnome_terminal.sh > /dev/null 2>&1 
    mv tunnel_xfce4_terminal.sh tunnel.sh > /dev/null 2>&1 
    chown $user:$user tunnel.sh 
    echo ""
    finish

    elif [[ $flotante == "3" || $flotante == "03" ]];then
    qterminal_warning
    delete_tunnel
    unzip .servidores.zip > /dev/null 2>&1 
    rm tunnel.sh tunnel_gnome_terminal.sh tunnel_xfce4_terminal.sh > /dev/null 2>&1 
    mv tunnel_qterminal.sh tunnel.sh > /dev/null 2>&1 
    chown $user:$user tunnel.sh > /dev/null 2>&1 
    echo ""
    finish

    elif [[ $flotante == "4" || $flotante == "04" ]];then
    principal
  
  else
    echo -e "$r[!]$b Opción invalida"
        sleep 1
        terminal_flotante
    fi

}

    delete_tunnel(){
    cd $folder/servidores
    if [[ -f tunnel.sh ]]; then
            rm tunnel.sh
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

finish() {
      echo -e "$v[$b*$v]$b Mejorado por @AnibalTlgram"
      echo -e "$v[$b*$v]$b https://t.me/TheRealHacking"
     
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
verify_token_root
echo ""
verify_token_user
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
verify_token_root
echo ""
verify_token_user
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
chown $user:$user loclx
verify_token_root
echo ""
verify_token_user
else
echo -e "$r Error, intentar de nuevo"
exit 1
      fi

                fi

        fi
}

verify_token_root(){
    
    echo "Verificando si tienes cuenta de LocalXpose para tu usuario root.."
    ./loclx account status > .x2 2> /dev/null 
    sleep 5
    verifi=$(cat .x2 | grep "Not") 
    if [[ $verifi == *'Not'* ]]; then
    echo -e $r"No estas logeado en LocalXpose"
    sleep 3
    menu_token_principal
else
      rm .x2
      echo -e $b"Ya tienes una cuenta de LocalXpose"
      sleep 3
fi

}

verify_token_user(){
    
    echo "Verifificando si tienes cuenta de LocalXpose para tu usuario $user2 .."
    sleep 2
    sudo -u $user ./loclx account status > .x 2> /dev/null 
    read -p $'\e[1;77mUna vez ingresado la contraseña [Pulse enter] \e[0m' -n 1 -r
    verifi=$(cat .x | grep "Not") 
    if [[ $verifi == "Not logged in!!" ]];then 
    echo -e $r"No estas logeado en LocalXpose"
    sleep 3
    menu_token_principal
else
      rm .x
      echo -e $b"Ya tienes una cuenta de LocalXpose"
      sleep 3
fi

}

menu_token_principal(){
  banner
  echo -e "$v¿Desea configurar su cuenta de LocalXpose?"
  echo -e $v"!Es necesario para usar dominos como "google.com.locxl.io"¡\n "
  echo -e "$v[$b 1$v ] Si"
  echo -e "$v[$b 2$v ] No\n"

  read -p $'\e[1;33m[\e[1;39m*\e[1;33m]\e[1;92m Elige una opción\e[1;39m >>> ' xpose      
  
  if [[ $xpose == "1" || $xpose == "01" ]];then
  token_root
  token_user
  
  elif [[ $xpose == "2" || $xpose == "02" ]];then
  basica2

  else
    echo -e "$r[!]$b Opción invalida"
    sleep 1
    menu_token_principal
  fi

}

token_root(){
    
    banner
    echo -e "$r A continunacion ingresa tu token de localxpose"
    echo -e "$r Para cancelar presiona Ctrl + c"
    ./loclx account login
    check_token_root

}

token_user(){
    
    banner
    echo -e "$r A continunacion ingresa tu token de localxpose"
    echo -e "$r Para cancelar presiona Ctrl + c"
    sudo -u user ./loclx account login
    check_token_user
}

check_token_user(){

    sudo -u $user ./loclx account status > .x3 2> /dev/null 
    sleep 3
    verifi2=$(cat .x3 | grep "Not") 
    if [[ $verifi == *'Not'* ]]; then
    echo -e $b"Error"
    echo -e $b"Reintentando"
    sleep 3
    token_user
else
      rm .x3
      echo -e $b"¡Iniciaste exitosamente en tu usuario $user2!"
fi

}

check_token_root(){

    ./loclx account status > .x4 2> /dev/null 
    sleep 3
    verifi3=$(cat .x4 | grep "Not") 
    if [[ $verifi3 == *'Not'* ]]; then
    echo -e $b"Error"
    echo -e $b"Reintentando"
    sleep 3
    token_root
else  
      rm .x4
      echo -e $b"¡Iniciaste exitosamente en tu usuario root!"
fi

}

x(){

    banner
    findlocalxpose

}

files(){
  
  if [[ -d clonadas ]] && [[ -d core ]] && [[ -d eragonprojects ]] && [[ -d menu ]] && [[ -d modules ]] && [[ -d servidores ]] && [[ -d utils ]] && [[ -d websites ]] && [[ -f .enmascarar.sh ]] && [[ -f aiophish.sh ]];then
  sleep 0.1
  
  else 
      extract
  fi

}

short(){

  banner
	echo -e "$v[$b*$v]$b Escribe aiophish para ejecutar en la terminal"
	echo -e "$v[$b*$v]$b O busca el acceso directo en sus aplicaciones" 

}

extract(){

  echo -e $z"Extrayendo archivos, espere.."
  sudo -u $user 7z x -y .files.7z > /dev/null 2>&1
  sleep 4
  echo -e $a"Todos los archivos fueron extraidos exitosamente"

}

quitar_flotantes(){

    cd $folder/servidores
    if [[ -f tunnel.sh ]]; then
            rm tunnel.sh
        fi
    
    unzip .servidores.zip > /dev/null 2>&1 
    rm tunnel_qterminal.sh > /dev/null 2>&1 
    rm tunnel_gnome_terminal.sh > /dev/null 2>&1 
    rm tunnel_xfce4_terminal.sh > /dev/null 2>&1 
    chown $user:$user tunnel.sh 
    banner
    finish
    echo -e "$v[$b*$v]$b Terminales flotantes removidas"

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

if [[ $1 == "" ]];then
    principal
fi

