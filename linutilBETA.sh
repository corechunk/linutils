#!/bin/bash

# linutilBETA.sh — Beta version with loading bar
# Almost identical to linutil.sh functionality, but with progress bar for dependencies
  # its just something ai generated, i understand how it works but didnt read the loading logic but it works, so i added it as BETA
# plus more ++


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
else
    echo "Sourcing dependencies remotely with progress bar..."
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

echo -e "\n✅ All dependencies loaded!"
read -n1 -r -p "Press any key to continue..." key
clear

# ================= Main Menu =================
main_menu (){
    local y="[$GREEN installed$RESET ]"
    local n="[$RED not installed$RESET ]"

    if command_exists tasksel; then tasksel_stat="$y"; else tasksel_stat="$n"; fi
    if command_exists auto-cpufreq; then acf_stat="$y"; else acf_stat="$n"; fi

    while true; do
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

        case $cho_1 in
            00) apt_menu ;;
            01)
                if command_exists tasksel; then
                    sudo tasksel
                else
                    install_pkg tasksel
                fi
                ;;
            1) menu_essential ;;
            2) ufw_menu ;;
            3)
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
            x|X) break ;;
            *) echo "invalid choice" ;;
        esac
    done
}

main_menu
