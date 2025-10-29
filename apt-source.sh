# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

sid_prompt(){
    clear
    while true;do
        echo ""
        echo "$log_start"
        echo "Are you sure you want to change your apt source to$RED unstable/sid."
        echo "These two lines bellow will be added to$MAGENTA /etc/apt/sources.list$RESET"
        echo ""
        echo "$YELLOW deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
        echo "$YELLOW deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware$RESET"
        echo "$log_end"
        echo ""
        local cho
        read -p "Are you sure ? (confirm or no) :" cho
        case $cho in
        confirm)
            clear
            echo "deb http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list
            echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list
            return 0
            ;;
        no|x|X)
            clear
            echo "aborting ...."
            return 1
            break
            ;;
        *)
            echo "$RED Invalid Choice. you have to type 'confirm' to accept or 'no' to decline$RESET"
        esac

    done

}

apt_menu(){
    clear
    while true;do
        echo "$BLUE edit.$RESET edit '/etc/apt/sources.list' manually "
        echo "$RED sid.$RESET Pre-configured template [sid/unstable]"
        echo "$ORANGE x. EXIT $RESET "
        read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho_1

        case $cho_1 in 
            edit)
                sudo nano /etc/apt/sources.list
                clear
                ;;
            sid)
                sid_prompt
                if (($?==0));then
                    echo "$log_start"
                    echo "you apt source is perfectly altered. The pre-configured sid/unstable template has been installed."
                    echo "$GREEN Now, you just have to$ORANGE update$GREEN &$ORANGE full-upgrade$GREEN your linux$RESET"
                    echo "$log_end"
                elif (($?==1));then
                    echo ""
                    echo "$log_start"
                    echo "$ORANGE the task is aborted "
                    echo "$log_end"
                    echo 
                fi
                ;;
            x|X)
                break
                ;;
        esac
    done
    clear
}