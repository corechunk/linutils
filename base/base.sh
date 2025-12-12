# Set some colors for output messages 
export OK="$(tput setaf 2)[OK]$(tput sgr0)"
export ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
export NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
export CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
export MAGENTA="$(tput setaf 5)"
export ORANGE="$(tput setaf 214)"
export WARNING="$(tput setaf 1)"
export RED="$(tput setaf 1)"
export YELLOW="$(tput setaf 3)"
export GREEN="$(tput setaf 2)"
export BLUE="$(tput setaf 4)"
export SKY_BLUE="$(tput setaf 6)"
export RESET="$(tput sgr0)"

export INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
export WARN="$(tput setaf 214)[WARN]$(tput sgr0)"

export log_start="$GREEN ----------$BLUE  ----------$RESET"
export log_end="$BLUE ----------$GREEN  ----------$RESET"
export divider="$BLUE ----------$GREEN  ----------$BLUE ----------$GREEN  ----------$RESET"
clean(){
    tput reset;clear
}

command_exists(){
    command -v "$1" >/dev/null 2>&1
    return $?
}
sudo_command_exists(){
    sudo bash -c command -v "$1" >/dev/null 2>&1
    return $?
}
package_manager(){
    if command_exists apt;then
        echo "apt"
    elif command_exists pacman;then
        echo "pacman"
    elif command_exists dnf;then
        echo "dnf"
    elif command_exists nix-env;then
        echo "nix"
    else
        echo "none"
    fi
}

verify_support() {
    # DISTRO_ID is a global variable set in the main script
    
    if [[ "$(package_manager)" == "apt" ]]; then
        local supported_distros=("debian" "ubuntu" "linuxmint")
        local is_supported=false
        for distro in "${supported_distros[@]}"; do
            if [[ "$DISTRO_ID" == "$distro" ]]; then
                is_supported=true
                break
            fi
        done
        if ! $is_supported; then
            echo -e "${ERROR} Your Debian-based distribution ($DISTRO_ID) is not explicitly supported." >&2
            exit 1
        fi
    elif [[ "$(package_manager)" == "pacman" ]]; then
        local supported_distros=("arch" "manjaro" "endeavouros")
        local is_supported=false
        for distro in "${supported_distros[@]}"; do
            if [[ "$DISTRO_ID" == "$distro" ]]; then
                is_supported=true
                break
            fi
        done
        if ! $is_supported; then
            echo -e "${ERROR} Your Arch-based distribution ($DISTRO_ID) is not explicitly supported." >&2
            exit 1
        fi
    elif [[ "$(package_manager)" == "dnf" ]]; then
        local supported_distros=("fedora" "rhel" "centos")
        local is_supported=false
        for distro in "${supported_distros[@]}"; do
            if [[ "$DISTRO_ID" == "$distro" ]]; then
                is_supported=true
                break
            fi
        done
        if ! $is_supported; then
            echo -e "${ERROR} Your DNF-based distribution ($DISTRO_ID) is not explicitly supported." >&2
            exit 1
        fi
    elif [[ "$(package_manager)" == "nix" ]]; then
        local supported_distros=("nixos")
        local is_supported=false
        for distro in "${supported_distros[@]}"; do
            if [[ "$DISTRO_ID" == "$distro" ]]; then
                is_supported=true
                break
            fi
        done
        if ! $is_supported; then
            echo -e "${ERROR} Your Nix-based distribution ($DISTRO_ID) is not explicitly supported." >&2
            exit 1
        fi
    else
        echo -e "${ERROR} No supported package manager (apt, pacman, dnf) found on your system." >&2
        exit 1
    fi

    # If we reach here, everything is supported.
    echo -e "$OK Distribution ($DISTRO_ID) and Package Manager ($(package_manager)) are supported."
}



