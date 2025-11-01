#!/bin/bash

# some functions/variable called here are available on other file
# and they are need to be sourced in order to run properly




clear
main="https://raw.githubusercontent.com/corechunk/linutils/main"
dep=(
    base.sh
    apt-source.sh
    essential_pre.sh
    essential.sh
    auto-cpufreq.sh
    security.sh
)
# these are loaded from the same repo that contained this script itself
# https://github.com/corechunk/linutils
# inside this link you will find all of these scripts that are sourced bellow

bar_length=50
total=${#dep[@]}



                # ========= Load Dependencies =========
if [[ $1 == local ]]; then
    echo "Sourcing dependencies locally with progress bar..."
    for i in "${!dep[@]}"; do
        file="${dep[i]}"
        if [[ -f ./$file ]]; then
            source "./$file"
        else
            echo "⚠️  Local file $file not found!"
        fi

        # progress bar
        progress=$(( (i+1) * 100 / total ))
        filled=$(( (i+1) * bar_length / total ))
        empty=$(( bar_length - filled ))
        bar="$(printf '█%.0s' $(seq 1 $filled))$(printf ' %.0s' $(seq 1 $empty))"
        #printf "\r[%s] %3d%% Loaded: %s" "$bar" "$progress" "$file"
        # build the bar
        bar="$(printf '█%.0s' $(seq 1 $filled))$(printf ' %.0s' $(seq 1 $empty))"
        # construct the line
        line="[$bar] $progress% Loaded: $file"
        # move cursor to start, clear entire line, then print
        printf "\r\033[2K%s" "$line"
        sleep 0.05
    done
elif [[ $1 == remote || $1 == * ]]; then
    echo "Sourcing dependencies remotely with progress bar..." #============ DEFAULT SOURCING MODE : REMOTE ============
    for i in "${!dep[@]}"; do
        file="${dep[i]}"
        tmpfile=$(mktemp)
        if curl -fsSL "$main/$file" -o "$tmpfile"; then
            source "$tmpfile"
        else
            echo "⚠️  Failed to fetch $file"
        fi
        rm -f "$tmpfile"

        # progress bar
        progress=$(( (i+1) * 100 / total ))
        filled=$(( (i+1) * bar_length / total ))
        empty=$(( bar_length - filled ))
        bar="$(printf '█%.0s' $(seq 1 $filled))$(printf ' %.0s' $(seq 1 $empty))"
        #printf "\r[%s] %3d%% Loaded: %s" "$bar" "$progress" "$file"
        # build the bar
        bar="$(printf '█%.0s' $(seq 1 $filled))$(printf ' %.0s' $(seq 1 $empty))"
        # construct the line
        line="[$bar] $progress% Loaded: $file"
        # move cursor to start, clear entire line, then print
        printf "\r\033[2K%s" "$line"
        sleep 0.05
    done
fi
echo "" # echo for moving the cursor from loading bar


                # ========= Choose Operation Mode =========
if [[ $2 == tui ]];then                                        # will become default after all dialog menu's are implemented

    if ! command_exists dialog;then
        echo -e "TUI mode requires package 'dialog'\ncan't continue without 'dialog'"
        if prompt_user "wanna install 'dialog' ? [ y/N ] : ";then
            echo "installing$ORANGE 'dialog'$RESET ..."
            install_pkg_dynamic dialog install-force
        else
            echo "$ORANGE aborting installing dialog and the program ...$RESET"
            exit 1
        fi
    fi

    echo "Running$YELLOW TUI$RESET Mode ..."
    mode=$2
else                                                           #============ DEFAULT MODE : CLI ============
    echo "Running$BLUE CLI$RESET Mode ..."
    mode=cli
fi
                # ========= ALL Loaded msg =========
if   [[ $2 == tui ]];then
    dialog  --title "notification" --msgbox "\n✅ All dependencies loaded!" 6 40
    tput reset
elif [[ $2 == cli || $2 == * ]];then
    echo -e "\n✅ All dependencies loaded!"
    read -n1 -r -p "Press any key to continue..." key
    clear
fi


# ================= Main Menu =================
main_menu (){
    local y="[$GREEN installed$RESET ]"
    local n="[$RED not installed$RESET ]"

    if command_exists tasksel; then tasksel_stat="$y"; else tasksel_stat="$n"; fi
    if command_exists auto-cpufreq; then acf_stat="$y"; else acf_stat="$n"; fi

    while true; do
        if [[ $mode == tui ]];then
            cho_1=$(dialog --backtitle "https://github.com/corechunk/linutils.git" --title "Main Menu" --menu "Select the Preferred Option :" 20 60 15 \
            00 "Edit apt source" \
            01 "Download Desktop Environment (via tasksel) $tasksel_stat" \
            1  "essential softwares (not made yet)" \
            2  "Enable firewall (via ufw & fail2ban)" \
            3  "Enable efficient battery optimization (via auto-cpufreq) $acf_stat" \
            4  "dotfiles and wallpapers (not made yet)" \
            x  "EXIT" \
            2>&1 >/dev/tty)
            #sleep 1;clear;reset
            tput reset
        elif [[ $mode == cli ]];then
            echo "$WARNING 00.$RESET edit apt source"
            echo "$WARNING 01.$RESET Download Desktop Environment (via tasksel) $tasksel_stat"
            echo "$divider"
            echo "$BLUE 1.$RESET essential softwares (not made yet)"
            echo "$BLUE 2.$RESET Enable firewall (via ufw & fail2ban)"
            echo "$BLUE 3.$RESET Enable efficient battery optimization (via auto-cpufreq) $acf_stat"
            echo "$divider"
            echo "$MAGENTA 4. dotfiles and wallpapers$RESET  (not made yet)"
            echo "$RED x. EXIT $RESET"
            echo ""
            read -p "$GREEN[$RESET selection num $GREEN] :$RESET " cho_1
            clear
        #else
        #    echo "invalid option mode"
        fi

        case $cho_1 in
            00) clear;apt_menu ;;
            01) clear;
                if command_exists tasksel; then
                    sudo tasksel
                else
                    install_pkg tasksel
                fi
                ;;
            1) clear;menu_essential ;;
            2) clear;ufw_menu ;;
            3) clear;
                if command_exists auto-cpufreq; then
                    acf
                else
                    git clone https://github.com/AdnanHodzic/auto-cpufreq.git
                    cd auto-cpufreq
                    sudo ./auto-cpufreq-installer
                    cd ..
                    rm -rf auto-cpufreq
                fi
                ;;
            x|X) clear;break;;
            *) clear;echo "invalid choice" ;;
        esac
    done
}

main_menu
exit 0