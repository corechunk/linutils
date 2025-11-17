DE_cho=()
if [[ $(package_manager) == "apt" ]]; then
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
elif [[ $(package_manager) == "pacman" ]]; then
    DE_cho_dialog=(
        "######_Desktop_Environments_######" "__________ Catagory Description [below] __________" off
        plasma                "KDE Plasma (Standard/Full)" off
        plasma-desktop        "KDE Plasma (Minimal)" off
        gnome                 "GNOME Desktop Environment" off
        cinnamon              "Cinnamon Desktop Environment" off
        xfce4                 "XFCE Desktop Environment" off	
        "######_Window_Manager_######" "__________ Catagory Description [below] __________" off
        hyprland              "a tiling window manager" off
        i3-wm                 "another tiling window manager" off
    )
elif [[ $(package_manager) == "dnf" ]]; then
    DE_cho_dialog=(
        "######_Desktop_Environments_######" "__________ Catagory Description [below] __________" off
        "@kde-desktop"        "KDE Plasma Desktop Environment" off
        "@gnome-desktop"      "GNOME Desktop Environment" off
        "@cinnamon-desktop"   "Cinnamon Desktop Environment" off
        "@xfce-desktop"       "XFCE Desktop Environment" off
        "######_Window_Manager_######" "__________ Catagory Description [below] __________" off
        "hyprland"            "a tiling window manager" off
        "i3"                  "another tiling window manager" off
    )
fi
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
            while true;do
                echo "##########################################################"
                echo "#### Download Desktop Environment with default DM     ####"
                echo "##########################################################"
                echo ""
                local i=1
                local current_de_cho=()
                for item in "${DE_cho[@]}"; do
                    # Skip category headers
                    if [[ "$item" == "######"* ]]; then
                        echo "$item" # Print category headers
                    else
                        echo "$i. $item"
                        current_de_cho+=("$item") # Store actual packages for selection
                        ((i++))
                    fi
                done
                echo "x. Exit"
                echo -e "$log_end\n"
                read -p "Select/type your preferred option : " cho

                if [[ "$cho" =~ ^[xX]$ ]]; then
                    echo "Exiting...";
                    break
                elif [[ "$cho" =~ ^[0-9]+$ ]] && (( cho >= 1 && cho <= ${#current_de_cho[@]} )); then
                    local index=$((cho - 1))
                    local pkg="${current_de_cho[$index]}"
                    prompt_install_type "$pkg"
                else
                    echo "Invalid choice. Please enter a number between 1 and ${#current_de_cho[@]}, or 'x' to exit."
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
        2) tasksel_custom_menu ;; # For now, same as option 1, can be refined later for DE only
        3) echo "Display Manager Only (advanced) - Not yet implemented.";;
        4) echo "sddm + hyprland (custom) - Not yet implemented.";;
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