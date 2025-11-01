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
        elif [[ $mode == tui ]];then
            dialog --title "Package manager source list : Operations" --yesno \
            "Are you sure you want to change your apt source to unstable/sid.\nThese two lines bellow will be added to /etc/apt/sources.list\
            \n\ndeb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware \ndeb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware\
            \n\nAre you sure ? (confirm or no) :" 10 90
            clean
            if [[ $? == 0 ]];then
                cho=confirm
            elif [[ $? == 1 || $? == 255 ]];then    # 255 is when pressed esc
                cho=no
            fi
        fi

        case $cho in
        confirm)
            clear
            echo "deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list
            echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list
            return 0
            ;;
        no|x|X)
            clear
            if [[ $mode == cli ]];then
                echo "$RED Aborting Operation ...$RESET"
            elif [[ $mode == tui ]];then
                dialog --title "notification" --msgbox "Aborting Operation ..." 4 80
            fi
            return 1
            break
            ;;
        *)
            if [[ $mode == cli ]];then
                echo "$RED Invalid Choice. you have to type 'confirm' to accept or 'no' to decline$RESET"
            elif [[ $mode == tui ]];then
                dialog --title "notification" --msgbox " Invalid Choice. you have to type 'confirm' to accept or 'no' to decline" 4 80
            fi
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
                        "$log_start \
                        you apt source is perfectly altered. The pre-configured sid/unstable template has been installed. \
                        $GREEN Now, you just have to$ORANGE update$GREEN &$ORANGE full-upgrade$GREEN your linux$RESET \
                        $log_end" \
                        10 60
                    fi
                elif (($?==1));then
                    if [[ $mode == cli ]];then
                        echo ""
                        echo "$log_start"
                        echo "$ORANGE the task is aborted "
                        echo "$log_end"
                        echo 
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox \
                        "$log_start \
                        $ORANGE the task is aborted \
                        $log_end" \
                        10 40
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