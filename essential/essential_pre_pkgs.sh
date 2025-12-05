# pkgs array starting with essentials are collective catagories
# pkgs array starting with ess are simpler single catagories


# These are one of those collective catagories
#essentials_dev_dialog=()
#essentials_terminal_dialog=()
#essentials_desktop_dialog=()
#essentials_hyprland_dialog=()
#corechunk_hyprland_dialog=()
#essentials_extra_dialog=()


# These are shrinked for non-tui usage
#essentials_dev=()
#essentials_terminal=()
#essentials_desktop=()
#essentials_hyprland=()
#corechunk_hyprland=()
#essentials_extra=()


ess_tui_pkgs=()  # all essentials_*_dialog merged for tui usage
ess_tui_pkgs_dialog=(
    "###_TUI_Tools_###"   "_____ Category Description [below] _____" off
    dialog                "Dialog (classic CLI dialog tool)" off
    "$whiptail_pkg"       "Whiptail (lightweight dialog alternative)" off
    gum                   "Gum (modern CLI UI toolkit)" off
)



essentials_dev_dialog=(
	"######_essentials_dev_pkgs_######" "__________ Collective Category __________" off

    "###_Development_Tools_###"     "_____ Category Description [below] _____" off
	git                                   "Version control system" on
    gh                                    "GitHub CLI tool" off
    docker                               "Containerization platform" off
    docker-compose                      "Container orchestration tool" off
	"$build_essential_pkg"                "Essential build tools (gcc, g++, make)" on
	gdb                                   "Debugging tools for C/C++" on
	"$manpages_pkg"                       "Developer manual pages" on

    "###_Build_Systems_###"         "_____ Category Description [below] _____" off
	make                                  "GNU build utility" on
	"$ninja_pkg"                           "Fast alternative build system" on
	cmake                                 "Cross-platform C++ build tool" on
    cargo                                 "Rust package manager and build tool" off
    npm                                   "Node.js package manager" off
    yarn                                  "Alternative Node.js package manager" off
    gradle                                "Build automation tool (Java, Android, etc.)" off
    maven                                 "Java project management and comprehension tool" off
    ant                                   "Java build tool" off
    autotools                             "GNU build system (autoconf, automake, libtool)" off

    "###_Compiler_or_Interpreter_###" "_____ Category Description [below] _____" off
    gcc                                   "C, C++, Objective-C, Objective-C++, Fortran, Ada, D (GDC), Go (GCCGO) [compiler]" on
    clang                                 "C, C++, and Objective-C compiler" off
    javac                                 "Java programming language compiler" off
	"$openjdk_pkg"                        "Java Development Kit (includes JRE)" on
    dotnet-sdk                            "Microsoft .NET SDK" off
    kotlin                                "Kotlin programming language compiler" off
	"$python_pkg"                         "Python programming language" off
	"$pip_pkg"                            "Python package manager" off
    golang                                "Go programming language compiler" off
    "$rust_pkg"                           "Rust programming language compiler" off
    rust-src                              "Rust standard library source code" off
    nodejs                                "JavaScript runtime environment" off
    yarn                                  "Alternative Node.js package manager" off
    php                                   "PHP programming language" off
    ruby                                  "Ruby programming language" off
    perl                                  "Perl programming language" off
    swift                                 "Swift programming language" off
    lua                                   "Lua programming language" off
    r-base                                "R programming language environment" off
    julia                                 "Julia programming language" off
    erlang                                "Erlang programming language" off
    elixir                                "Elixir programming language" off
    haskell                              "Haskell programming language compiler" off
    scala                                 "Scala programming language" off
)


