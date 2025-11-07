DE_cho=()
DE_cho_dialog=(
	"######_Desktop_Environments_######" "__________ Catagory Description [below] __________" off
    kde-full              "Plasma setups with all utilities that KDE provides" off
    kde-standard          "Plasma setups with standard KDE utilities" off
    kde-plasma-desktop    "Plasma setups with minimal KDE utilities" off
    gnome                 "a android like looking nice desktop environment" off
    cinnamon-desktop-environment "A very light weight Desktop Environment" off
    xfce4                 "Another super light weight Desktop Environment" off	
    "######_Window_Manager_######" "__________ Catagory Description [below] __________" off
    hyprland              "a tiling window manager" off
    i3                    "another tiling window manager" off
)
shrink DE_cho_dialog DE_cho  # shrink also excluded catagory headers

tasksel_custom_menu(){
    local cho
    pkgs=();
        if [[ $mode == tui ]];then
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                    --title "Download Desktop Environment with default DM" \
                    --checklist "Select/toggle preffered options : " 30 90 25 \
                    "${DE_cho_dialog[@]}" 2>&1 >/dev/tty)

            # Handle cancel/esc
            if [[ $? == 1 || $? == 255 ]]; then
                echo "Cancelled by user. Returning..."
                return 2
            fi        
            
            # Filtering cho into pkgs
            read -ra cho <<< "$cho"
            local j
            for ((j=0;j<${#cho[@]};j++));do 
                [[ ${cho[$j]} == *#* ]] && continue
                pkgs+=("${cho[$j]}")
            done
            prompt_install_type "${pkgs[@]}"
        elif [[ $mode == cli ]];then
            while true;do # cli traps until exit but tui doesn't [cause they differ in design]
                echo "##########################################################"
                echo "#### Download Desktop Environment with default DM     ####"
                echo "##########################################################"
                echo ""
                echo "1. Plasma full (by KDE)"
                echo "2. Plasma standard (by KDE)"
                echo "3. Plasma minimal (by KDE)"
                echo "4. Gnome"
                echo "5. Cinnamon"
                echo "6. xfce"
                echo "7. hyprland"
                echo "8. i3 standard"
                echo "x. Exit"
                echo -e "$log_end\n"
                read -p "Select/type your preferred option : " cho

                #case $cho in
                #    1) index=0; prompt_install_type ${DE_cho[$index]} ;;
                #    2) index=1; prompt_install_type ${DE_cho[$index]} ;;
                #    3) index=2; prompt_install_type ${DE_cho[$index]} ;;
                #    4) index=3; prompt_install_type ${DE_cho[$index]} ;;
                #    5) index=4; prompt_install_type ${DE_cho[$index]} ;;
                #    6) index=5; prompt_install_type ${DE_cho[$index]} ;;
                #    x|X) echo "Exiting..."; break ;;
                #    *) echo "Invalid choice" ;;
                #esac
                
                [[ $cho =~ ^[xX]$ ]] && echo "Exiting..." && break

                # Check if numeric and valid
                if [[ "$cho" =~ ^[0-9]+$ ]] && (( cho >= 1 && cho <= ${#DE_cho[@]} )); then
                    index=$((cho - 1))
                    pkg="${DE_cho[$index]}"
                    prompt_install_type "$pkg"
                else
                    echo "Invalid choice. Please enter a number between 1 and ${#DE_cho[@]}, or 'x' to exit."
                fi
            done
            
        fi
}

DE_DM_menu(){
    local cho
    while true;do
        if [[ $mode == tui ]];then
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                --title "Download Desktop Environment and Display Manager" \
                --menu "Select the Preferred Option :" 30 90 25 \
                1 "Desktop with it's recommended Display Manager (Default - no hassle)" \
                2 "Desktop Environment Only (advanced)" \
                3 "Display Manager Only (advanced)" \
                4 "sddm + hyprland (custom - already set)" \
                5 "Tasksel (Debian based distros only !)" \
                x "Exit" 2>&1 >/dev/tty )
        elif [[ $mode == cli ]];then
                echo "##########################################################"
                echo "#### Download Desktop Environment and Display Manager ####"
                echo "##########################################################"
                echo ""
                echo "1. Desktop with it's recommended Display Manager (Default - no hassle)"
                echo "2. Desktop Environment Only (advanced)"
                echo "3. Display Manager Only (advanced)"
                echo "4. sddm + hyprland (custom - already set)"
                echo "5. Tasksel (Debian based distros only !)"
                echo "x. Exit"
                echo -e "$log_end\n"
                read -p "Select/type your preferred option : " cho
        fi

        case $cho in
        1) tasksel_custom_menu ;;
        5) 
            if command_exists tasksel; then
                sudo tasksel
            else
                install_pkg_dynamic tasksel
            fi
            ;;
        x|X) clean; break ;;
        esac
    done

}