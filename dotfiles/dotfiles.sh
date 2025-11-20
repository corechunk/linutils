#!/bin/bash

#
# Script: dotfiles.sh
# Description: Manages the corechunk/dotfiles repository.
#

delete_corechunk_dotfiles() {
    local dotfiles_dir_name="corechunk.dotfiles.d"
    local dotfiles_dir_path="$HOME/$dotfiles_dir_name"
    local warning_msg="This will permanently delete the '$dotfiles_dir_name' directory from your home directory (~/). This is where downloaded content like dotfiles and configurations are stored. You might do this to free up space or to perform a clean re-installation. This action cannot be undone."
    local confirmation_input=""

    if [[ ! -d "$dotfiles_dir_path" ]]; then
        if [[ $mode == tui ]]; then
            dialog --msgbox "The directory '$dotfiles_dir_name' does not exist in your home directory. Nothing to delete." 7 60
        else
            echo "The directory '$dotfiles_dir_name' does not exist in your home directory. Nothing to delete."
        fi
        return
    fi

    if [[ $mode == tui ]]; then
        confirmation_input=$(dialog --title "⚠️ DANGER ⚠️" --inputbox "$warning_msg\n\nTo confirm this action, type 'confirm' below:" 12 70 2>&1 >/dev/tty)
        local exit_status=$?
        if [ $exit_status -ne 0 ]; then # Handle Cancel/ESC
            dialog --msgbox "Deletion cancelled." 5 30
            return
        fi
    else
        echo -e "\n⚠️ DANGER ⚠️\n$warning_msg\n"
        read -p "To confirm this action, type 'confirm' and press Enter: " confirmation_input
    fi

    if [[ "$confirmation_input" == "confirm" ]]; then
        echo "Deleting '$dotfiles_dir_path'..."
        if rm -rf "$dotfiles_dir_path"; then
            if [[ $mode == tui ]]; then
                dialog --msgbox "Directory '$dotfiles_dir_name' has been successfully deleted." 6 60
            else
                echo "Directory '$dotfiles_dir_name' has been successfully deleted."
            fi
        else
            if [[ $mode == tui ]]; then
                dialog --msgbox "An error occurred while trying to delete the directory." 6 60
            else
                echo "An error occurred while trying to delete the directory."
            fi
        fi
    else
        if [[ $mode == tui ]]; then
            dialog --msgbox "Incorrect confirmation. Deletion cancelled." 5 40
        else
            echo "Incorrect confirmation. Deletion cancelled."
        fi
    fi

    if [[ $mode == cli ]]; then
        echo "Press any key to continue."
        read -n 1 -s -r
    fi
}

update_codechunk_dotfiles(){
    local dotfiles_dir="corechunk.dotfiles.d"
    local dotfiles_path="$HOME/$dotfiles_dir" # Define the full path
    local dotfiles_installer_path="$dotfiles_path/installer.sh"

    if [ -d "$dotfiles_path" ];then
        #[[ -f "$dotfiles_path/installer.sh" ]] && echo found
        #read -n 1 -s -r
        if [ -f "$dotfiles_path/installer.sh" ];then
            echo "$(curl -fsSL https://raw.githubusercontent.com/corechunk/dotfiles/main/installer.sh)" > "$dotfiles_installer_path"
            
            if [[ "$?" != "0" ]];then
                local msg="file failed to update"
            else
                local msg="file updated successf to update"
            fi
            
            case $mode in
            tui)
                dialog --clear \
                    --title "update/delete corechunk dotfiles & wallpapers" \
                    --msgbox "the script doesn't exist, we will create one" \
                    10 45
                ;;            
            cli)
            read -n 1 -s -r -p "the script doesn't exist, we will create one"
                ;;
            esac
        else
            case $mode in
            tui)
                dialog --clear \
                    --title "update/delete corechunk dotfiles & wallpapers" \
                    --msgbox "the script doesn't exist, we will create one" \
                    10 45
            ;;
            cli)
                read -n 1 -s -r -p "the script doesn't exist, we will create one"
            ;;
            esac
            touch "$dotfiles_installer_path"
        fi
    else
        case $mode in
        tui)
            whiptail --clear --scrolltext \
                --title "update/delete corechunk dotfiles & wallpapers" \
                --msgbox "You haven't downloaded corechunk dotfiles yet" \
                10 45
        ;;
        cli)
            read -n 1 -s -r -p "You haven't downloaded corechunk dotfiles yet"
        ;;
        esac
    fi

}