essentials_terminal_dialog=(     # meant to contain pkgs that will not pull desktop environment with it, so safe to be installed by rookies in a server setup
	"######_essentials_terminal_pkgs_######" "__________ Collective Category __________" off

	
    "###_Terminals_Tools_###" "_____ Category Description [below] _____" off
	nano               "Beginner-friendly terminal text editor" on
	neovim             "Modern Vim-based text editor" on
	tmux               "Terminal multiplexer (split panes, sessions)" on

	
    "###_Media_Players_&_Tools_CLI_###" "_____ Category Description [below] _____" off
	mpv                "CLI/GUI media player (audio/video)" off
    ffmpeg             "CLI audio/video converter and recorder" on

    
    "###_System_Monitoring_###" "_____ Category Description [below] _____" off
	btop               "System monitor (like Task Manager)" on
    htop              "Interactive process viewer" off
	fastfetch          "System information fetcher (like neofetch)" on
    neofetch          "System information fetcher" off

    "###_Shell_Enhancements_###" "_____ Category Description [below] _____" off
	gawk             "Needed for ble.sh (core dependency)" on
    ble.sh           "Bash line editor with autosuggestions and syntax highlighting" off
    zsh              "Z shell (alternative to bash)" off
    #maybe AUR #oh-my-zsh        "Framework for managing zsh configuration" off
    #starship         "Cross-shell prompt with git and lang support" off
	
    "###_File_Management_###" "_____ Category Description [below] _____" off
    ranger             "A console file manager" on
    yazi              "A terminal file manager with git integration" off
	zip                "File compression utility" on
	unzip              "File decompression utility" on
	

    "###_Useful_CLI_Tools_###" "_____ Category Description [below] _____" off
	bat                "Modern cat alternative with syntax highlighting" off
	lsd                "Modern ls alternative with icons and colors" off
	zoxide             "Smarter cd command that learns directory usage" off
	fzf                "Fuzzy finder for fast search" on
	ripgrep            "Fast grep alternative for searching text" on

	"###_Network_Tools_CLI_###" "_____ Category Description [below] _____" off
	wget          "Command-line downloader (HTTP, HTTPS, FTP)" on
	# net-tools  # ill add when i understand each
	# nmap
	# iwd
	ufw           "Simple firewall manager (iptables frontend)" on
	fail2ban      "Intrusion prevention tool for SSH and services" off
    yt-dlp        "CLI tool to download videos from YouTube and other sites" off
	
    "###_Virtual_Emulators_###" "_____ Category Description [below] _____" off
    qemu-system  "Generic and open source machine emulator and virtualizer" off
    virtualbox   "Powerful x86 and AMD64/Intel64 virtualization product" off

    # tui
    "${ess_tui_pkgs_dialog[@]}"
)


