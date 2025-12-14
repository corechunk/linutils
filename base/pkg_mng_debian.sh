# This file contains package manager utility functions specific to Debian-based systems.

sid_prompt(){
    clear
    while true;do
        local cho

        if [[ $mode == cli ]]; then


            # ───────────────────────────────────────────────
            # MODERN APT FORMAT DETECTED
            # /etc/apt/sources.list.d/debian.sources
            # ───────────────────────────────────────────────
            if [[ -f "/etc/apt/sources.list.d/debian.sources" ]]; then
                echo "modern source list detected :$YELLOW /etc/apt/sources.list.d/debian.sources$RESET"
                echo ""
                echo "$log_start"
                echo "Modern unified APT source detected (.sources format)."
                echo "Your current file will be replaced with the Sid version:"
                echo ""
                echo "Types: deb deb-src"
                echo "URIs: http://deb.debian.org/debian/"
                echo "Suites: unstable"
                echo "Components: main contrib non-free non-free-firmware"
                echo "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg"
                echo ""
                echo "$log_end"
                echo ""
            # ───────────────────────────────────────────────
            # OLD APT FORMAT DETECTED
            # /etc/apt/sources.list (legacy)
            # ───────────────────────────────────────────────
            elif [[ -f "/etc/apt/sources.list" ]]; then
                echo "old type source list detected :$YELLOW /etc/apt/sources.list$RESET"
                echo ""
                echo "$log_start"
                echo "Are you sure you want to change your apt source to$RED unstable/sid.$RESET"
                echo "These two lines below will be added to$MAGENTA /etc/apt/sources.list$RESET"
                echo ""
                echo "$YELLOW deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
                echo "$YELLOW deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
                echo "$log_end"
                echo ""
            fi
            read -p "Are you sure ? (confirm or no) :" cho
            clear
        elif [[ $mode == tui ]]; then


            # ───────────────────────────────────────────────
            # TUI DIALOG VERSION (MODERN FORMAT)
            # ───────────────────────────────────────────────
            if [[ -f "/etc/apt/sources.list.d/debian.sources" ]]; then
                cho=$(dialog --title "APT Source Change Confirmation" \
                    --backtitle "Package manager source list : Operations" \
                    --inputbox "Modern APT unified source detected '/etc/apt/sources.list.d/debian.sources'.

Are you sure you want to change your apt source to unstable/sid?

Your debian.sources file will be replaced with the Sid version:

Types: deb deb-src
URIs: http://deb.debian.org/debian/
Suites: unstable
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Type 'confirm' to proceed or 'no' to cancel:" 20 90 \
                    2>&1 >/dev/tty)
                local exit_status=$?
                if [ $exit_status -ne 0 ]; then
                    clear
                    if [[ $mode == tui ]]; then dialog --msgbox "Operation cancelled." 5 30; else echo "Operation cancelled."; fi
                    return 1
                fi
            # ───────────────────────────────────────────────
            # TUI DIALOG VERSION (OLD FORMAT)
            # ───────────────────────────────────────────────
            elif [[ -f "/etc/apt/sources.list" ]]; then
                cho=$(dialog --title "APT Source Change Confirmation" \
                    --backtitle "Package manager source list : Operations" \
                    --inputbox "Old-style sources list detected : '/etc/apt/sources.list'.

Are you sure you want to change your apt source to unstable/sid?

Your 'sources.list' file will be replaced with the Sid version:

deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware

Type 'confirm' to proceed or 'no' to cancel:" 20 90 \
                    2>&1 >/dev/tty)
                local exit_status=$?
                if [ $exit_status -ne 0 ]; then
                    clear
                    if [[ $mode == tui ]]; then dialog --msgbox "Operation cancelled." 5 30; else echo "Operation cancelled."; fi
                    return 1
                fi
            fi

            clean
        fi

        case $cho in
        confirm)
            clear
            # ───────────────────────────────────────────────
            # MODERN FORMAT (.sources)
            # ───────────────────────────────────────────────
            if [[ -f "/etc/apt/sources.list.d/debian.sources" ]]; then
                sudo tee /etc/apt/sources.list.d/debian.sources >/dev/null <<EOF
Types: deb deb-src
URIs: http://deb.debian.org/debian/
Suites: unstable
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
            # ───────────────────────────────────────────────
            # OLD FORMAT (sources.list)
            # ───────────────────────────────────────────────
            elif [[ -f "/etc/apt/sources.list" ]]; then
                echo "deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" \
                    | sudo tee /etc/apt/sources.list >/dev/null
                echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" \
                    | sudo tee -a /etc/apt/sources.list >/dev/null
  
            fi

            # ───────────────────────────────────────────────
            # SUCCESS MESSAGE
            # ───────────────────────────────────────────────
            if [[ $mode == cli ]]; then
                echo -e "\n$GREEN✔ Source list successfully updated to unstable/sid.$RESET\n"
            elif [[ $mode == tui ]]; then
                dialog --title "Success" \
                       --msgbox "\n✔ Source list successfully updated to unstable/sid." 6 80
            fi
            return 0
            ;;
        no|x|NO)
            clear
            if [[ $mode == cli ]]; then
                echo -e "\n$RED✖ Aborting Operation...$RESET\n"
            elif [[ $mode == tui ]]; then
                dialog --title "Notification" --msgbox "\n✖ Aborting Operation..." 10 80
            fi
            return 1
            ;;
        *)
            if [[ $mode == cli ]]; then
                echo -e "\n$RED⚠ Invalid choice.$RESET You must type 'confirm' to accept or 'no' to decline.\n"
            elif [[ $mode == tui ]]; then
                dialog --title "Invalid Choice" \
                       --msgbox "\n⚠ Invalid choice.\n\nYou must select 'confirm' to accept or 'no' to decline." 7 80
            fi
            ;;
        esac


    done

}

