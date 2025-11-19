#!/bin/bash

#
# Script: dotfiles.sh
# Description: Manages the corechunk/dotfiles repository.
#

menu_corechunk_dotfiles() {
    clear
    local dotfiles_dir="corechunk.dotfiles.d"
    if [ -d "$dotfiles_dir" ]; then
        if [ -f "$dotfiles_dir/installer.sh" ]; then
            echo "Found existing dotfiles installation. Running installer..."
            (cd "$dotfiles_dir" && ./installer.sh)
            echo "Installer finished. Press any key to return to the main menu."
            read -n 1 -s -r
        else
            if [[ $mode == tui ]]; then
                dialog --msgbox "Directory '$dotfiles_dir' exists but 'installer.sh' is missing. Please check the directory or remove it to re-download." 8 70
            else
                echo "Directory '$dotfiles_dir' exists but 'installer.sh' is missing."
                echo "Please check the directory or remove it to re-download."
                read -n 1 -s -r -p "Press any key to continue..."
            fi
        fi
    else
        local response
        if [[ $mode == tui ]]; then
            dialog --yesno "The dotfiles repository is not found. Do you want to download it now?" 7 60
            response=$?
        else
            # prompt_user is defined in the main script's dependencies
            prompt_user "The dotfiles repository is not found. Do you want to download it now? [y/N]: "
            response=$?
        fi

        if [ $response -eq 0 ]; then # 0 is 'Yes' for both dialog and prompt_user
            echo "Cloning dotfiles repository..."
            if git clone https://github.com/corechunk/dotfiles.git "$dotfiles_dir"; then
                if [[ $mode == tui ]]; then
                    dialog --msgbox "Repository cloned successfully into '$dotfiles_dir'.\nYou can run option 4 again to start the installer." 8 70
                else
                    echo "Repository cloned successfully into '$dotfiles_dir'."
                    echo "You can run option 4 again to start the installer."
                fi
            else
                if [[ $mode == tui ]]; then
                    dialog --msgbox "Failed to clone the repository." 5 40
                else
                    echo "Failed to clone the repository."
                fi
            fi
        else
            if [[ $mode == tui ]]; then
                dialog --msgbox "Download skipped." 5 30
            else
                echo "Skipping download."
            fi
        fi

        if [[ $mode == cli ]]; then
            echo "Press any key to continue."
            read -n 1 -s -r
        fi
    fi
}