essentials_desktop_dialog=(   # meant to contain pkgs that might pull desktop environment with it, so safe to be installed by rookies when inside a Desktop environment
    "######_essentials_desktop_pkgs_######" "__________ Collective Category __________" off

	"###_essentials_desktop_Tools_###" "_____ Category Description [below] _____" off
	"$thunar_pkg"       "Lightweight file manager (XFCE)" on
	zathura             "Keyboard-driven document viewer (PDF, EPUB, etc.)" on

    "###_Terminals_###" "_____ Category Description [below] _____" off
	kitty               "GPU-accelerated terminal emulator (images, ligatures)" on
    xfce4-terminal    "XFCE terminal emulator" off
    gnome-terminal     "GNOME terminal emulator" off
    alacritty          "GPU-accelerated terminal emulator (cross-platform)" off
    tilix              "Tiling terminal emulator (GTK)" off
    zutty              "Lightweight terminal emulator (X11)" off

    
    "###_Text_Editors_###" "_____ Category Description [below] _____" off
	mousepad            "Simple GUI text editor (Notepad-like)" on
    gedit               "GNOME text editor (Notepad-like)" off
    leafpad             "Lightweight GUI text editor (Notepad-like)" off
    pluma               "MATE text editor (Notepad-like)" off
    xed                 "Linux Mint text editor (Notepad-like)" off

    "###_Media_Players_###" "_____ Category Description [below] _____" off
	mpv                 "Media player for audio/video (CLI+GUI)" on
    vlc                 "Versatile media player (GUI)" off

    "###_Web_Browsers_###" "_____ Category Description [below] _____" off
    firefox             "A web browser" on
    chromium            "A web browser" off

    

    "###_content_creation_###" "_____ Category Description [below] _____" off
	obs-studio          "Screen recorder and streamer (open-source)" on
	shotcut             "Non-linear video editor (free)" on
    gimp                "Image editor (open-source Photoshop alternative)" off
    inkscape           "Vector graphics editor (open-source Illustrator alternative)" off

    "###_Desktop_Integration_###" "_____ Category Description [below] _____" off
	xdg-desktop-portal  "Desktop integration/screen share service (required by DEs)" on
	xdg-utils           "CLI desktop tools (xdg-open, mime handling, etc.)" on

    "###_Audio_Video_###" "_____ Category Description [below] _____" off
    pulseaudio                      "Legacy audio server (PulseAudio)" off
    jack-audio-connection-kit       "Low-latency audio server (JACK)" off
	pipewire                        "Modern audio/video server (PulseAudio/Jack replacement)" on
	"$pipewire_libs_pkg" "Audio client libraries for PipeWire" on

    pavucontrol                     "PulseAudio/PipeWire volume control GUI" on
    vlc-plugin-pipewire             "PipeWire support for VLC media player" off

	
    "###_Screenshot_Clipboard_###" "_____ Category Description [below] _____" off
    "#_sub_#"           "___ [X11 mainly] ___" off
	maim                "CLI screenshot utility (full/region)(X11 only)" off
	xclip               "CLI clipboard manager (X11 only)" off
    "#_sub_#"           "___ [Wayland mainly] ___" off
    grim                "Screenshot tool (Wayland only)" off
    slurp               "Region selector for screenshot (Wayland only)" off
    wl-clipboard       "Clipboard manager (Wayland only)" off
    "#_sub_#"           "___ [Post Screenshot tools] ___" off
    "$spectacle_pkg"    "A widely supported ss app" off
    flameshot           "A widely supported ss app" off
	
    "###_Network_Tools_GUI_###" "_____ Category Description [below] _____" off
	blueman             "Bluetooth device manager GUI (blueman-manager)" on
	"$network_manager_pkg" "Network connection manager (wired/wireless)" on
    network-manager-applet "Network connection manager GUI applet" on
    youtubedl-gui "[deb] GUI for youtube-dl/yt-dlp" on

    "###_Accessibility_Fonts_###" "_____ Category Description [below] _____" off
	speech-dispatcher  "Needed by softwares that relay on text-to-speech" off #  for TTS (i.e. text-to-speech for firefox and many)
	"$firacode_pkg"     "Monospace developer font (no glyphs)" off
)

essentials_hyprland_dialog=(
    "######_essentials_hyprland_pkgs_######" "__________ Collective Category __________" off

	"##########_Hyprland_Utils_##########" "__________ Category Description [below] __________" off
	waybar                      "Customizable status/task bar for Wayland" on
    quickbar                    "Lightweight Wayland status bar" off
	
    rofi                        "Launcher and window switcher (X11/Wayland)" on
    wofi                        "A Wayland native launcher" off

	hyprpaper                   "Wallpaper daemon for Hyprland" on
    mpvpaper                    "MPV-based wallpaper setter for Hyprland" off
    swww                        "Simple Wayland wallpaper setter" off

	
    "#_________#" "sub catagory" off
	xdg-desktop-portal-hyprland "Hyprland portal backend for screenshots/sharing" on
	"$hyprcursor_pkg"           "Cursor theme manager for Hyprland" on

    "#_________#" "sub catagory" off
    "$network_manager_pkg" "Network connection manager (wired/wireless)" on
    network-manager-applet "Network connection manager GUI applet" on
	
    "#_________#" "sub catagory" off
    cliphist                    "clipboard meneger" on
	wl-clipboard                "Clipboard manager (Wayland only)" on

    "#_________#" "sub catagory" off
	grim                        "Screenshot tool (Wayland only)" on
	slurp                       "Region selector for screenshot (Wayland only)" on
    swappy                      "Post SS tool (in short)" on
)

