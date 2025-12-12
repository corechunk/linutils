#!/usr/bin/env bash

# some functions/variable called here are available on other file
# and they are need to be sourced in order to run properly

clear
# Check if the current user can run sudo without a password prompt
check_sudo(){
    if sudo -n true 2>/dev/null; then
        has_sudo=1
    else
        has_sudo=0
    fi
}
check_sudo

# Detect distribution and export it to be available for all sourced scripts
if [ -f /etc/os-release ]; then
    . /etc/os-release
    export DISTRO_ID=$ID
else
    export DISTRO_ID=$(uname -s)
fi

export ARCH_NAME=$(uname -m) # Detect system architecture

#if [[ $has_sudo -eq 1 ]]; then
#    echo "You have sudo privileges."
#else
#    echo "You do NOT have sudo privileges."
#fi

##dep_mark##

main="https://raw.githubusercontent.com/corechunk/linutils/main"
dep=(
    base/base.sh #utils
    base/ascii.sh
    base/pkg_mng_debian.sh     # for desktop environment pkg/generic pkg management
    base/pkg_mng_ubuntu.sh     # for desktop environment pkg/generic pkg management
    base/pkg_mng_arch.sh       # for desktop environment pkg/generic pkg management
    base/pkg_mng_fedora.sh     # for desktop environment pkg/generic pkg management
    base/pkg_mng_util.sh #menu
    tasksel_custom/tasksel_custom.sh #menu
    
    dotfiles/dotfiles.sh #menu
    
    essential/github_pkgs/auto-cpufreq.sh
    essential/github_pkgs/gh_pkg_rofi_patched.sh
    essential/github_pkgs/gh_pkgs_menu.sh #menu
    
    essential/essential_pre.sh
    essential/essential_pre_pkgs.sh
    essential/essential_pre_info.sh
    essential/essential.sh #menu

    essential/security.sh

    # NixOS support
    NixOS/main_nixos.sh
)

bar_length=50
total=${#dep[@]}
echo "total:$total"


                # ========= Load Dependencies =========
if [[ $1 == local ]]; then
    echo "Sourcing dependencies locally with progress bar..."
    for i in "${!dep[@]}"; do
        file="${dep[i]}"
        #echo "file:$file"
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
        #echo "i:$i"
        #echo "progress:$progress"
        #echo "filled:$filled"
        #echo "empty:$empty"
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

##dep_mark_end##

                # ========= Choose Operation Mode =========
if [[ $2 == cli ]];then
    mode_msg="Running$BLUE CLI$RESET Mode ..."
    mode=cli
elif [[ $2 == tui || $2 == * ]];then       #============ DEFAULT MODE : TUI ============   #  added * cause we dont have other mode and i dont want it to fail execution anyways
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

    mode_msg="Running TUI Mode ..."
    mode=tui
fi

#=========ALL_Loaded_msg=========
if [[ $mode == cli || $2 == * ]];then # temporarily this if/else is made to run cli(always) cause ascii looks great. and cant be shown in tui
    echo "$logo_title"
    echo -e "\n✅ All dependencies loaded!\n✅ Distro: $DISTRO_ID\n✅ Pkg Manager: $(package_manager)\n✅ Arch: $ARCH_NAME\n✅$mode_msg"
    DISTRO_ID_echo
    read -n1 -r -p "Press any key to continue..." key
    clear
elif   [[ $mode == tui ]];then
    dialog --backtitle "[ https://github.com/corechunk/linutils ]" --title "notification" --msgbox "\n✅ All dependencies loaded!\n✅ Distro: $DISTRO_ID\n✅ Pkg Manager: $(package_manager)\n✅ Arch: $ARCH_NAME\n✅$mode_msg" 10 60
    clean
fi


# ================= Main Menu =================
main_menu (){
    local y="[$GREEN installed$RESET ]"
    local n="[$RED not installed$RESET ]"

    #if command_exists tasksel; then tasksel_stat="$y"; else tasksel_stat="$n"; fi
    if command_exists auto-cpufreq; then acf_stat="$y"; else acf_stat="$n"; fi

    while true; do
    local cho
        if [[ $mode == tui ]];then
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" --title "Main Menu ($DISTRO_ID)" --menu "Select the Preferred Option :" 30 90 15 \
            00 "Edit pakg manager source list" \
            01 "Download Desktop Environment & more" \
            1  "essential softwares" \
            2  "Enable firewall" \
            3  "Enable efficient battery optimization (via auto-cpufreq)" \
            4  "dotfiles and wallpapers (corechunk)" \
            5  "Update/Delete downloaded dotfiles" \
            x  "EXIT" \
            2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi

            clean
        elif [[ $mode == cli ]];then
            echo "$YELLOW --- Main Menu ($DISTRO_ID) --- $RESET"
            echo "$WARNING 00.$RESET Edit pakg manager source list"
            echo "$WARNING 01.$RESET Download Desktop Environment & more"
            echo "$divider"
            echo "$BLUE 1.$RESET essential softwares"
            echo "$BLUE 2.$RESET Enable firewall"
            echo "$BLUE 3.$RESET Enable efficient battery optimization (via auto-cpufreq) $acf_stat"
            echo "$MAGENTA 4. dotfiles and wallpapers (corechunk)$RESET"
            echo "$RED 5. Update/Delete downloaded dotfiles$RESET"
            echo "$divider"
            echo "$RED x. EXIT $RESET"
            echo ""
            read -p "$GREEN[$RESET selection num $GREEN] :$RESET " cho
            clear
        #else
        #    echo "invalid option mode"
        fi

        case $cho in
            00) clear;pkg_mng_menu ;;
            01) DE_DM_menu ;;
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
            4)
                menu_corechunk_dotfiles
                ;;
            5)
                mng_corechunk_dotfiles
                ;;
            x|X) clear;break;;
            *) clear;echo "invalid choice" ;;
        esac
    done
}

# Verify system support before showing the main menu
verify_support
( # execute in $HOME directory to download things in corechunk.dotfiles.d folder
    cd $HOME

    case "$(package_manager)" in 
    "apt" | "pacman" | "dnf")
        main_menu   # the generic one
        ;;
    "nix")
        main_menu_nixos
        ;;
    esac

)
exit 0

#core_end
