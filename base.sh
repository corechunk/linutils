# Set some colors for output messages 
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"
log_start="$GREEN ----------$BLUE  ----------$RESET"
log_end="$BLUE ----------$GREEN  ----------$RESET"
divider="$BLUE ----------$GREEN  ----------$BLUE ----------$GREEN  ----------$RESET"

command_exists(){
    command -v "$1" >/dev/null 2>&1
    return $?
}
sudo_command_exists(){
    sudo bash -c command -v "$1" >/dev/null 2>&1
    return $?
}
package_manager(){
    if command_exists apt;then
        echo "apt"
    elif command_exists pacman;then
        echo "pacman"
    else 
        echo "none"
    fi
}

install_pkg(){
    if [ $package_manager="apt" ];then
        sudo apt install "$1"
    elif [ $package_manager="pacman" ];then
        sudo pacman -Sy "$1"
    fi
}

install_pkg_dynamic(){
    if   [[ $2 == default || -z $2 ]];then #1. Install if needed with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1"
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --needed
        fi
    elif [[ $2 == install-force ]];then #2. Install by force without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" -y
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --noconfirm
        fi
    elif [[ $2 == re-install ]];then #3. Re-Install with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" --reinstall
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1"
        fi
    elif [[ $2 == re-install-force ]];then #4. Re-Install by force without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" -y --reinstall
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --noconfirm
        fi
    elif [[ $2 == remove ]];then #5. Uninstall with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt remove "$1"
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -R "$1"
        fi
    elif [[ $2 == remove-force ]];then #6 Uninstall without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt remove "$1" -y
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -R "$1" --noconfirm
        fi
    elif [[ $2 == purge-force ]];then #7 Purge without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt purge "$1" -y
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -Rns "$1" --noconfirm
        fi
    else
        echo "invalid option for installation, ..."
        return;
    fi

}
install_pkg_dynamic_choice(){  #for multi pkg
}
prompt_install_type(){
    local pkgs=("$@")
    
    local cho
    if [[ $mode == cli ]];then   # this is not used yet
        echo "nothing"
        read -p "dange for your pc" $cho
    elif [[ $mode == tui ]];then
        cho=$(dialog --title "" --menu "Choose prefered option : " 30 90 25\
        1 "install with prompt"\
        2 "install without prompt [force]"\
        3 "re-install with prompt"\
        4 "install without prompt [force]"\
        5 "uninstall with prompt"\
        6 "uninstall without prompt [force]"\
        7 "purge without prompt [force]"\
        2>&1 >/dev/tty)
    fi

    case $cho in
    1) install_pkgs_dynamic  ;;
    2) install_pkgs_dynamic  ;;
    3) install_pkgs_dynamic  ;;
    4) install_pkgs_dynamic  ;;
    5) install_pkgs_dynamic  ;;
    6) install_pkgs_dynamic  ;;
    7) install_pkgs_dynamic  ;;
    esac
}

#install_pkg yazi
prompt_user(){
    local cho
    local times=0
    while true;do
        read -p "$1 [y/n]; " cho
        case $cho in
        y|Y)
            return 0
            ;;
        n|N)
            return 1
            ;;
        *)
            ((times++));
            if ((times>2));then return 1; fi
            echo "invalid choice !"
        esac
    done
}
#prompt_user "Do you agree ?"
#if [[ $? == 0 ]];then
#    echo yes
#elif [[ $? == 1 ]];then
#    echo no
#fi