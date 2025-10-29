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