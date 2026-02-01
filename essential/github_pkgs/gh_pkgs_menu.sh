#!/bin/bash

menu_github_pkgs() {
    while true; do
        local cho_3=""

        if [[ $mode == cli ]]; then
            echo ""
            echo "$divider"
            echo "$BLUE 1.$RESET Rofi Patched (Wayland fork)"
            echo "$BLUE 2.$RESET Auto-CPUFreq (Power optimization)"
            echo "$RED x.$RED EXIT$RESET"
            echo "$divider"
            read -p "Select Your Preferred Option : " cho_3
            echo ""
        elif [[ $mode == tui ]];then
            console_size_check
            cho_3=$(dialog --title " ##### ##### GitHub Essential Packages ##### ##### " \
            --menu "Select Option : " "$rows" "$cols" "$scroll"\
            1 "Rofi Patched (Wayland fork)" \
            2 "Auto-CPUFreq (Power optimization)" \
            x "EXIT" \
            2>&1 >/dev/tty)

            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi
        fi

        case $cho_3 in
            1) clear; install_rofi_patched ;; 
            2) clear; acf ;;
            x|X) clear; break ;; 
            *) echo "invalid choice !" ;; 
        esac
    done
}

