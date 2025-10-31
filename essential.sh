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
    ninja-build             # fast build system
    cmake                   # cross-platform build tool for c++
    "$openjdk_pkg"          # Java Development Kit #contains: openjdk-25-jre # Java runtime
    python3
    python3-pip
)
core_cli=(
    gawk               # needed for ble.sh [ core dependency ]
    tmux               # terminal multiplexer
    neovim             # cli code editor [standard]
    nano               # cli text editor [standard]
    mpv                # cli media playback [gui will work in Desktop Environments]
    btop               # System Observer [ like: taskmanager ] > even tho idk if management is possible
    fastfetch          # system stats view
    zip                # no description needed
    unzip              # no description needed
    bat                # cat alternative
    lsd                # modern ls alternative
    zoxide             # modern cd alternative
    fzf
    ripgrep            # modern grep alternative
    fonts-firacode     # fonts without glyphs
)

network_tools_cli=(
    wget
    # net-tools  # ill add when i understand each
    # nmap
    # iwd
    ufw
    fail2ban
)
unknown=(
    pipewire
    pipewire-audio-client-libraries
)
core_gui=(
    blueman            # gui bluetooth device manager[blueman-manager]
    network-manager    # may work in cli but no need in cli/server setup
    kitty              # excelent terminal emulator [supports: image, mouse-trail(from v0.37)]
    thunar             # nice & compatible file manager
    mousepad           # text editor [like notepad from windows]
    mpv                # media playback audio/video
    zathura
    obs-studio         # screen recorder/streamer [free]
    shotcut            # video editor [free]
    waybar             # taskbar type thing
    rofi               # menu type displayer
    xdg-desktop-portal # needed for screen share [ All DE ]
    xdg-utils          # cli [for all Desktop Environment]
)
hypr_utils=(
    xdg-desktop-portal-hyprland
    hyprpaper
    hyprcursor
)
github_apps=(   # this section will be constructed later
    oh-my-posh
    auto-cpufreq
)
firmware-intel=(
    firmware-misc-nonfree
    firmware-linux-nonfree
    firmware-sof-signed
    firmware-iwlwifi
)
firmware-amd=(
    firmware-amd-graphics
)
firmware-nvidia=(
    nvidia-driver
)

dev_sign=" [ unavailable right now ] "

menu_essential(){
    while true;do
        local cho
        echo ""
        echo "$divider"
        echo "$BLUE 01.$BLUE [INTEL]$ORANGE Firmware packages$RESET"
        echo "$BLUE 02.$RED [AMD]$ORANGE Firmware packages$RESET"
        echo "$BLUE 03.$GREEN [NVIDIA]$ORANGE Firmware packages$RESET"
        echo "$divider"
        echo "$BLUE 1.$RESET Core CLI$MAGENTA Dev$RESET packages [ e.g. compiler or build tools ]"
        echo "$BLUE 3.$RESET Core$BLUE CLI$RESET packages"
        echo "$BLUE 2.$RESET Core$YELLOW GUI$RESET packages"
        echo "$BLUE 4.$RESET Core Network related packages [ e.g. security(un-enabled),downloaded or network manager  ]"
        echo "$BLUE 5.$RESET github software packages"
        echo "$RED all.$RESET install$ORANGE all packages$RESET shown here"
        echo "$RED all_f.$RESET install$ORANGE all packages$RESET shown here [force]"
        echo "$RED x.$RED EXIT$RESET"
        echo "$divider"
        read -p "Select Your Preferred Option :" cho
        echo ""

        case $cho in
        01)
            for pkg in "${firmware-intel[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        02)
            for pkg in "${firmware-amd[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        03)
            for pkg in "${firmware-nvidia[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        1)
            for pkg in "${dev_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        2)
            for pkg in "${core_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        3)
            for pkg in "${core_gui[@]}";do install_pkg_dynamic "$pkg" install-force; done
        all_f|ALL_F)
            for pkg in "${dev_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            for pkg in "${core_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            for pkg in "${core_gui[@]}";do install_pkg_dynamic "$pkg" install-force; done
            for pkg in "${network_tools_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
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