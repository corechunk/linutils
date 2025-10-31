#!/bin/bash

# some functions/variable called here are available on other file
# and they are need to be sourced in order to run properly

# dependency ( git, !dialog[in-future]  )

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

echo "loading data from online ..."

# these are loaded from the same repo that contained this script itself
# https://github.com/corechunk/linutils
# inside this link you will find all of these scripts that are sourced bellow

#src(){}

main="https://raw.githubusercontent.com/corechunk/linutils/main"
dep=(
    base.sh
    apt-source.sh
    essential_pre.sh
    essential.sh
    auto-cpufreq.sh
    security.sh
)

for depp in "${dep[@]}";do
    source <(curl -fsSL "$main/$depp")
done

#source <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/base.sh)
#source <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/apt-source.sh)
#source <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/essential_pre.sh)
#source <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/essential.sh)
#source <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/auto-cpufreq.sh)
#source <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/security.sh)

main_menu (){
    clear
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
        1)
            menu_essential
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



