# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

# Detect package manager
if [ $package_manager="apt" ]; then
    # Debian/Ubuntu/Sid  [ or debian based ]
    build_essential_pkg="build-essential"
    manpages_pkg="manpages-dev"
    openjdk_pkg="openjdk-25-jdk"
elif [ $package_manager="pacman" ]; then
    # Arch [ or arch based ]
    build_essential_pkg="base-devel"
    manpages_pkg="man-pages"
    openjdk_pkg="jdk-openjdk"
else
    echo "Unsupported distro"
    exit 1
fi

# Now define the array using the variables
dev_cli=(
    git
    "$build_essential_pkg"  # essential build tools (gcc, g++, make)
    gdb                     # debugging tools
    "$manpages_pkg"
    make                    # GNU make utility
    ninja                   # fast build system
    cmake                   # cross-platform build tool for c++
    "$openjdk_pkg"          # Java Development Kit #contains: openjdk-25-jre # Java runtime
    python3
    python3-pip
)

network_tools_cli=(
    wget
    net-tools
    nmap
    iwd
    ufw
    fail2ban
)

core_cli=(
    tmux               # terminal multiplexer
    neovim             # cli code editor [standard]
    nano               # cli text editor [standard]
    mpv                # cli media playback [gui will work in Desktop Environments]
    btop               # System Observer [ like: taskmanager ] > even tho idk if management is possible
    fastfetch
    zip
    unzip
    bat
    lsd
    zoxide
    fzf
    ripgrep
    fonts-firacode
)

core_gui=(
    kitty        # excelent terminal emulator [supports: image, mouse-trail(from v0.37)]
    thunar       # nice & compatible file manager
    mousepad     # text editor [like notepad from windows]
    mpv          # media playback audio/video
    zathura
    obs-studio   # screen recorder/streamer [free]
    shotcut      # video editor [free]
    waybar       # taskbar type thing
    rofi
    xdg-utils    # cli [for all Desktop Environment]
)

github_apps=(
    oh-my-posh
    auto-cpufreq
)

dev_sign=" [ unavailable right now ] "

menu_essential(){
    while true;do
        local cho
        echo ""
        echo "$divider"
        echo "$BLUE 1.$RESET$dev_sign Core CLI$MAGENTA Dev$RESET packages [ e.g. compiler or build tools ]"
        echo "$BLUE 2.$RESET$dev_sign Core$YELLOW GUI$RESET packages"
        echo "$BLUE 3.$RESET$dev_sign Core$BLUE CLI$RESET packages"
        echo "$BLUE 4.$RESET$dev_sign Core Network related packages [ e.g. security(un-enabled),downloaded or network manager  ]"
        echo "$BLUE 5.$RESET$dev_sign github software packages"
        echo "$RED all.$RESET$dev_sign install$ORANGE all packages$RESET shown here"
        echo "$RED all_f.$RESET install$ORANGE all packages$RESET shown here [force]"
        echo "$divider"
        read -p "Select Your Preferred Option" cho

        case $cho in
        all_f|ALL_F)
            for pkg in "${dev_cli[@]}";do install_pkg_dynamic $pkg install-force; done
            for pkg in "${core_cli[@]}";do install_pkg_dynamic $pkg install-force; done
            for pkg in "${core_gui[@]}";do install_pkg_dynamic $pkg install-force; done
            for pkg in "${network_tools_cli[@]}";do install_pkg_dynamic $pkg install-force; done
            ;;
        x|X)
            clear
            break;
            ;;
        *)
            echo "invalid choice !"
            echo "you need to type the text shown before the dots as option"
            ;;
        esac
    done
}