debian_pkg_mng_menu(){
    clear
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "################################"
            echo "#####$ORANGE APT Manager Menu$RESET #####"
            echo "################################"
            echo "$BLUE edit.$RESET [Debian] edit sources list manually "
            echo "$RED sid.$RESET [Debian] Switch to unstable/sid"
            echo "$ORANGE x. EXIT $RESET "
            read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho
        elif [[ $mode == tui ]];then
            console_size_check
            cho=$(dialog --title "APT Manager Menu" --menu "Choose option : " "$rows" "$cols" "$scroll" \
            edit "[Debian] edit sources list manually" \
            sid "[Debian] Switch to unstable/sid" \
            x EXIT \
            2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi
        fi

        case $cho in
            edit)
                if [[ -f "/etc/apt/sources.list.d/debian.sources" ]];then
                    echo "modern source list detected :$YELLOW /etc/apt/sources.list.d/debian.sources$RESET"
                    sudo nano /etc/apt/sources.list.d/debian.sources
                elif [[ -f "/etc/apt/sources.list" ]];then
                    echo "old type source list detected :$YELLOW /etc/apt/sources.list$RESET"
                    sudo nano /etc/apt/sources.list
                fi
                clear
                ;; 
            sid)
                sid_prompt
                if (($?==0));then
                    if [[ $mode == cli ]];then
                        echo "$log_start"
                        echo "you apt source is perfectly altered. The pre-configured sid/unstable template has been installed."
                        echo "$GREEN Now, you just have to$ORANGE update$GREEN &$ORANGE full-upgrade$GREEN your linux$RESET"
                        echo "$log_end"
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox \
                        "you apt source is perfectly altered. The pre-configured sid/unstable template has been installed. \n                        Now, you just have to update full-upgrade your linux" \
                        10 60
                    fi
                elif (($?==1));then
                    if [[ $mode == cli ]];then
                        echo ""
                        echo -e "$log_start\n$ORANGE the task is aborted $log_end"
                        echo ""
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox "the task is aborted" 10 40
                    fi
                fi
                ;; 
            x|X) break ;; 
            *) clear; echo "Invalid choice" ;; 
        esac 
    done
    clear
}
