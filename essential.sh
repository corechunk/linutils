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
apps_cli_dev=(
    git
    "$build_essential_pkg"  # essential build tools (gcc, g++, make)
    gdb
    "$manpages_pkg"
    make
    ninja
    cmake
    "$openjdk_pkg"
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

