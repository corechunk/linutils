# list of all catagories

# essentials_dev
# essentials_terminal
# essentials_desktop
# essentials_hyprland
# firmware_generic
# firmware_intel
# firmware_amd
# firmware_nvidia


# Now define the array using the variables
essentials_dev=()
essentials_dev_dialog=(
	"##########_CLI_Dev_Tools_##########" "__________ Catagory Description [below] __________" off
	git                                   "Version control system" on
	"$build_essential_pkg"                "Essential build tools (gcc, g++, make)" on
	gdb                                   "Debugging tools for C/C++" on
	"$manpages_pkg"                       "Developer manual pages" on
	make                                  "GNU build utility" on
	"$ninja_pkg"                           "Fast alternative build system" on
	cmake                                 "Cross-platform C++ build tool" on
	"$openjdk_pkg"                        "Java Development Kit (includes JRE)" on
	"$python_pkg"                         "Python programming language" off
	"$pip_pkg"                            "Python package manager" off
)
shrink essentials_dev_dialog essentials_dev


essentials_terminal=()
essentials_terminal_dialog=(     # meant to contain pkgs that will not pull desktop environment with it, so safe to be installed by rookies in a server setup
	"##########_essentials_terminal_Tools_##########" "__________ Category Description [below] __________" off
	gawk               "Needed for ble.sh (core dependency)" on
	
	nano               "Beginner-friendly terminal text editor" on
	neovim             "Modern Vim-based text editor" on
	tmux               "Terminal multiplexer (split panes, sessions)" on
	
	mpv                "CLI/GUI media player (audio/video)" off
	
	btop               "System monitor (like Task Manager)" on
	fastfetch          "System information fetcher (like neofetch)" on
	
	zip                "File compression utility" on
	unzip              "File decompression utility" on
	
	bat                "Modern cat alternative with syntax highlighting" off
	lsd                "Modern ls alternative with icons and colors" off
	zoxide             "Smarter cd command that learns directory usage" off
	fzf                "Fuzzy finder for fast search" on
	ripgrep            "Fast grep alternative for searching text" on
	
	"##########_Network_Tools_CLI_##########" "__________ Category Description [below] __________" off
	wget          "Command-line downloader (HTTP, HTTPS, FTP)" on
	# net-tools  # ill add when i understand each
	# nmap
	# iwd
	ufw           "Simple firewall manager (iptables frontend)" on
	fail2ban      "Intrusion prevention tool for SSH and services" off
)
shrink essentials_terminal_dialog essentials_terminal


essentials_desktop=()
essentials_desktop_dialog=(   # meant to contain pkgs that might pull desktop environment with it, so safe to be installed by rookies when inside a Desktop environment
	"##########_essentials_desktop_Tools_##########" "__________ Category Description [below] __________" off
	kitty               "GPU-accelerated terminal emulator (images, ligatures)" on
	"$thunar_pkg"       "Lightweight file manager (XFCE)" on
	mousepad            "Simple GUI text editor (Notepad-like)" on
	mpv                 "Media player for audio/video (CLI+GUI)" on
	zathura             "Keyboard-driven document viewer (PDF, EPUB, etc.)" on
	
	obs-studio          "Screen recorder and streamer (open-source)" on
	shotcut             "Non-linear video editor (free)" on

	blueman             "Bluetooth device manager GUI (blueman-manager)" on
	"$network_manager_pkg" "Network connection manager (wired/wireless)" on
    network-manager-applet "Network connection manager GUI applet" on
	
	xdg-desktop-portal  "Desktop integration/screen share service (required by DEs)" on
	xdg-utils           "CLI desktop tools (xdg-open, mime handling, etc.)" on

	pipewire                        "Modern audio/video server (PulseAudio/Jack replacement)" on
	"$pipewire_libs_pkg" "Audio client libraries for PipeWire" on
	

	maim                "CLI screenshot utility (full/region)(X11 only)" off
	xclip               "CLI clipboard manager (X11 only)" off

    "$spectacle_pkg"    "A widely supported ss app" off
    flameshot           "A widely supported ss app" off
	
	speech-dispatcher  "Needed by softwares that relay on text-to-speech" off #  for TTS (i.e. text-to-speech for firefox and many)
	"$firacode_pkg"     "Monospace developer font (no glyphs)" off
)
shrink essentials_desktop_dialog essentials_desktop

essentials_hyprland=()
essentials_hyprland_dialog=(
	"##########_Hyprland_Utils_##########" "__________ Category Description [below] __________" off
	waybar                      "Customizable status/task bar for Wayland" on
	rofi                        "Launcher and window switcher (X11/Wayland)" on
	hyprpaper                   "Wallpaper daemon for Hyprland" on
	
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
shrink essentials_hyprland_dialog essentials_hyprland

corechunk_hyprland=()
corechunk_hyprland_dialog=(
	"##########_Hyprland_Utils_##########" "__________ Category Description [below] __________" off

	"#_________# Core Hyprland Utilities" "sub catagory" off
	hyprpaper                   "Wallpaper daemon for Hyprland" on
	xdg-desktop-portal-hyprland "Hyprland portal backend for screenshots/sharing" on
	"$hyprcursor_pkg"           "Cursor theme manager for Hyprland" on

	"#_________# Must for corechunk/hyprland" "sub catagory (used directly in the dots)" off
    kitty               "GPU-accelerated terminal emulator (images, ligatures)" on
	"$thunar_pkg"       "Lightweight file manager (XFCE)" on
	firefox                     "A web browser" on

	"#_____# Launchers & Bars" "subsub catagory" off
	waybar                      "Customizable status/task bar for Wayland" on
	rofi                        "Launcher and window switcher (X11/Wayland)" on
	wofi                        "A Wayland native launcher" off

	"#_____# Clipboard & Screenshot" "subsub catagory" off
	cliphist                    "clipboard meneger" on
	wl-clipboard                "Clipboard manager (Wayland only)" on
	grim                        "Screenshot tool (Wayland only)" on
	slurp                       "Region selector for screenshot (Wayland only)" on
	swappy                      "Post SS tool (in short)" on

    "#_________# Recommended cli" "sub catagory" off
	ranger                      "A console file manager" on
	neovim                      "Modern Vim-based text editor" on
	gawk                        "Needed for ble.sh (core dependency)" on
	tmux                        "Terminal multiplexer (split panes, sessions)" on
	btop                        "System monitor (like Task Manager)" on
	fastfetch                   "System information fetcher (like neofetch)" on
	zip                         "File compression utility" on
	unzip                       "File decompression utility" on

    "#_________# Recommended GUI" "sub catagory" off
	mousepad            "Simple GUI text editor (Notepad-like)" on
	mpv                 "Media player for audio/video (CLI+GUI)" on
	zathura             "Keyboard-driven document viewer (PDF, EPUB, etc.)" on
	"$edge_pkg"                 "A web browser" off
)
shrink corechunk_hyprland_dialog corechunk_hyprland

essentials_extra=()
essentials_extra_dialog=(
	oh-my-posh   "Shell prompt theming engine (cross-shell)" on
	auto-cpufreq "CPU frequency optimizer and power saver" on
)
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