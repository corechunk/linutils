# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

sid_prompt(){
    clear
    while true;do
        local cho
        if [[ $mode == cli ]];then
            echo ""
            echo "$log_start"
            echo "Are you sure you want to change your apt source to$RED unstable/sid."
            echo "These two lines bellow will be added to$MAGENTA /etc/apt/sources.list$RESET"
            echo ""
            echo "$YELLOW deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
            echo "$YELLOW deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
            echo "$log_end"
            echo ""
            read -p "Are you sure ? (confirm or no) :" cho
            clear
        elif [[ $mode == tui ]]; then
            cho=$(dialog --title "APT Source Change Confirmation" \
                --backtitle "Package manager source list : Operations" \
                --inputbox "Are you sure you want to change your apt source to unstable/sid?

These two lines below will be added to /etc/apt/sources.list:

deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware

Type 'confirm' to proceed or 'no' to cancel:" 20 90 \
                2>&1 >/dev/tty)

            clear
        fi

        case $cho in
        confirm)
            clear
            echo "deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list >/dev/null
            echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list >/dev/null
            if [[ $mode == cli ]]; then
                echo -e "\n$GREEN✔ Source list successfully updated to unstable/sid.$RESET\n"
            elif [[ $mode == tui ]]; then
                dialog --title "Success" --msgbox "\n✔ Source list successfully updated to unstable/sid." 6 80
            fi
            return 0
            ;;
        no|x|NO)
            clear
            if [[ $mode == cli ]]; then
                echo -e "\n$RED✖ Aborting Operation...$RESET\n"
            elif [[ $mode == tui ]]; then
                dialog --title "Notification" --msgbox "\n✖ Aborting Operation..." 5 80
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

apt_menu(){
    clear
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "$BLUE edit.$RESET edit '/etc/apt/sources.list' manually "
            echo "$RED sid.$RESET Pre-configured template [sid/unstable]"
            echo "$ORANGE x. EXIT $RESET "
            read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "sid configuration" --menu "Choose option : " 20 60 15 \
            edit "edit '/etc/apt/sources.list' manually" \
            sid "Pre-configured template [sid/unstable]" \
            x EXIT \
            2>&1 >/dev/tty)
        fi


        case $cho in 
            edit)
                sudo nano /etc/apt/sources.list
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
                        "you apt source is perfectly altered. The pre-configured sid/unstable template has been installed. \
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
            x|X)
                break
                ;;
        esac
    done
    clear
}