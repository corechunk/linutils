#!/bin/bash
clear
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

source <(curl -L https://raw.githubusercontent.com/corechunk/linutils/main/var.sh)
echo $msg
echo $data

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
#install_pkg yazi


sid_prompt(){
    clear
    while true;do
        echo ""
        echo "$log_start"
        echo "Are you sure you want to change your apt source to$RED unstable/sid."
        echo "These two lines bellow will be added to$MAGENTA /etc/apt/sources.list$RESET"
        echo ""
        echo "$YELLOW deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
        echo "$YELLOW deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
        echo "$log_end"
        echo ""
        local cho
        read -p "Are you sure ? (confirm or no) :" cho
        case $cho in
        confirm)
            clear
            echo "deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list
            echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list
            return 0
            ;;
        no|x|X)
            clear
            echo "aborting ...."
            return 1
            break
            ;;
        *)
            echo "$RED Invalid Choice. you have to type 'confirm' to accept or 'no' to decline$RESET"
        esac

    done

}
apt_menu(){
    clear
    while true;do
        echo "$BLUE edit.$RESET edit '/etc/apt/sources.list' manually "
        echo "$RED sid.$RESET Pre-configured template [sid/unstable]"
        echo "$ORANGE x. EXIT $RESET "
        read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho_1

        case $cho_1 in 
            edit)
                sudo nano /etc/apt/sources.list
                clear
                ;;
            sid)
                sid_prompt
                if (($?==0));then
                    echo "$log_start"
                    echo "you apt source is perfectly altered. The pre-configured sid/unstable template has been installed."
                    echo "$GREEN Now, you just have to$ORANGE update$GREEN &$ORANGE full-upgrade$GREEN your linux$RESET"
                    echo "$log_end"
                elif (($?==1));then
                    echo ""
                    echo "$log_start"
                    echo "$ORANGE the task is aborted "
                    echo "$log_end"
                    echo 
                fi
                ;;
            x|X)
                break
                ;;
        esac
    done
    clear
}
acf(){
    if command_exists auto-cpufreq;then acf_stat="already enabled"; else acf_stat="$n"; fi
    local cho
    while true;do
        echo "$BLUE 1.$RESET install GUI monitor"
        echo "$BLUE 2.$RESET view status"
        echo "$BLUE 3.$RESET remove auto-cpufreq totally"
        
        echo "$RED x.$RESET EXIT"
        read -p "Select a option :" cho
        case $cho in
        1)
            sudo auto-cpufreq --install
            ;;
        2)
            sudo auto-cpufreq --stats
            ;;
        3)
            git clone https://github.com/AdnanHodzic/auto-cpufreq.git
            cd auto-cpufreq
            sudo ./auto-cpufreq-installer --remove
            cd ..
            rm -rf auto-cpufreq
            ;;
        x|X)
            break
            ;;
        *)
            clear
            echo "#RED Invalid Choice$RESET"
            echo "$log_end"
            ;;
        esac
    done
}
ufw_menu(){
    local y="[$GREEN installed$RESET ]"
    local n="[$RED not installed$RESET ]"


    local cho
    while true;do
        if sudo_command_exists ufw;then ufw_stat="$y"; else ufw_stat="$n"; fi
        if sudo_command_exists fail2ban;then f2b_stat="$y"; else f2b_stat="$n"; fi
        echo "$BLUE 1.$RESET install ufw firewall $ufw_stat"
        echo "$BLUE 2.$RESET enable ufw & set rules"
        echo "$BLUE 3.$RESET install fail2ban $f2b_stat"
        echo "$BLUE 4.$RESET enable fail2ban & set rules"
        echo "$log_end"
        echo "$RED x.$RESET EXIT"
        read -p "Select a option :" cho
        case $cho in
        1)
            install_pkg ufw
            echo "$log_end"
            ;;
        2)
            sudo ufw limit 22/tcp
            sudo ufw allow 80/tcp
            sudo ufw allow 443/tcp
            sudo ufw default deny incoming
            sudo ufw default allow outgoing
            sudo ufw enable
            echo "$log_end"
            ;;
        3)
            install_pkg fail2ban
            echo "$log_end"
            ;;
        4)
            sudo systemctl enable fail2ban
            sudo systemctl start fail2ban
            echo "$log_end"
            ;;
        x|X)
            break
            ;;
        *)
            clear
            echo "#RED Invalid Choice$RESET"
            echo "$log_end"
            ;;
        esac
    done
}
main_menu (){
    #local down_stat="(downloaded)"
    local y="[$GREEN installed$RESET ]"
    local n="[$RED not installed$RESET ]"

    if command_exists tasksel;then tasksel_stat="$y"; else tasksel_stat="$n"; fi
    if command_exists auto-cpufreq;then acf_stat="$y"; else acf_stat="$n"; fi

    #clear
    while true;do
        echo "$WARNING 00.$RESET edit apt source"
        echo "$WARNING 01.$RESET Download Desktop Environment (via tasksel) $tasksel_stat"
        echo "$divider"
        echo "$BLUE 1.$RESET essential softwares (not made yet)"
        echo "$BLUE 2.$RESET Enable firewall (via ufw & fail2ban)"
        echo "$BLUE 3.$RESET Enable efficient battery optimization (via auto-cpufreq) $acf_stat"
        echo "$divider"
        echo "$MAGENTA 4. dotfiles and wallpapers$RESET  (not made yet)"
        echo "$RED x. EXIT $RESET "
        echo ""
        read -p "$GREEN[$RESET selection num $GREEN] :$RESET " cho_1

        case $cho_1 in 
        00)
            apt_menu
            ;;
        01)
            if command_exists tasksel;then
                sudo tasksel
            else
                install_pkg tasksel
            fi
            ;;
        2)
            ufw_menu
            ;;
        3)
            if command_exists auto-cpufreq;then
                acf
            else
                git clone https://github.com/AdnanHodzic/auto-cpufreq.git
                cd auto-cpufreq
                sudo ./auto-cpufreq-installer
                cd ..
                rm -rf auto-cpufreq
            fi
            ;;
        x|X)
            break
            ;;
        *)
            echo "invalid choice"
            ;;
        esac

    done
}
main_menu



