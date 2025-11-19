# This file contains package manager utility functions specific to Fedora-based systems.

fusion_prompt(){
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "$log_start"
            echo "This will install the RPM Fusion 'free' and 'non-free' repositories, which provide a lot of extra software, multimedia codecs, and drivers."
            echo "$log_end"
            read -p "Are you sure ? (confirm or no) :" cho
            clear
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Enable RPM Fusion Repositories" \
                --backtitle "Package manager source list : Operations" \
                --inputbox "This will install the RPM Fusion 'free' and 'non-free' repositories, which provide a lot of extra software, multimedia codecs, and drivers.\n\nType 'confirm' to proceed or 'no' to cancel:" 10 90 \
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
            sudo dnf install "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" -y
            sudo dnf install "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" -y
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

fedora_pkg_mng_menu(){
    clear
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "################################"
            echo "#####$ORANGE DNF Manager Menu$RESET #####"
            echo "################################"
            echo "$BLUE edit.$RESET Edit /etc/dnf/dnf.conf"
            echo "$BLUE fusion.$RESET Enable RPM Fusion (Free & Non-Free)"
            echo "$ORANGE x. EXIT $RESET "
            read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "DNF Manager Menu" --menu "Choose option : " 20 60 15 \
            edit "Edit /etc/dnf/dnf.conf" \
            fusion "Enable RPM Fusion (Free & Non-Free)" \
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
                sudo nano /etc/dnf/dnf.conf
                clear
                ;; 
            fusion)
                fusion_prompt
                if (($?==0));then
                    if [[ $mode == cli ]];then
                        echo "$log_start"
                        echo "RPM Fusion Free and Non-Free repositories have been enabled."
                        echo "$log_end"
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox \
                        "RPM Fusion Free and Non-Free repositories have been enabled."
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
