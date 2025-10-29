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