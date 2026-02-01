# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

pkg_mng_menu(){
    clear

    if   [[ "$(package_manager)" == "apt" ]]; then
        if [[ "$DISTRO_ID" == "debian" ]];then
            debian_pkg_mng_menu;
        elif [[ "$DISTRO_ID" == "ubuntu" ]];then
            ubuntu_pkg_mng_menu;
        fi
    elif [[ "$(package_manager)" == "pacman" ]]; then
        arch_pkg_mng_menu;
    elif [[ "$(package_manager)" == "dnf" ]]; then
        fedora_pkg_mng_menu;
    else
        # cli and tui msg (pkg mngr doesnt exist)
        return 1
    fi
    clear
}