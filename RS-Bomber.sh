#!/bin/bash

################################################################################
#                                                                              #
#  T3rmuxk1ng Bomber PRO - Shell Launcher                                  #
#                                                                              #
#  Created by: T3RMUXK1NG | T3rmuxk1ng                                          #
#  YouTube: https://youtube.com/@T3rmuxk1ng                                   #
#  GitHub: https://github.com/T3RMUXK1NG                             #
#                                                                              #
#  Based on TBomb by TheSpeedX                                                #
#                                                                              #
################################################################################

# T3RMUXK1NG Colors
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'
NC='\033[0m'

detect_distro() {
    if [[ "$OSTYPE" == linux-android* ]]; then
            distro="termux"
    fi

    if [ -z "$distro" ]; then
        distro=$(ls /etc | awk 'match($0, "(.+?)[-_](?:release|version)", groups) {if(groups[1] != "os") {print groups[1]}}')
    fi

    if [ -z "$distro" ]; then
        if [ -f "/etc/os-release" ]; then
            distro="$(source /etc/os-release && echo $ID)"
        elif [ "$OSTYPE" == "darwin" ]; then
            distro="darwin"
        else
            distro="invalid"
        fi
    fi
}

pause() {
    read -n1 -r -p "Press any key to continue..." key
}

banner() {
    clear
    echo -e "${R}"
    echo -e "  ████████ █████                 ██"
    echo -e "  ▒▒▒██▒▒▒ ██▒▒██                ██"
    echo -e "     ██    ██  ██        ██   ██ ██"
    echo -e "     ██    █████▒  ████  ███ ███ █████"
    echo -e "     ██    ██▒▒██ ██  ██ ██▒█▒██ ██▒▒██"
    echo -e "     ██    ██  ██ ██  ██ ██ ▒ ██ ██  ██"
    echo -e "     ██    █████▒ ▒████▒ ██   ██ █████▒"
    echo -e "     ▒▒    ▒▒▒▒▒   ▒▒▒▒  ▒▒   ▒▒ ▒▒▒▒▒"
    echo -e "${NC}"
    echo -e "${G}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${Y}  🔥 T3rmuxk1ng Bomber PRO - Next Level Edition 🔥${NC}"
    echo -e "${G}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${C}  👤 Created by : T3RMUXK1NG | T3rmuxk1ng${NC}"
    echo -e "${C}  🎬 YouTube    : ${W}https://youtube.com/@T3rmuxk1ng${NC}"
    echo -e "${C}  💻 GitHub     : ${W}https://github.com/T3RMUXK1NG${NC}"
    echo -e "${G}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${R}  ⚡ SUBSCRIBE to T3rmuxk1ng on YouTube for Hacking Tutorials!${NC}"
    echo -e "${G}═══════════════════════════════════════════════════════════════${NC}"
    echo " "
}

init_environ(){
    declare -A backends; backends=(
        ["arch"]="pacman -S --noconfirm"
        ["debian"]="apt-get -y install"
        ["ubuntu"]="apt -y install"
        ["termux"]="apt -y install"
        ["fedora"]="yum -y install"
        ["redhat"]="yum -y install"
        ["SuSE"]="zypper -n install"
        ["sles"]="zypper -n install"
        ["darwin"]="brew install"
        ["alpine"]="apk add"
    )

    INSTALL="${backends[$distro]}"

    if [ "$distro" == "termux" ]; then
        PYTHON="python"
        SUDO=""
    else
        PYTHON="python3"
        SUDO="sudo"
    fi
    PIP="$PYTHON -m pip"
}

install_deps(){

    if [ "$distro" == "termux" ]; then
        packages=(openssl git python figlet)
    else
        packages=(openssl git $PYTHON $PYTHON-pip figlet toilet)
    fi
    if [ -n "$INSTALL" ];then
        for package in ${packages[@]}; do
            $SUDO $INSTALL $package
        done
        $PIP install -r requirements.txt
    else
        echo "We could not install dependencies."
        echo "Please make sure you have git, python3, pip3 and requirements installed."
        echo "Then you can execute bomber.py ."
        exit
    fi
}

banner
pause
detect_distro
init_environ
if [ -f .update ];then
    echo -e "${G}[✔] All Requirements Found....${NC}"
else
    echo -e "${Y}[!] Installing Requirements....${NC}"
    echo "..."
    echo "..."
    install_deps
    echo "T3rmuxk1ng Bomber PRO" > .update
    echo -e "${G}[✔] Requirements Installed....${NC}"
    pause
fi
while :
do
    banner
    echo -e "${R}  Please Read Instructions Carefully !!!${NC}"
    echo " "
    echo -e "  ${G}[ 1 ]${NC} Start SMS  Bomber "
    echo -e "  ${G}[ 2 ]${NC} Start CALL Bomber "
    echo -e "  ${G}[ 3 ]${NC} Start MAIL Bomber "
    echo -e "  ${G}[ 4 ]${NC} Update T3RMUXK1NG Bomber PRO "
    echo -e "  ${G}[ 5 ]${NC} Exit "
    read ch
    clear
    case "$ch" in
        1) $PYTHON bomber.py --sms; exit ;;
        2) $PYTHON bomber.py --call; exit ;;
        3) $PYTHON bomber.py --mail; exit ;;
        4) echo -e "${C}  Downloading Latest T3RMUXK1NG PRO Files...${NC}"; rm -f .update; $PYTHON bomber.py --update; echo -e "${C}  RUN T3RMUXK1NG Bomber PRO Again...${NC}"; pause; exit ;;
        5) banner; echo -e "${Y}  🔥 SUBSCRIBE: youtube.com/@T3rmuxk1ng${NC}"; exit ;;
        *) echo -e "${R}  Invalid Input !!!${NC}"; pause ;;
    esac
done
