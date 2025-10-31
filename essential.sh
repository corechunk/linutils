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
    xdg-desktop-portal # needed for screen share [ All DE ]
    xdg-utils          # cli [for all Desktop Environment]
    maim               # cli scriptable screenshot [full/region] [all DE and protocol]
    xclip              # cli scriptable clipboard for ss [all DE and protocol]
)
hypr_utils=(
    xdg-desktop-portal-hyprland
    hyprpaper
    hyprcursor
    waybar             # taskbar type thing
    rofi               # menu type displayer
    grim               # cli scriptable screenshot [full]  [wayland based]
    slurp              # [region select for grim] [wayland based]
    wl-copy            # cli scriptable clipboard for ss [wayland based]
)
github_apps=(   # this section will be constructed later
                # cause these need special fetching from repo [custom]
    oh-my-posh
    auto-cpufreq
)
firmware_intel=(
    firmware-misc-nonfree
    firmware-linux-nonfree
    firmware-sof-signed
    firmware-iwlwifi
)
firmware_amd=(
    firmware-amd-graphics
)
firmware_nvidia=(
    nvidia-driver
)

dev_sign=" [ unavailable right now ] "

menu_info(){
    local info_text="
============================================================
                        INFO SECTION
============================================================

[ Development CLI Packages ]
------------------------------------------------------------
  git                 → Version control system for developers.
  build-essential     → Core C/C++ build tools (gcc, g++, make).
  gdb                 → Debugger for C/C++ and other languages.
  manpages-dev        → Developer manual pages.
  make                → GNU build automation tool.
  ninja-build         → Fast, parallel build system.
  cmake               → Cross-platform build system generator.
  openjdk-25-jdk      → Java Development Kit (includes JRE).
  python3             → Python programming language.
  python3-pip         → Python package manager.

[ Core CLI Packages ]
------------------------------------------------------------
  gawk                → Pattern scanning & text processing tool.
  tmux                → Terminal multiplexer for session management.
  neovim              → Modern, extensible CLI code editor.
  nano                → Simple text editor for terminal.
  mpv                 → CLI media player (supports GUI usage too).
  btop                → Modern system monitor (CPU, RAM, IO stats).
  fastfetch           → System info summary tool.
  zip / unzip         → File compression and extraction utilities.
  bat                 → 'cat' alternative with syntax highlighting.
  lsd                 → Modern replacement for 'ls' with icons.
  zoxide              → Smarter, faster 'cd' command.
  fzf                 → Fuzzy finder for terminal.
  ripgrep             → Fast searching tool (grep alternative).
  fonts-firacode      → Developer-friendly monospace font.

[ Network Tools CLI ]
------------------------------------------------------------
  wget                → Command-line file downloader.
  ufw                 → Uncomplicated Firewall configuration tool.
  fail2ban            → Prevent brute-force attacks on SSH and services.

[ Core GUI Packages ]
------------------------------------------------------------
  blueman             → GUI Bluetooth manager.
  network-manager     → Network connection manager.
  kitty               → Feature-rich GPU-accelerated terminal emulator.
  thunar              → Lightweight file manager.
  mousepad            → Simple text editor (GUI).
  mpv                 → Multimedia player (audio/video).
  zathura             → Minimalist document viewer.
  obs-studio          → Video recording and streaming software.
  shotcut             → Non-linear video editor.
  xdg-desktop-portal  → Required for screen sharing across DEs.
  xdg-utils           → Common utilities for XDG-compliant desktops.
  maim                → Screenshot tool (supports region/full).
  xclip               → Clipboard manager for command line.

[ Hyprland Utilities ]
------------------------------------------------------------
  xdg-desktop-portal-hyprland → Portal backend for Hyprland.
  hyprpaper           → Wallpaper manager for Hyprland.
  hyprcursor          → Cursor theme handler for Hyprland.
  waybar              → Customizable status bar.
  rofi                → Application launcher and window switcher.
  grim                → Wayland screenshot utility.
  slurp               → Region selector for Wayland screenshots.
  wl-copy             → Clipboard tool for Wayland.

[ GitHub Apps (Custom Install) ]
------------------------------------------------------------
  oh-my-posh          → Shell prompt theme engine.
  auto-cpufreq        → Automatic CPU frequency scaling optimizer.

[ Firmware Packages ]
------------------------------------------------------------
  [INTEL]
    firmware-misc-nonfree
    firmware-linux-nonfree
    firmware-sof-signed
    firmware-iwlwifi
  [AMD]
    firmware-amd-graphics
  [NVIDIA]
    nvidia-driver

============================================================
 Press 'q' to exit viewer.
============================================================"

    # Use less for scrollable output
    echo "$info_text" | less -R
}


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
        echo "$BLUE 2.$RESET Core$BLUE CLI$RESET packages"
        echo "$BLUE 3.$RESET Core$YELLOW GUI$RESET packages"
        echo "$BLUE 4.$RESET$SKY_BLUE Hyprland$RESET Echosystem packages"
        echo "$BLUE 5.$RESET Core Network related packages [ e.g. security(un-enabled),downloaded or network manager  ]"
        echo "$BLUE 6.$RESET github software packages"
        echo "$BLUE 7.$RESET INFO PAGE [navigation with up/down arrow]"
        echo "$RED all.$RESET install$ORANGE all packages$RESET shown here"
        echo "$RED all_f.$RESET install$ORANGE [1-5]$RESET [force]"
        echo "$RED x.$RED EXIT$RESET"
        echo "$divider"
        read -p "Select Your Preferred Option :" cho
        echo ""

        case $cho in
        00)
            install_pkg_dynamic dialog
            ;;
        01)
            for pkg in "${firmware_intel[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        02)
            for pkg in "${firmware_amd[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        03)
            for pkg in "${firmware_nvidia[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        1)
            for pkg in "${dev_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        2)
            for pkg in "${core_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        3)
            for pkg in "${core_gui[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        4)
            for pkg in "${hypr_utils[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        5)
            for pkg in "${network_tools_cli[@]}";do install_pkg_dynamic "$pkg" install-force; done
            ;;
        7)
            menu_info
            ;;
        all_f|ALL_F)
            for grps in dev_cli core_cli core_gui hypr_utils network_tools_cli;do
                for pkg in "${grps[@]}";do install_pkg_dynamic "$pkg" install-force; done
            done
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