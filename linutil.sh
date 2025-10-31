#!/bin/bash

# some functions/variable called here are available on other file
# and they are need to be sourced in order to run properly

# dependency ( git, !dialog[in-future]  )

#clear




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

#if [[ $1 == local ]];then
#    echo "Sourcing Dependencies Locally ..."
#    for file in "${dep[@]}";do
#        source ./$file
#    done
#else
#    echo "Sourcing Dependencies remotely (from internet) ..."
#    for depp in "${dep[@]}";do
#        source <(curl -fsSL "$main/$depp")
#    done
#fi

if [[ $1 == local ]]; then
    echo "Sourcing dependencies locally..."
    for file in "${dep[@]}"; do
        if [[ -f ./$file ]]; then
            source "./$file"
        else
            echo "⚠️  Local file $file not found!"
        fi
    done
else
    echo "Sourcing dependencies remotely..."
    for file in "${dep[@]}"; do
        content=$(curl -fsSL "$main/$file")
        if [[ $? -eq 0 && -n "$content" ]]; then
            source <(echo "$content")
        else
            echo "⚠️  Failed to fetch $file from remote."
        fi
    done
fi



main_menu (){
    #clear
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