corechunk_hyprland_dialog=(
    "######_corechunk_hyprland_pkgs_######" "__________ Collective Category __________" off
                                                 # fully custom, not merged from any other array

	"#_________# Core Hyprland Utilities" "sub catagory" off
	hyprpaper                   "Wallpaper daemon for Hyprland" on
	xdg-desktop-portal-hyprland "Hyprland portal backend for screenshots/sharing" on
	"$hyprcursor_pkg"           "Cursor theme manager for Hyprland" on

	"#_________# Must for corechunk/hyprland" "sub catagory (used directly in the dots)" off
    kitty               "GPU-accelerated terminal emulator (images, ligatures)" on
	"$thunar_pkg"       "Lightweight file manager (XFCE)" on
	ranger                      "A console file manager" on
	firefox                     "A web browser" on

	"#_____# Launchers & Bars" "subsub catagory" off
	waybar                      "Customizable status/task bar for Wayland" on
	rofi                        "Launcher and window switcher (X11/Wayland)" on
	yad                         "Yet Another Dialog (for GUI scripting)" on

    "#_____# network,bluetooth, GUI applet etc" "subsub catagory" off
    blueman                     "Bluetooth device manager GUI" on
    "$libspa_bluetooth_pkg"        "dependency for blueman to handle audio device" on
    
    "$network_manager_pkg"      "Network connection manager (wired/wireless)" on
    network-manager-applet      "GUI applet for network-manager" on
    iwd                         "dependency for network-manager-applet" on

	"#_____# Notifications" "subsub catagory" off
    "$swaync_pkg"               "A lightweight notification daemon for Wayland" on
	"#_____# Clipboard & Screenshot" "subsub catagory" off
	cliphist                    "clipboard meneger" on
	wl-clipboard                "Clipboard manager (Wayland only)" on
	grim                        "Screenshot tool (Wayland only)" on
	slurp                       "Region selector for screenshot (Wayland only)" on
	swappy                      "Post SS tool (in short)" on

    "#_________# Recommended cli" "sub catagory" off
	neovim                      "Modern Vim-based text editor" on
	gawk                        "Needed for ble.sh (core dependency)" on
	tmux                        "Terminal multiplexer (split panes, sessions)" on
	btop                        "System monitor (like Task Manager)" on
	fastfetch                   "System information fetcher (like neofetch)" on
	zip                         "File compression utility" on
	unzip                       "File decompression utility (needed for oh-my-posh)" on

    "#_________# Recommended GUI" "sub catagory" off
	mousepad                    "Simple GUI text editor (Notepad-like)" on
	mpv                        "Media player for audio/video (CLI+GUI)" on
	zathura                    "Keyboard-driven document viewer (PDF, EPUB, etc.)" on

    "##_Unused_But_Identified_Dependencies_##" "sub catagory" off
    bc                          "Arbitrary precision calculator language (identified from jksel.sh)" off
    libnotify-bin               "Send desktop notifications (identified from jksel.sh)" off
    jq                          "Command-line JSON processor (identified from jksel.sh)" off
    swww                        "A Wayland native wallpaper daemon (identified from jksel.sh)" off
    mpvpaper                    "Video wallpaper utility for Wayland (identified from jksel.sh)" off
    swaybg                      "A wallpaper utility for Wayland (identified from jksel.sh)" off
    imagemagick                 "Image manipulation programs (identified from jksel.sh)" off
    ffmpeg                      "Multimedia framework (identified from jksel.sh)" off
    sddm                        "Simple Desktop Display Manager (Login Manager) (identified from jksel.sh)" off
    qt6-base-dev                "Qt 6 base development files" off
    qt6-tools-dev               "Qt 6 tools development files" off
    qt6-tools-dev-tools         "Qt 6 tools development utilities" off
    qt6-wayland                 "Qt 6 Wayland client integration" off
    qt6-wayland-dev             "Qt 6 Wayland development files" off
    qt6-declarative-dev         "Qt 6 declarative development files" off
    qt6-svg-dev                 "Qt 6 SVG development files" off
    libhyprutils-dev            "Hyprland utilities library development files" off
)

