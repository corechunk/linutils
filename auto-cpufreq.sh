# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

acf(){
    if command_exists auto-cpufreq;then acf_stat="already enabled"; else acf_stat="$n"; fi
    local cho
    while true;do
        echo "$BLUE 1.$RESET install GUI monitor"
        echo "$BLUE 2.$RESET view status"
        echo "$BLUE 3.$RESET remove auto-cpufreq totally"
        
        echo "$RED x.$RESET EXIT"
        read -p "Select a option :" cho
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