mng_corechunk_dotfiles(){ # manages delete/update func calls
    clean
    local menu_cho
    
    while true;do
        case "$mode" in
        "tui")
            menu_cho=$(dialog \
                --backtitle "[ https://github.com/corechunk/linutils ]" \
                --title "corechunk dotfiles & wallpapers collection" \
                --menu "choose preferred option" 25 90 17 \
                --default-item "1" \
                1 "update the dotfiles script only excluding the dotfiles/wallpapers" \
                2 "delete the dotfiles including wallpapers" \
                x "exit" \
                2>&1 >/dev/tty)
                [[ "$?" != "0" ]] && break
            ;;
        "cli")
            echo "##### corechunk dotfiles manager #####"
            echo "$log_start"
            echo "$BLUE 1.$RESET update the dotfiles script only excluding the dotfiles/wallpapers"
            echo "$BLUE 2.$RESET delete the dotfiles including wallpapers"
            echo "$RED x. EXIT $RESET"
            echo "$log_end"
            read -p "choose preferred option : " menu_cho

            ;;
        esac

        clean

        case $menu_cho in 
        1)
            update_codechunk_dotfiles
            clean
        ;;
        2)
            delete_corechunk_dotfiles
            clean
        ;;
        x|X)
            break
        ;;
        *)
            echo "Invalid Choice : please write the segment before '.' as a option to choose !"
        ;;
        esac
    done
}

menu_corechunk_dotfiles(){
    clear
    local dotfiles_dir="corechunk.dotfiles.d"
    local dotfiles_path="$HOME/$dotfiles_dir" # Define the full path

    if [ -d "$dotfiles_path" ]; then
        if [ -f "$dotfiles_path/installer.sh" ]; then
            echo "Found existing dotfiles installation. Running installer..."
            (cd "$dotfiles_path" && ./installer.sh $mode)
            echo "Installer finished. Press any key to return to the main menu."
            read -n 1 -s -r
        else
            if [[ $mode == tui ]]; then
                dialog --msgbox "Directory '$dotfiles_path' exists but 'installer.sh' is missing. Please check the directory or remove it to re-download." 8 70
            else
                echo "Directory '$dotfiles_path' exists but 'installer.sh' is missing."
                echo "Please check the directory or remove it to re-download."
                read -n 1 -s -r -p "Press any key to continue..."
            fi
        fi
    else
        local response
        local download_prompt="The dotfiles repository is not found. This will clone the 'corechunk/dotfiles' repository into '$dotfiles_path'. Do you want to proceed with the download?"

        if [[ $mode == tui ]]; then
            dialog --yesno "$download_prompt" 10 70
            response=$?
        else
            # prompt_user is defined in the main script's dependencies
            echo -e "\n$download_prompt"
            prompt_user "[y/N]: "
            response=$?
        fi

        if [ $response -eq 0 ]; then # 0 is 'Yes' for both dialog and prompt_user
            echo "Cloning dotfiles repository into '$dotfiles_path'..."
            if git clone https://github.com/corechunk/dotfiles.git "$dotfiles_path"; then
                if [[ $mode == tui ]]; then
                    dialog --msgbox "Repository cloned successfully into '$dotfiles_path'.\nYou can run option 4 again to start the installer." 8 70
                else
                    echo "Repository cloned successfully into '$dotfiles_path'."
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
