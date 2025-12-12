# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

#  mostly same in all distros, but some differ
    thunar_pkg="thunar"
    whiptail_pkg="whiptail"
    

# Detect package manager
if [[ $(package_manager) == "apt" ]]; then
	# Debian/Ubuntu/Sid  [ or debian based ]
    build_essential_pkg="build-essential"
    manpages_pkg="manpages-dev"
    openjdk_pkg="openjdk-21-jdk" # openjdk-25-jdk is not available yet
    ninja_pkg="ninja-build"
    rust_pkg="rustc"
    pipewire_libs_pkg="pipewire-audio-client-libraries"
    firacode_pkg="fonts-firacode"
    python_pkg="python3"
    pip_pkg="python3-pip"
    network_manager_pkg="network-manager"
    edge_pkg="microsoft-edge-stable"
    libspa_bluetooth_pkg="libspa-0.2-bluetooth" # APT specific
    swaync_pkg="sway-notification-center" # APT specific
    
    # Defaults for Ubuntu, Mint, etc.
    spectacle_pkg="spectacle"
    hyprcursor_pkg="hyprcursor"

    case "$DISTRO_ID" in
        "debian")
            spectacle_pkg="kde-spectacle"
            hyprcursor_pkg="hyprcursor-util"
            ;;
        "ubuntu"|"linuxmint")
            # Currently no specific overrides needed
            ;;
        *) # Default for other debian-based distros
            # No specific overrides
            ;;
    esac
elif [[ $(package_manager) == "pacman" ]]; then
	# Arch [ or arch based ]
	build_essential_pkg="base-devel"
	manpages_pkg="man-pages"
	openjdk_pkg="jdk-openjdk"
    ninja_pkg="ninja"
    rust_pkg="rust"
    pipewire_libs_pkg="pipewire-alsa pipewire-jack"
    firacode_pkg="ttf-fira-code"
    python_pkg="python"
    pip_pkg="python-pip"
    network_manager_pkg="networkmanager"
    spectacle_pkg="spectacle"
    edge_pkg="microsoft-edge-stable-bin"
    hyprcursor_pkg="hyprcursor"
    whiptail_pkg="newt"
    libspa_bluetooth_pkg="pipewire-bluez" # PACMAN specific
    swaync_pkg="swaync" # PACMAN specific
elif [[ $(package_manager) == "dnf" ]]; then
    # Fedora [ or fedora based ]
    build_essential_pkg="@development-tools"
    manpages_pkg="man-pages"
    openjdk_pkg="java-21-openjdk-devel"
    ninja_pkg="ninja-build"
    rust_pkg="rust"
    pipewire_libs_pkg="pipewire-libs"
    firacode_pkg="fira-code-fonts"
    python_pkg="python3"
    pip_pkg="python3-pip"
    thunar_pkg="Thunar"
    network_manager_pkg="NetworkManager"
    spectacle_pkg="spectacle"
    edge_pkg="microsoft-edge-stable"
    hyprcursor_pkg="hyprcursor"
    libspa_bluetooth_pkg="pipewire-plugin-bluez" # DNF specific
    swaync_pkg="SwayNotificationCenter" # DNF specific
else
    # This block is reached if package_manager() returns "nix" or "none".
    # If "nix", do nothing as requested.
    # If "none", log a warning but don't exit, as verify_support() handles exits.
    if [[ "$(package_manager)" == "none" ]]; then
        echo -e "${ERROR} No recognized package manager detected. This might indicate an issue or an unsupported configuration. Proceeding with caution.${RESET}"
    fi
fi

## shrink function was here
