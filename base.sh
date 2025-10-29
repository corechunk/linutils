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
    if   [[ $2 == default || -z $2 ]];then
        if   [[ $package_manager == apt ]];then
            sudo apt install "$1"
        elif [[ $package_manager == pacman ]];then
            sudo pacman -S "$1" --needed
        fi
    elif [[ $2 == install-force ]];then
        if   [[ $package_manager == apt ]];then
            sudo apt install "$1" -y
        elif [[ $package_manager == pacman ]];then
            sudo pacman -S "$1" --noconfirm
        fi
    elif [[ $2 == re-install ]];then
        if   [[ $package_manager == apt ]];then
            sudo apt install "$1" --reinstall
        elif [[ $package_manager == pacman ]];then
            sudo pacman -S "$1"
        fi
    elif [[ $2 == remove ]];then
        if   [[ $package_manager == apt ]];then
            sudo apt remove "$1"
        elif [[ $package_manager == pacman ]];then
            sudo pacman -R "$1"
        fi
    elif [[ $2 == remove-force ]];then
        if   [[ $package_manager == apt ]];then
            sudo apt remove "$1" -y
        elif [[ $package_manager == pacman ]];then
            sudo pacman -R "$1" --noconfirm
        fi
    else
        echo "invalid option for installation, ..."
        return;
    fi

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