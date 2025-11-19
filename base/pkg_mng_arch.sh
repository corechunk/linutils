# This file contains package manager utility functions specific to Arch-based systems.

rank_prompt(){
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "$log_start"
            echo "This will rank your Pacman mirrors using 'reflector' and save the 10 fastest to /etc/pacman.d/mirrorlist."
            echo "$log_end"
            read -p "Are you sure ? (confirm or no) :" cho
            clear
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Pacman Mirror Ranking" \
                --backtitle "Package manager source list : Operations" \
                --inputbox "This will rank your Pacman mirrors using 'reflector' and save the 10 fastest to /etc/pacman.d/mirrorlist.\n\nType 'confirm' to proceed or 'no' to cancel:" 10 90 \
                2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                clear
                if [[ $mode == tui ]]; then dialog --msgbox "Operation cancelled." 5 30; else echo "Operation cancelled."; fi
                return 1
            fi
            clear
        fi

        case $cho in
        confirm)
            clear
            if ! command_exists reflector; then
                install_pkg_dynamic reflector install-force
            fi
            sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
            return 0
            ;; 
        no|x|NO)
            clear
            return 1
            ;; 
        *)
            if [[ $mode == cli ]];then
                echo -e "\n$RED⚠ Invalid choice.$RESET You must type 'confirm' to accept or 'no' to decline.\n"
            elif [[ $mode == tui ]];then
                dialog --title "Invalid Choice" \
                       --msgbox "\n⚠ Invalid choice.\n\nYou must select 'confirm' to accept or 'no' to decline." 7 80
            fi
            ;; 
        esac
    done
}

multilib_prompt(){
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "$log_start"
            echo "This will enable the [multilib] repository in /etc/pacman.conf, required for 32-bit software like Steam or Wine."
            echo "$log_end"
            read -p "Are you sure ? (confirm or no) :" cho
            clear
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Enable Multilib Repository" \
                --backtitle "Package manager source list : Operations" \
                --inputbox "This will enable the [multilib] repository in /etc/pacman.conf, required for 32-bit software like Steam or Wine.\n\nType 'confirm' to proceed or 'no' to cancel:" 10 90 \
                2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                clear
                if [[ $mode == tui ]]; then dialog --msgbox "Operation cancelled." 5 30; else echo "Operation cancelled."; fi
                return 1
            fi
            clear
        fi

        case $cho in
        confirm)
            clear
            sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
            return 0
            ;; 
        no|x|NO)
            clear
            return 1
            ;; 
        *)
            if [[ $mode == cli ]];then
                echo -e "\n$RED⚠ Invalid choice.$RESET You must type 'confirm' to accept or 'no' to decline.\n"
            elif [[ $mode == tui ]];then
                dialog --title "Invalid Choice" \
                       --msgbox "\n⚠ Invalid choice.\n\nYou must select 'confirm' to accept or 'no' to decline." 7 80
            fi
            ;; 
        esac
    done
}

arch_pkg_mng_menu(){
    clear
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "################################"
            echo "#####$ORANGE Pacman Manager Menu$RESET #####"
            echo "################################"
            echo "$BLUE edit.$RESET Edit /etc/pacman.conf"
            echo "$BLUE multilib.$RESET Enable [multilib] repository"
            echo "$GREEN rank.$RESET Rank mirrors with reflector"
            echo "$ORANGE x. EXIT $RESET "
            read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Pacman Manager Menu" --menu "Choose option : " 20 60 15 \
            edit "Edit /etc/pacman.conf" \
            multilib "Enable [multilib] repository" \
            rank "Rank mirrors with reflector" \
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
                sudo nano /etc/pacman.conf
                clear
                ;; 
            multilib)
                multilib_prompt
                if (($?==0));then
                    if [[ $mode == cli ]];then
                        echo "$log_start"
                        echo "Multilib repository has been enabled. You should now run 'sudo pacman -Syu' to synchronize."
                        echo "$GREEN Now, you just have to$ORANGE update$GREEN &$ORANGE full-upgrade$GREEN your linux$RESET"
                        echo "$log_end"
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox \
                        "Multilib repository has been enabled. You should now run 'sudo pacman -Syu' to synchronize. \ 
                        Now, you just have to update full-upgrade your linux" \
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
            rank)
                rank_prompt
                if (($?==0));then
                    if [[ $mode == cli ]];then
                        echo "$log_start"
                        echo "Pacman mirrorlist has been updated with the 10 latest and fastest mirrors."
                        echo "$GREEN Now, you just have to$ORANGE update$GREEN &$ORANGE full-upgrade$GREEN your linux$RESET"
                        echo "$log_end"
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox \
                        "Pacman mirrorlist has been updated with the 10 latest and fastest mirrors. \ 
                        Now, you just have to update full-upgrade your linux" \
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