essentials_extra_dialog=(
	oh-my-posh   "Shell prompt theming engine (cross-shell)" on
	auto-cpufreq "CPU frequency optimizer and power saver" on
)






# non tui usage arrays
essentials_dev=()
essentials_terminal=()
essentials_desktop=()
essentials_hyprland=()
corechunk_hyprland=()
essentials_extra=()


shrink essentials_dev_dialog essentials_dev
shrink essentials_terminal_dialog essentials_terminal
shrink essentials_desktop_dialog essentials_desktop
shrink essentials_hyprland_dialog essentials_hyprland
shrink corechunk_hyprland_dialog corechunk_hyprland
shrink essentials_extra_dialog essentials_extra




#################################################
##################[ Generic ]####################
#################################################
firmware_generic=()
if [[ $(package_manager) == "apt" ]]; then
    firmware_generic_dialog=(
        firmware-linux "Binary firmware for various drivers in the Linux kernel (metapackage)" on
        firmware-linux-free "Binary firmware for various drivers in the Linux kernel" on
        firmware-linux-nonfree "Binary firmware for various drivers in the Linux kernel (metapackage)" on
    )
elif [[ $(package_manager) == "pacman" ]]; then
    firmware_generic_dialog=(
        "linux-firmware" "Firmware files for Linux" on
    )
elif [[ $(package_manager) == "dnf" ]]; then
    firmware_generic_dialog=(
        "linux-firmware" "Firmware files for Linux" on
    )
fi
shrink firmware_generic_dialog firmware_generic
#################################################
##################[ INTEL ]######################
#################################################
firmware_intel=()
if [[ $(package_manager) == "apt" ]]; then
    firmware_intel_dialog=(
        "intel-microcode" "Processor microcode firmware for Intel CPUs" on
        firmware-sof-signed    "Intel Sound Open Firmware firmware - signed" on
        firmware-misc-nonfree  "Binary firmware for various drivers in the Linux kernel" on
        firmware-iwlwifi       "Intel Wi-Fi firmware" on
        firmware-intel-graphics "Binary firmware for Intel iGPUs and IPUs" on
        firmware-intel-misc     "Binary firmware for miscellaneous Intel devices and chips" on
        firmware-intel-sound    "Binary firmware for Intel sound DSPs" on
    )
elif [[ $(package_manager) == "pacman" ]]; then
    firmware_intel_dialog=(
        "intel-ucode" "Processor microcode for Intel CPUs" on
        "linux-firmware"     "Firmware files for Linux"     on
        "sof-firmware"       "Sound Open Firmware"          on
        "mesa"               "OpenGL implementation"        on
        "vulkan-intel"       "Intel's Vulkan driver"        on
        "intel-media-driver" "Intel Media Driver for VAAPI" on
    )
elif [[ $(package_manager) == "dnf" ]]; then
    firmware_intel_dialog=(
        "microcode_ctl" "Microcode update utility for Intel and AMD" on
        "linux-firmware" "Firmware files for Linux" on
        "alsa-sof-firmware" "Sound Open Firmware" on
        "mesa-vulkan-drivers" "Mesa Vulkan drivers for Intel and AMD" on
        "intel-media-driver" "Intel Media Driver for VAAPI (from RPM Fusion)" on
    )
fi
shrink firmware_intel_dialog firmware_intel
#################################################
#################[AMD-radeon]####################
#################################################
firmware_amd=()
if [[ $(package_manager) == "apt" ]]; then
    firmware_amd_dialog=(
        "amd64-microcode" "Processor microcode firmware for AMD CPUs" on
        firmware-amd-graphics "Binary firmware for AMD/ATI graphics and NPU chips" on
    )
