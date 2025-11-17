# This file contains package manager utility functions specific to Ubuntu-based systems.

enable_ubuntu_repos_prompt(){
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "$log_start"
            echo "This will enable the 'universe', 'multiverse', and 'restricted' repositories for Ubuntu, providing access to a wider range of software."
            echo "$log_end"
            read -p "Are you sure ? (confirm or no) :" cho
            clear
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Enable Ubuntu Repositories" \
                --backtitle "Package manager source list : Operations" \
                --inputbox "This will enable the 'universe', 'multiverse', and 'restricted' repositories for Ubuntu, providing access to a wider range of software.\n\nType 'confirm' to proceed or 'no' to cancel:" 10 90 \
                2>&1 >/dev/tty)
            clear
        fi

        case $cho in
        confirm)
            clear
            sudo add-apt-repository universe -y
            sudo add-apt-repository multiverse -y
            sudo add-apt-repository restricted -y
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

ubuntu_pkg_mng_menu(){
    clear
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "################################"
            echo "#####$ORANGE APT Manager Menu (Ubuntu)$RESET #####"
            echo "################################"
            echo "$BLUE edit.$RESET Edit sources list manually "
            echo "$BLUE enable_repos.$RESET Enable Universe, Multiverse, Restricted Repositories"
            echo "$ORANGE x. EXIT $RESET "
            read -p "$GREEN[$RESET select by the option name $GREEN] :$RESET " cho
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "APT Manager Menu (Ubuntu)" --menu "Choose option : " 20 60 15 \
            edit "Edit sources list manually" \
            enable_repos "Enable Universe, Multiverse, Restricted Repositories" \
            x EXIT \
            2>&1 >/dev/tty)
        fi

        case $cho in
            edit)
                if [[ -f "/etc/apt/sources.list" ]];then
                    sudo nano /etc/apt/sources.list
                elif [[ -f "/etc/apt/sources.list.d/ubuntu.sources" ]];then
                    sudo nano /etc/apt/sources.list.d/ubuntu.sources
                fi
                clear
                ;;
            enable_repos)
                enable_ubuntu_repos_prompt
                if (($?==0));then
                    if [[ $mode == cli ]];then
                        echo "$log_start"
                        echo "Universe, Multiverse, and Restricted repositories have been enabled."
                        echo "$GREEN Now, you just have to$ORANGE update$GREEN your system$RESET"
                        echo "$log_end"
                    elif [[ $mode == tui ]];then
                        dialog --title "notification" --msgbox \
                        "Universe, Multiverse, and Restricted repositories have been enabled. \
                        Now, you just have to update your system" \
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