install_pkg_dynamic(){

check_sudo

echo -e "\n$BLUE[Package] : $GREEN$1$RESET\n"
if [[ $has_sudo -eq 0 ]]; then
echo -e "You do NOT have sudo privileges. So, you are prompted for sudo password.\n$NOTE You'll not be asked for other packages if you use password correctly now"

fi

    if   [[ $2 == default || -z $2 ]];then #1. Install if needed with prompt (no reinstall/default/safe)
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1"
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --needed
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf install "$1"
        fi
    elif [[ $2 == install-force ]];then #2. Install by force without prompt (no reinstall/default/safe)
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" -y
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --needed --noconfirm
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf install "$1" -y
        fi
    elif [[ $2 == re-install ]];then #3. Re-Install with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" --reinstall
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1"
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf reinstall "$1"
        fi
    elif [[ $2 == re-install-force ]];then #4. Re-Install by force without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" -y --reinstall
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --noconfirm
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf reinstall "$1" -y
        fi
    elif [[ $2 == remove ]];then #5. Uninstall with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt remove "$1"
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -R "$1"
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf remove "$1"
        fi
    elif [[ $2 == remove-force ]];then #6 Uninstall without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt remove "$1" -y
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -R "$1" --noconfirm
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf remove "$1" -y
        fi
    elif [[ $2 == purge ]];then #7 Purge with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt purge "$1"
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -Rns "$1"
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf remove "$1" # dnf doesn't have a direct purge equivalent
        fi
    elif [[ $2 == purge-force ]];then #8 Purge without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt purge "$1" -y
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -Rns "$1" --noconfirm
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf remove "$1" -y # dnf doesn't have a direct purge equivalent
        fi
    elif [[ $2 == install-norec ]];then #9 Install without recommends, with prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" --no-install-recommends
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --needed # pacman doesn't install recommends by default
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf install "$1" --setopt=install_weak_deps=False
        fi
    elif [[ $2 == install-force-norec ]];then #10 Install without recommends, without prompt
        if   [[ $(package_manager) == "apt" ]];then
            sudo apt install "$1" -y --no-install-recommends
        elif [[ $(package_manager) == "pacman" ]];then
            sudo pacman -S "$1" --needed --noconfirm # pacman doesn't install recommends by default
        elif [[ $(package_manager) == "dnf" ]];then
            sudo dnf install "$1" -y --setopt=install_weak_deps=False
        fi
    else
        echo "invalid option for installation, ..."
        return 1;
    fi

    return 0;


    # For Arch: tries pacman -S, if not found tries yay -S or paru -S (check existence); if not, fall back to AUR build via git & makepkg.
    # For Debian: tries apt install; if not found tries snap install (if snap is available); else fallback to upstream installer (curl + executable) or git installer.
        # to implement these i have to know what pacman and apt returns when a package is not found
        # otherwise searching for every pkgs in pkg manager is resource intensive when i wanna find if i should try snap/aur for distros
}

