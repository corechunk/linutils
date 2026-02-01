
edit_nix_config() {
    local config_path="$1"
    local config_name=$(basename "$config_path")
    clear
    if [ -z "$config_path" ]; then
        echo -e "${ERROR} No configuration file path provided.${RESET}"
        sleep 2
        return
    fi

    if [ -f "$config_path" ]; then
        echo -e "${NOTE} Opening '$config_name' with 'sudo $EDITOR'...${RESET}"
        sudo $EDITOR "$config_path"
    else
        echo -e "${ERROR} Configuration file not found at '$config_path'.${RESET}"
        sleep 2
    fi
    clear
}

# ================= Main Menu for NixOS =================
main_menu_nixos (){
    while true; do
    local cho
        if [[ $mode == tui ]];then
            console_size_check
            cho=$(dialog --backtitle "[ https://github.com/corechunk/linutils ]" --title "Main Menu (NixOS)" --menu "Select the Preferred Option :" "$rows" "$cols" "$scroll" \
            00 "Edit configuration.nix" \
            01 "Edit home.nix" \
            1  "Try packages temporarily (nix-shell)" \
            2  "Try pkgs by choosing from a large list" \
            3  "Try pkgs by choosing from category list" \
            4  "Dotfiles and wallpapers (corechunk)" \
            5  "Update/Delete downloaded dotfiles" \
            x  "EXIT" \
            2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
            fi
            clean
        elif [[ $mode == cli ]];then
            echo "$YELLOW --- Main Menu (NixOS) --- $RESET"
            echo "$WARNING 00.$RESET Edit configuration.nix"
            echo "$WARNING 01.$RESET Edit home.nix"
            echo "$divider"
            echo "$BLUE 1.$RESET Try packages temporarily (nix-shell)"
            echo "$BLUE 2.$RESET Try pkgs by choosing from a large list"
            echo "$BLUE 3.$RESET Try pkgs by choosing from category list"
            echo "$MAGENTA 4.$RESET Dotfiles and wallpapers (corechunk)"
            echo "$RED 5.$RESET Update/Delete downloaded dotfiles"
            echo "$divider"
            echo "$RED x. EXIT $RESET"
            echo ""
            read -p "$GREEN[$RESET selection num $GREEN] :$RESET " cho
            clear
        fi

        case $cho in
            00)
                edit_nix_config "/etc/nixos/configuration.nix"
                ;; 
            01)
                # Since home.nix location can vary, we'll prompt the user for the path
                clear
                echo -e "${NOTE} Please provide the path to your home.nix file."
                read -p "Path to home.nix (default: /etc/nixos/home.nix): " home_nix_path
                home_nix_path=${home_nix_path:-/etc/nixos/home.nix} # Default if empty
                edit_nix_config "$home_nix_path"
                ;; 
            1)
                clear
                echo -e "${INFO} Enter package names separated by spaces (e.g., 'neofetch htop')."
                read -p "Packages to try: " pkgs
                if [ -n "$pkgs" ]; then
                    echo -e "\n${NOTE} Starting a Nix shell with: $pkgs. Type 'exit' to close it.${RESET}"
                    nix-shell -p $pkgs
                else
                    echo -e "\n${WARNING} No packages were entered.${RESET}"
                fi
                echo -e "\n${OK} Exited Nix shell. Press any key to return to menu...${RESET}"
                read -n1 -r
                clear
                ;; 
            2)
                # Does nothing for now
                ;;
            3)
                # Does nothing for now
                ;;
            4)
                menu_corechunk_dotfiles
                ;; 
            5)
                mng_corechunk_dotfiles
                ;; 
            x|X) clear;break;; 
            *) clear;echo "invalid choice" ;; 
        esac
    done
}
