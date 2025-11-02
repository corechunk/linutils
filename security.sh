# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

ufw_menu(){
    if [[ $mode == cli ]];then
        local y="[$GREEN installed$RESET ]"
        local n="[$RED not installed$RESET ]"
    elif [[ $mode == tui ]];then
        local y="[ installed ]"
        local n="[ not installed ]"
    fi


    local cho
    while true;do
        if sudo_command_exists ufw;then ufw_stat="$y"; else ufw_stat="$n"; fi
        if sudo_command_exists fail2ban;then f2b_stat="$y"; else f2b_stat="$n"; fi

        if [[ $mode == cli ]];then
			echo "$BLUE 1.$RESET install ufw firewall $ufw_stat"
			echo "$BLUE 2.$RESET enable ufw & set rules"
			echo "$BLUE 3.$RESET install fail2ban $f2b_stat"
			echo "$BLUE 4.$RESET enable fail2ban & set rules"
			echo "$log_end"
			echo "$RED x.$RESET EXIT"
			read -p "Select a option :" cho
        elif [[ $mode == tui ]];then
			echo hi
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                        --title "Enable firewall (via ufw & fail2ban)" \
                        --menu "Choose Your Preferred Option : " 30 90 25 \
					1 "install ufw firewall $ufw_stat" \
					2 "enable ufw & set rules" \
					3 "install fail2ban $f2b_stat" \
					4 "enable fail2ban & set rules" \
					x "EXIT" 2>&1 >/dev/tty)
		fi

        case $cho in
        1)
            install_pkg ufw
            echo "$log_end"
            ;;
        2)
            sudo ufw limit 22/tcp
            sudo ufw allow 80/tcp
            sudo ufw allow 443/tcp
            sudo ufw default deny incoming
            sudo ufw default allow outgoing
            sudo ufw enable
            echo "$log_end"
            ;;
        3)
            install_pkg fail2ban
            echo "$log_end"
            ;;
        4)
            sudo systemctl enable fail2ban
            sudo systemctl start fail2ban
            echo "$log_end"
            ;;
        x|X)
            break
            ;;
        *)
            clear
            echo "#RED Invalid Choice$RESET"
            echo "$log_end"
            ;;
        esac
    done
}