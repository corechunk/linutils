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
            echo "$BLUE 4.$RESET$SKY_BLUE Hyprland$RESET Echosystem packages"
            echo "$BLUE 5.$RESET Core Network related packages [ e.g. security(un-enabled),downloaded or network manager  ]"
            echo "$BLUE 6.$RESET github software packages"
            echo "$BLUE 7.$RESET INFO PAGE [navigation with up/down arrow]"
            echo "$RED all.$RESET install$ORANGE all packages$RESET shown here"
            echo "$RED all_f.$RESET install$ORANGE [1-5]$RESET [force]"
            echo "$RED x.$RED EXIT$RESET"
            echo "$divider"
            read -p "Select Your Preferred Option : " cho_2
            echo ""
        elif [[ $mode == tui ]];then
            cho_2=$(dialog --title " ##### ##### Essential Packages ##### ##### " \
            --menu "Select Option : " 30 90 25\
            01 "[INTEL] Firmware packages" \
            02 "[AMD] Firmware packages" \
            03 "[NVIDIA] Firmware packages" \
            1 "Core CLI Dev packages [e.g. compiler or build tools]" \
            2 "Core CLI packages" \
            3 "Core GUI packages" \
            4 "Hyprland Echosystem packages" \
            5 "Core Network related packages[e.g.firewall,network-manager]" \
            6 "github software packages" \
            7 "INFO PAGE [navigation with up/down arrow]" \
            all "install all packages$RESET shown here" \
            all_f "install [1-5] [force]" \
            x "EXIT" \
            2>&1 >/dev/tty)
        fi


        if [[ $mode == cli ]];then
            case $cho_2 in
            00) prompt_install_type dialog ;;
            01) prompt_install_type "${firmware_intel[@]}" ;;
            02) prompt_install_type "${firmware_amd[@]}" ;;
            03) prompt_install_type "${firmware_nvidia[@]}" ;;
            1)  prompt_install_type "${dev_cli[@]}" ;;
            2)  prompt_install_type "${core_cli[@]}" ;;
            3)  prompt_install_type "${core_gui[@]}" ;;
            4)  prompt_install_type "${hypr_utils[@]}" ;;
            5)  prompt_install_type "${network_tools_cli[@]}" ;;
            #00)install_pkg_dynamic dialog ;;
            #01)for pkg in "${firmware_intel[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #02)for pkg in "${firmware_amd[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #03)for pkg in "${firmware_nvidia[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #1)for pkg in "${dev_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #2)for pkg in "${core_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #3)for pkg in "${core_gui[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #4)for pkg in "${hypr_utils[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            #5)for pkg in "${network_tools_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done ;;
            7)menu_info ;;
            all_f|ALL_F)
                for grps in dev_cli core_cli core_gui hypr_utils network_tools_cli;do
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
            01) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "Intel Firmwares" --checklist "Select/toggle preffered options : " 30 90 25 "${firmware_intel_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            02) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "AMD Firmwares" --checklist "Select/toggle preffered options : " 30 90 25 "${firmware_amd_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            03) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "NVIDIA Firmwares" --checklist "Select/toggle preffered options : " 30 90 25 "${firmware_nvidia_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            1) raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "dev_cli" --checklist "Select/toggle preffered options : " 30 90 25 "${dev_cli_dialog[@]}" 2>&1 >/dev/tty);read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for (( i=0; i<${#raw_pkgs[@]}; i++ ));do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done ;prompt_install_type  "${pkgs[@]}" ;;
            2)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "core_cli" --checklist "Select/toggle preffered options : " 30 90 25 "${core_cli_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            3)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "core_gui" --checklist "Select/toggle preffered options : " 30 90 25 "${core_gui_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            4)  raw_pkgs=$(dialog --backtitle "corechunk : lbacktitleinutils --> [ https://github.com/corechunk/linutils.git ]" --title "hypr_utils" --checklist "Select/toggle preffered options : " 30 90 25 "${hypr_utils_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            5)  raw_pkgs=$(dialog --backtitle "corechunk : linutils --> [ https://github.com/corechunk/linutils.git ]" --title "network_tools_cli_dialog" --checklist "Select/toggle preffered options : " 30 90 25 "${network_tools_cli_dialog[@]}" 2>&1 >/dev/tty); read -ra raw_pkgs <<< "$raw_pkgs"; pkgs=(); for ((i=0;i<${#raw_pkgs[@]};i++)); do [[ ${raw_pkgs[$i]} == *#* ]] && continue; pkgs+=("${raw_pkgs[$i]}"); done; prompt_install_type "${pkgs[@]}" ;;
            7) menu_info ;;
            x) tput reset;clear;break ;;
            esac
        fi
    done
}