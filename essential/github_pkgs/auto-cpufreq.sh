# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

acf(){
    if command_exists auto-cpufreq;then acf_stat="already enabled"; else acf_stat="$n"; fi
    local cho
    while true;do
        if [[ $mode == cli ]];then
            echo "$BLUE 1.$RESET install GUI monitor"
            echo "$BLUE 2.$RESET view status"
            echo "$BLUE 3.$RESET remove auto-cpufreq totally"
            
            echo "$RED x.$RESET EXIT"
            read -p "Select a option :" cho
            clear
        elif [[ $mode == tui ]];then

            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                        --title "Enable efficient battery optimization (via auto-cpufreq)" \
                        --menu "Choose Your Preferred Option : " 30 90 25 \
                1 "install GUI monitor" \
                2 "view status" \
                3 "remove auto-cpufreq totally" \
                x "EXIT" 2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi

            clean
        fi


        case $cho in
        1)
            sudo auto-cpufreq --install
            ;;
        2)
            sudo auto-cpufreq --stats
            ;;
        3)
            git clone https://github.com/AdnanHodzic/auto-cpufreq.git
            cd auto-cpufreq
            sudo ./auto-cpufreq-installer --remove
            cd ..
            rm -rf auto-cpufreq
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