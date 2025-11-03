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
	python3                               "Python programming language" off
	python3-pip                           "Python package manager" off
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
	fail2ban      "Intrusion prevention tool for SSH and services" on
)
shrink essentials_terminal_dialog essentials_terminal


essentials_desktop=()
essentials_desktop_dialog=(   # meant to contain pkgs that might pull desktop environment with it, so safe to be installed by rookies when inside a Desktop environment
	"##########_essentials_desktop_Tools_##########" "__________ Category Description [below] __________" off
	kitty               "GPU-accelerated terminal emulator (images, ligatures)" on
	thunar              "Lightweight file manager (XFCE)" on
	mousepad            "Simple GUI text editor (Notepad-like)" on
	mpv                 "Media player for audio/video (CLI+GUI)" on
	zathura             "Keyboard-driven document viewer (PDF, EPUB, etc.)" on
	
	obs-studio          "Screen recorder and streamer (open-source)" on
	shotcut             "Non-linear video editor (free)" on

	blueman             "Bluetooth device manager GUI (blueman-manager)" on
	network-manager     "Network connection manager (wired/wireless)" on
	
	pipewire                        "Modern audio/video server (PulseAudio/Jack replacement)" on
	pipewire-audio-client-libraries "Audio client libraries for PipeWire" on
	
	xdg-desktop-portal  "Desktop integration/screen share service (required by DEs)" on
	xdg-utils           "CLI desktop tools (xdg-open, mime handling, etc.)" on
	
	maim                "CLI screenshot utility (full/region)" on
	xclip               "CLI clipboard manager (X11/Wayland)" on
	
	speech-dispatcher  "Needed by softwares that relay on text-to-speech" off #  for TTS (i.e. text-to-speech for firefox and many)
	fonts-firacode     "Monospace developer font (no glyphs)" off
)
shrink essentials_desktop_dialog essentials_desktop

essentials_hyprland=()
essentials_hyprland_dialog=(
	"##########_Hyprland_Utils_##########" "__________ Category Description [below] __________" off
	waybar                      "Customizable status/task bar for Wayland" on
	rofi                        "Launcher and window switcher (X11/Wayland)" on
	hyprpaper                   "Wallpaper daemon for Hyprland" on
	
	xdg-desktop-portal-hyprland "Hyprland portal backend for screenshots/sharing" on
	hyprcursor-util             "Cursor theme manager for Hyprland" on
	
	grim                        "Screenshot tool for Wayland" on
	slurp                       "Region selector for screenshots (Wayland)" on
	wl-clipboard                "Clipboard manager for Wayland" on
)
shrink essentials_hyprland_dialog essentials_hyprland

essentials_extra=()
essentials_extra_dialog=(
	oh-my-posh   "Shell prompt theming engine (cross-shell)" on
	auto-cpufreq "CPU frequency optimizer and power saver" on
)
shrink essentials_extra_dialog essentials_extra







#################################################
##################[ Generic ]####################
#################################################  haven't check this part for arch
firmware_generic=()
firmware_generic_dialog=(
	firmware-linux "Binary firmware for various drivers in the Linux kernel (metapackage)" on
	firmware-linux-free "Binary firmware for various drivers in the Linux kernel" on
	firmware-linux-nonfree "Binary firmware for various drivers in the Linux kernel (metapackage)" on
)
shrink firmware_generic_dialog firmware_generic
#################################################
##################[ INTEL ]######################
#################################################
firmware_intel=()
firmware_intel_dialog=(   # debian:sid confirmed
	firmware-sof-signed    "Intel Sound Open Firmware firmware - signed" on
	firmware-misc-nonfree "Binary firmware for various drivers in the Linux kernel" on
	firmware-iwlwifi       "Intel Wi-Fi firmware" on

	firmware-intel-graphics "Binary firmware for Intel iGPUs and IPUs" on
	firmware-intel-misc "Binary firmware for miscellaneous Intel devices and chips" on
	firmware-intel-sound "Binary firmware for Intel sound DSPs" on

)
shrink firmware_intel_dialog firmware_intel
#################################################
#################[AMD-radeon]####################
#################################################
firmware_amd_dialog=(   # debian:sid confirmed
	firmware-amd-graphics "Binary firmware for AMD/ATI graphics and NPU chips" on
)
firmware_amd=()
shrink firmware_amd_dialog firmware_amd
#################################################
#################[ NVIDIA ]######################
#################################################
firmware_nvidia_dialog=(   # debian:sid confirmed
	nvidia-driver-full "NVIDIA metapackage (all components)" on
	firmware-nvidia-grphics "Binary firmware for Nvidia GPU chips" on
)
firmware_nvidia=()
shrink firmware_nvidia_dialog firmware_nvidia
#################################################


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