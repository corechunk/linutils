# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

# Detect package manager
if [[ $(package_manager) == "apt" ]]; then
	# Debian/Ubuntu/Sid  [ or debian based ]
    build_essential_pkg="build-essential"
    manpages_pkg="manpages-dev"
    openjdk_pkg="openjdk-21-jdk" # openjdk-25-jdk is not available yet
    ninja_pkg="ninja-build"
    pipewire_libs_pkg="pipewire-audio-client-libraries"
    firacode_pkg="fonts-firacode"
    python_pkg="python3"
    pip_pkg="python3-pip"
    thunar_pkg="thunar"
    network_manager_pkg="network-manager"
    edge_pkg="microsoft-edge-stable"
    
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
    pipewire_libs_pkg="pipewire-alsa pipewire-jack"
    firacode_pkg="ttf-fira-code"
    python_pkg="python"
    pip_pkg="python-pip"
    thunar_pkg="thunar"
    network_manager_pkg="networkmanager"
    spectacle_pkg="spectacle"
    edge_pkg="microsoft-edge-stable-bin"
    hyprcursor_pkg="hyprcursor"
elif [[ $(package_manager) == "dnf" ]]; then
    # Fedora [ or fedora based ]
    build_essential_pkg="@development-tools"
    manpages_pkg="man-pages"
    openjdk_pkg="java-21-openjdk-devel"
    ninja_pkg="ninja-build"
    pipewire_libs_pkg="pipewire-libs"
    firacode_pkg="fira-code-fonts"
    python_pkg="python3"
    pip_pkg="python3-pip"
    thunar_pkg="Thunar"
    network_manager_pkg="NetworkManager"
    spectacle_pkg="spectacle"
    edge_pkg="microsoft-edge-stable"
    hyprcursor_pkg="hyprcursor"
else
	echo "Unsupported distro"
	exit 1
fi

## shrink function was here