elif [[ $(package_manager) == "pacman" ]]; then
    firmware_amd_dialog=(
        "amd-ucode" "Processor microcode for AMD CPUs" on
        "linux-firmware" "Firmware files for Linux" on
        "mesa"           "OpenGL implementation" on
        "vulkan-radeon"  "Radeon's Vulkan driver" on
    )
elif [[ $(package_manager) == "dnf" ]]; then
    firmware_amd_dialog=(
        "microcode_ctl" "Microcode update utility for Intel and AMD" on
        "linux-firmware" "Firmware files for Linux" on
        "mesa-vulkan-drivers" "Mesa Vulkan drivers for Intel and AMD" on
    )
fi
shrink firmware_amd_dialog firmware_amd
#################################################
#################[ NVIDIA ]######################
#################################################
firmware_nvidia=()
if [[ $(package_manager) == "apt" ]]; then
    firmware_nvidia_dialog=(
        "nvidia-driver-full" "NVIDIA metapackage (all components)" on
        "firmware-nvidia-graphics" "Binary firmware for Nvidia GPU chips" on
        "nvidia-cuda-toolkit" "NVIDIA CUDA development toolkit" off
    )
elif [[ $(package_manager) == "pacman" ]]; then
    firmware_nvidia_dialog=(
        "nvidia" "NVIDIA driver" on
        "nvidia-utils" "NVIDIA driver utilities" on
        "lib32-nvidia-utils" "32-bit NVIDIA driver utilities" on
        "linux-firmware" "Firmware files for Linux" on
    )
elif [[ $(package_manager) == "dnf" ]]; then
    firmware_nvidia_dialog=(
        "akmod-nvidia" "NVIDIA driver kernel module (from RPM Fusion)" on
        "xorg-x11-drv-nvidia-cuda" "CUDA support for NVIDIA driver (from RPM Fusion)" on
    )
fi
shrink firmware_nvidia_dialog firmware_nvidia
#################################################

##########################    recheck all added in the if/else above (feelin lazy)

# research - linux-generic firmwares for arch
#	linux-firmware

# research - nvidia full stack for arch
#	nvidia
#	nvidia-utils
#	lib32-nvidia-utils
#	linux-firmware

# research - amd/radeon full stack for arch
#	linux-firmware (via linux-firmware-amdgpu)
#	mesa
#	vulkan-radeon

# research - amd/radeon full stack for arch
#	Debian: firmware-misc-nonfree      → Arch: linux-firmware (included by default)        # Misc Intel firmware (Wi-Fi, Bluetooth, etc.)
#	Debian: firmware-iwlwifi            → Arch: linux-firmware                                # Intel Wi-Fi firmware
#	Debian: firmware-sof-signed         → Arch: sof-firmware                                  # Intel Sound Open Firmware (DSP)
#	Debian: n/a (GPU integrated)        → Arch: mesa + vulkan-intel                          # Open-source GPU drivers for Intel iGPUs
#	Debian: n/a (optional proprietary)  → Arch: intel-media-driver / intel-graphics-driver   # Optional accelerated driver stack





#	Docker image's variant
#	# Debian
#	curl -s "https://registry.hub.docker.com/v2/repositories/library/debian/tags?page_size=100" | grep -oP '"name":\s*"\K[^"]+'
#	
#	# Ubuntu
#	curl -s "https://registry.hub.docker.com/v2/repositories/library/ubuntu/tags?page_size=100" | grep -oP '"name":\s*"\K[^"]+'
#	
#	# Fedora
#	curl -s "https://registry.hub.docker.com/v2/repositories/library/fedora/tags?page_size=100" | grep -oP '"name":\s*"\K[^"]+'
#	
#	# Arch Linux
#	curl -s "https://registry.hub.docker.com/v2/repositories/library/archlinux/tags?page_size=100" | grep -oP '"name":\s*"\K[^"]+'
#	
#	# Alpine
#	curl -s "https://registry.hub.docker.com/v2/repositories/library/alpine/tags?page_size=100" | grep -oP '"name":\s*"\K[^"]+'