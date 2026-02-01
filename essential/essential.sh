# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly



dev_sign=" [ unavailable right now ] "
menu_essential(){
    while true;do
        local cho_2=""

        if [[ $mode == cli ]];then
            echo ""
            echo "$divider"
            echo "$BLUE 01.$BLUE [INTEL]$ORANGE Firmware packages$RESET"
            echo "$BLUE 02.$RED [AMD]$ORANGE Firmware packages$RESET"
            echo "$BLUE 03.$GREEN [NVIDIA]$ORANGE Firmware packages$RESET"
            echo "$divider"
            echo "$BLUE 1.$RESET Core CLI$MAGENTA Dev$RESET packages [ e.g. compiler or build tools ]"
            echo "$BLUE 2.$RESET Core$BLUE CLI$RESET packages"
            echo "$BLUE 3.$RESET Core$YELLOW GUI$RESET packages"
            echo "$BLUE 4.$SKY_BLUE Hyprland$RESET Echosystem packages"
            echo "$BLUE 5.$MAGENTA corechunk's hyprland$RESET packages"
            echo "$RED 5_force.$MAGENTA [force] corechunk's hyprland$RESET packages"
            echo "$BLUE 6.$RESET GitHub Essential Packages"
            echo "$BLUE 9.$RESET INFO PAGE [navigation with up/down arrow]"
            echo "$RED x.$RED EXIT$RESET"
            echo "$divider"
            read -p "Select Your Preferred Option : " cho_2
            echo ""
        elif [[ $mode == tui ]];then
            console_size_check
            cho_2=$(dialog --title " ##### ##### Essential Packages ##### ##### " \
            --menu "Select Option : " "$rows" "$cols" "$scroll"\
            01 "[INTEL] Firmware packages" \
            02 "[AMD] Firmware packages" \
            03 "[NVIDIA] Firmware packages" \
            1 "Core CLI Dev packages [e.g. compiler or build tools]" \
            2 "Core CLI packages" \
            3 "Core GUI packages" \
            4 "Hyprland Echosystem packages" \
            5 "corechunk's hyprland packages" \
            5_force "[force] corechunk's hyprland packages" \
            6 "GitHub Essential Packages" \
            9 "INFO PAGE [navigation with up/down arrow]" \
            x "EXIT" \
            2>&1 >/dev/tty)

            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi
        fi


        if [[ $mode == cli ]];then
            case $cho_2 in
            00) prompt_install_type dialog ;;
            01) prompt_install_type "${firmware_intel[@]}" ;;
            02) prompt_install_type "${firmware_amd[@]}" ;;
            03) prompt_install_type "${firmware_nvidia[@]}" ;;
            1)  prompt_install_type "${essentials_dev[@]}" ;;
            2)  prompt_install_type "${essentials_terminal[@]}" ;;
            3)  prompt_install_type "${essentials_desktop[@]}" ;;
            4)  prompt_install_type "${essentials_hyprland[@]}" ;;
            5)  prompt_install_type "${corechunk_hyprland[@]}" ;;
            5_force)
                for pkg in "${corechunk_hyprland[@]}"; do install_pkg_dynamic "$pkg" install-force; done ;;
            6)  clear; menu_github_pkgs ;;
                                                                        #00)install_pkg_dynamic dialog ;;
                                                                        #01)for pkg in "${firmware_intel[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #02)for pkg in "${firmware_amd[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #03)for pkg in "${firmware_nvidia[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #1)for pkg in "${essentials_dev[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #2)for pkg in "${essentials_terminal[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #3)for pkg in "${essentials_desktop[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #4)for pkg in "${essentials_hyprland[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
                                                                        #5)for pkg in "${network_tools_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            9)menu_info ;;
            all_f|ALL_F)
                for grps in essentials_dev essentials_terminal essentials_desktop essentials_hyprland;do
                    for pkg in "${grps[@]}";do install_pkg_dynamic "$pkg" install-force; done
                done ;;
            x|X)clear;break ;;
            *)
                echo "invalid choice !"
                echo "you need to type the text shown before the dots as option" ;;
            esac
        elif [[ $mode == tui ]];then   # [to future me] make the cli portion proccess like this one; im lazy right now
            echo ""
            case $cho_2 in
            01) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "Intel Firmwares" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${firmware_intel_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            02) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "AMD Firmwares" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${firmware_amd_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            03) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "NVIDIA Firmwares" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${firmware_nvidia_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            1)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "essentials_dev" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${essentials_dev_dialog[@]}" 2>&1 >/dev/tty);read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for (( i=0; i<${#raw_pkgs[@]}; i++ ));do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done ;prompt_install_type  "${pkgs[@]}" ;;
            2)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "essentials_terminal" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${essentials_terminal_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            3)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "essentials_desktop" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${essentials_desktop_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            4)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "essentials_hyprland" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${essentials_hyprland_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            5)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "corechunk's_hyprland_pkgs" --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" "${corechunk_hyprland_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            5_force)
                for pkg in "${corechunk_hyprland[@]}"; do install_pkg_dynamic "$pkg" install-force; done ;;
            6) clear; menu_github_pkgs ;;
            9) menu_info ;;
            x) tput reset;clear;break ;;
            esac
        fi
    done
}