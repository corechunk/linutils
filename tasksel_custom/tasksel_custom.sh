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
        @cinnamon-desktop   "Cinnamon Desktop Environment" off
        @xfce-desktop       "XFCE Desktop Environment" off	
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
DE_cho=()
shrink DE_cho_dialog DE_cho  # shrink also excluded catagory headers


# Display Manager choices (per-distro)

if [[ $(package_manager) == "apt" ]]; then
    gdm_pkg="gdm3"
elif [[ $(package_manager) == "pacman" ]]; then
    gdm_pkg="gdm"
elif [[ $(package_manager) == "dnf" ]]; then
    gdm_pkg="gdm"
fi
DM_cho_dialog=(
    "######_Display_Managers_######" "__________ Catagory Description [below] __________" off
    sddm        "Simple Desktop Display Manager (sddm)" off
    lightdm     "Lightweight Display Manager (lightdm)" off
    $gdm_pkg         "GNOME Display Manager (gdm)" off
    lxdm        "Lightweight X11 Display Manager (lxdm)" off
)
DM_cho=()

# Populate DM_cho (remove category headers)
if command -v shrink >/dev/null 2>&1; then
    shrink DM_cho_dialog DM_cho
else
    for item in "${DM_cho_dialog[@]}"; do
        if [[ "$item" == "######"* ]]; then
            continue
        fi
        DM_cho+=("$item")
    done
fi


tasksel_custom_menu(){    # for opt1 as a distro neutral tasksel alternative
    local cho
    local pkgs=();
        if [[ $mode == tui ]];then
            console_size_check
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                    --title "Download Desktop Environment with default DM" \
                    --checklist "Select/toggle preffered options : " "$rows" "$cols" "$scroll" \
                    "${DE_cho_dialog[@]}" 2>&1 >/dev/tty)

            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                echo "Cancelled by user. Returning..."
                return 1 # Changed from return 2 to return 1
            fi        
            
            # Filtering cho into pkgs
            read -ra cho <<< "$cho"
            local j
            for ((j=0;j<${#cho[@]};j++));do 
                [[ ${cho[$j]} == *#* ]] && continue
                pkgs+=("${cho[$j]}")
            done
            prompt_install_type_simple "${pkgs[@]}"
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
                    prompt_install_type_simple "$pkg"
                else
                    echo "Invalid choice. Please enter a number between 1 and ${#current_de_cho[@]}, or 'x' to exit."
                fi
            done
        fi
}
adv_DE_menu(){  # for opt 01 as an advanced opt to manage desktop environment only
    local cho
    local pkgs=();
        if [[ $mode == tui ]];then
            console_size_check
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                    --title "Manage Desktop Environment (Advanced)" \
                    --checklist "Select/toggle preffered option : " "$rows" "$cols" "$scroll" \
                    "${DE_cho_dialog[@]}" 2>&1 >/dev/tty)

            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                echo "Cancelled by user. Returning..."
                return 1 # Changed from return 2 to return 1
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
                echo "######    Manage Desktop Environment (Advanced)     ######"
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
adv_DM_menu(){  # for opt 02 as an advanced opt to manage Display Manager only
    local cho
    pkgs=();
        if [[ $mode == tui ]];then
            console_size_check
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                    --title "Manage Display Manager (Advanced)" \
                    --checklist "Select/toggle preffered option : " "$rows" "$cols" "$scroll" \
                    "${DM_cho_dialog[@]}" 2>&1 >/dev/tty)

            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                echo "Cancelled by user. Returning..."
                return 1 # Changed from return 2 to return 1
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
                echo "######      Manage Display Manager (Advanced)       ######"
                echo "##########################################################"
                echo ""
                local i=1
                local current_dm_cho=()
                for item in "${DM_cho[@]}"; do
                    # Skip category headers
                    if [[ "$item" == "######"* ]]; then
                        echo "$item" # Print category headers
                    else
                        echo "$i. $item"
                        current_dm_cho+=("$item") # Store actual packages for selection
                        ((i++))
                    fi
                done
                echo "x. Exit"
                echo -e "$log_end\n"
                read -p "Select/type your preferred option : " cho

                if [[ "$cho" =~ ^[xX]$ ]]; then
                    echo "Exiting...";
                    break
                elif [[ "$cho" =~ ^[0-9]+$ ]] && (( cho >= 1 && cho <= ${#current_dm_cho[@]} )); then
                    local index=$((cho - 1))
                    local pkg="${current_dm_cho[$index]}"
                    prompt_install_type "$pkg"
                else
                    echo "Invalid choice. Please enter a number between 1 and ${#current_dm_cho[@]}, or 'x' to exit."
                fi
            done
        fi
}

DE_DM_menu(){
    local cho
    while true;do
        if [[ $mode == tui ]];then
            console_size_check
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" \
                --title "Download Desktop Environment and Display Manager" \
                --menu "Select the Preferred Option :" "$rows" "$cols" "$scroll" \
                1 "Desktop with it's recommended Display Manager (Default - no hassle)" \
                2 "[coming soon][tempplate] sddm + hyprland (custom - already set)" \
                deb "Tasksel (DE downloader - Debian based distros only !)" \
                "##disclaimer##" "Don't choose options from below if you don't know what you are doing" \
                01 "Desktop Environment Only (advanced)" \
                02 "Display Manager Only (advanced)" \
                x "Exit" 2>&1 >/dev/tty )
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi
        elif [[ $mode == cli ]];then
                echo "##########################################################"
                echo "#### Download Desktop Environment and Display Manager ####"
                echo "##########################################################"
                echo ""
                echo "1. Desktop with it's recommended Display Manager (Default - no hassle)"
                echo "2. [coming soon][tempplate] sddm + hyprland (custom - already set)"
                echo "deb. Tasksel (DE downloader - Debian based distros only !)"
                echo "**disclaimer** Don't choose options from below if you don't know what you are doing" 
                echo "01. Desktop Environment Only (advanced)"
                echo "02. Display Manager Only (advanced)"
                echo "x. Exit"
                echo -e "$log_end\n"
                read -p "Select/type your preferred option : " cho
        fi
        
        case $cho in
        1) tasksel_custom_menu ;;
        2) echo "sddm + hyprland (custom) - Not yet implemented.";;
        deb) 
            if command_exists tasksel; then
                sudo tasksel
            else
                install_pkg_dynamic tasksel
                
                if command_exists tasksel; then
                    sudo tasksel
                else
                    echo "tasksel installation failed. Please install it manually and try again."
                fi
            fi
            ;;
        01) adv_DE_menu ;;
        02) adv_DM_menu ;;
        x|X) clean; break ;;
        *) echo "invalid choice" ;;
        esac
    done

}