halt_msg(){          
    # ========= hault for user to check what has downloaded =========

    echo -e "\n\n"
    #read -n1 -r -p "$YELLOW Press any key if you are finished checking the logs above..." key
    local tmp="$1"
    local tmp2="$2"
    local diff=$(( ${#tmp} - ${#tmp2} ))
    echo -e "$tmp"
    echo -e "\n\n\n"
    # Move the cursor back up to the message line
    tput cuu 5   # moves cursor up 3 lines
    tput cuf ${diff}
    #tput el      # clears the line where cursor is (optional)
    read -n1 -r -p "" key
}

install_pkgs_dynamic(){  #for multi pkg       # used install_pkg_dynamic()  <------------
    local type=$1        # 1st arg as installation type
    shift                # excluding 1st arg from $@ to include rest of elements as pkgs
    local pkgs=("$@")    # included as pkgs

    for pkg in "${pkgs[@]}";do
        install_pkg_dynamic "$pkg" "$type"
    done

        ## ========= hault for user to check what has downloaded =========
        ##echo -e "\n✅ All dependencies loaded!"
        #echo -e "\n\n"
        ##read -n1 -r -p "$YELLOW Press any key if you are finished checking the logs above..." key
        #local tmp="$YELLOW Press any key if you are finished checking the logs above ... $RESET"
        #local tmp2="$YELLOW$RESET"
        #local diff=$(( ${#tmp} - ${#tmp2} ))
        #echo -e "$tmp"

        #echo -e "\n\n\n"

        ## Move the cursor back up to the message line
        #tput cuu 5   # moves cursor up 3 lines
        #tput cuf ${diff}
        ##tput el      # clears the line where cursor is (optional)
        #read -n1 -r -p "" key
    halt_msg "$YELLOW Press any key if you are finished checking the logs above ... $RESET" "$YELLOW $RESET"
    clean
}
prompt_install_type(){       # used install_pkgs_dynamic()  <------------
    local pkgs=("$@")           # can be used to prompt user about installation mathods with a large set of pkgs
    local cho
    while true;do
        if [[ $mode == cli ]];then   # this is not used yet
            echo ""
            echo "1. install with prompt"
            echo "2. install without prompt [force]"
            echo "3. re-install with prompt"
            echo "4. re-install without prompt [force]"
            echo "5. uninstall with prompt"
            echo "6. uninstall without prompt [force]"
            echo "7. purge with prompt"
            echo "8. purge without prompt [force]"
            echo "9 install with prompt (no rec)"
            echo "10 install without prompt [force] (no rec)"
            echo "x. EXIT"
            echo ""
            read -p "Choose preferred option : " cho
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Installation Type Selection" --menu "Choose preferred option : " 30 90 25\
            1 "install with prompt"\
            2 "install without prompt [force]"\
            3 "re-install with prompt"\
            4 "re-install without prompt [force]"\
            5 "uninstall with prompt"\
            6 "uninstall without prompt [force]"\
            7 "purge with prompt"\
            8 "purge without prompt [force]"\
            9 "install with prompt (no rec)"\
            10 "install without prompt [force] (no rec)"\
            x "EXIT"\
            2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
                return 1 # Return 1 to indicate cancellation
            fi
        fi
        clean
    

        case $cho in
        1) install_pkgs_dynamic default "${pkgs[@]}";return 0 ;;
        2) install_pkgs_dynamic install-force "${pkgs[@]}";return 0 ;;
        3) install_pkgs_dynamic re-install "${pkgs[@]}";return 0 ;;
        4) install_pkgs_dynamic re-install-force "${pkgs[@]}";return 0 ;;
        5) install_pkgs_dynamic remove "${pkgs[@]}";return 0 ;;
        6) install_pkgs_dynamic remove-force "${pkgs[@]}";return 0 ;;
        7) install_pkgs_dynamic purge "${pkgs[@]}";return 0 ;;
        8) install_pkgs_dynamic purge-force "${pkgs[@]}";return 0 ;;
        9) install_pkgs_dynamic install-norec "${pkgs[@]}";return 0 ;;
        10) install_pkgs_dynamic install-force-norec "${pkgs[@]}";return 0 ;;
        x|X) clear;tput reset;return 1 ;;
        *) tput reset;clear;echo -e "invalid option ! \n" ;;
        esac
    done
}
prompt_install_type_simple(){       # used install_pkgs_dynamic()  <------------
    local pkgs=("$@")           # can be used to prompt user about installation mathods with a large set of pkgs
    local cho
    while true;do
        if [[ $mode == cli ]];then   # this is not used yet
            echo ""
            echo "1. install with prompt"
            echo "2. re-install with prompt"
            echo "3. uninstall with prompt"
            echo "4. purge with prompt"
            echo "x. EXIT"
            echo ""
            read -p "Choose preferred option : " cho
        elif [[ $mode == tui ]];then
            cho=$(dialog --title "Installation Type Selection" --menu "Choose preferred option : " 30 90 25\
            1 "install with prompt"\
            2 "re-install with prompt"\
            3 "uninstall with prompt"\
            4 "purge with prompt"\
            x "EXIT"\
            2>&1 >/dev/tty)
            
            local exit_status=$?
            if [ $exit_status -ne 0 ]; then
                # Handle ESC or Cancel
                clear
                break
                return 1 # Return 1 to indicate cancellation
            fi
        fi
        clean
    

        case $cho in
        1) install_pkgs_dynamic default "${pkgs[@]}";return 0 ;;
        2) install_pkgs_dynamic re-install "${pkgs[@]}";return 0 ;;
        3) install_pkgs_dynamic remove "${pkgs[@]}";return 0 ;;
        4) install_pkgs_dynamic purge "${pkgs[@]}";return 0 ;;
        x|X) clear;tput reset;return 1 ;;
        *) tput reset;clear;echo -e "invalid option ! \n" ;;
        esac
    done
}

#install_pkg yazi
prompt_user(){
    local cho
    local times=0
    while true;do
        read -p "$1 [y/n]; " cho
        case $cho in
        y|Y)
            return 0
            ;;
        n|N)
            return 1
            ;;
        *)
            ((times++));
            if ((times>2));then return 1; fi
            echo "invalid choice !"
        esac
    done
}
#prompt_user "Do you agree ?"
#if [[ $? == 0 ]];then
#    echo yes
#elif [[ $? == 1 ]];then
#    echo no
#fi

shrink() {
	local src="$1"   # name of source array
	local dest="$2"  # name of destination array

	# make src a nameref (reference to original array)
	declare -n src_ref="$src"
	declare -n dest_ref="$dest"

	dest_ref=()  # clear destination array

	#echo ""
	for ((s=0; s<${#src_ref[@]}; s+=3)); do
		pkg="${src_ref[s]}"
		[[ $pkg == *#* ]] && continue   # skip headers
		dest_ref+=("$pkg")
		#echo "$pkg"
	done
}