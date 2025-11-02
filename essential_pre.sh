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

shrink() {
	local src="$1"   # name of source array
	local dest="$2"  # name of destination array

	# make src a nameref (reference to original array)
	declare -n src_ref="$src"
	declare -n dest_ref="$dest"

	dest_ref=()  # clear destination array

	#echo ""
	for ((i=0; i<${#src_ref[@]}; i+=3)); do
		pkg="${src_ref[i]}"
		[[ $pkg == *#* ]] && continue   # skip headers
		dest_ref+=("$pkg")
		#echo "$pkg"
	done
}


# list of all catagories

# dev_cli
# core_cli
# core_gui
# hypr_utils
# network_tools_cli
# firmware
# firmware_intel
# firmware_amd
# firmware_nvidia
# dep_audio


# Now define the array using the variables
essentials_dev_dialog=(
	"##########_CLI_Dev_Tools_##########" "__________ Catagory Description [below] __________" off
	git                                   "Version control system" on
	"$build_essential_pkg"                "Essential build tools (gcc, g++, make)" on
	gdb                                   "Debugging tools for C/C++" on
	"$manpages_pkg"                       "Developer manual pages" on
	make                                  "GNU build utility" on
	ninja-build                           "Fast alternative build system" on
	cmake                                 "Cross-platform C++ build tool" on
	"$openjdk_pkg"                        "Java Development Kit (includes JRE)" on
	python3                               "Python programming language" off
	python3-pip                           "Python package manager" off
)
essentials_dev=()
shrink essentials_dev_dialog essentials_dev


core_cli_dialog=(
	"##########_Core_CLI_Tools_##########" "__________ Category Description [below] __________" off
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
core_cli=()
shrink core_cli_dialog core_cli


core_gui_dialog=(
	"##########_Core_GUI_Tools_##########" "__________ Category Description [below] __________" off
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
	
	speech-dispatcher  "Needed by softwares that relay on text-to-speech" #  for TTS (i.e. text-to-speech for firefox and many)
	fonts-firacode     "Monospace developer font (no glyphs)" on
)
core_gui=()
shrink core_gui_dialog core_gui

hypr_utils_dialog=(
	"##########_Hyprland_Utils_##########" "__________ Category Description [below] __________" off
	xdg-desktop-portal-hyprland "Hyprland portal backend for screenshots/sharing" on
	hyprpaper                   "Wallpaper daemon for Hyprland" on
	hyprcursor-util             "Cursor theme manager for Hyprland" on
	waybar                      "Customizable status/task bar for Wayland" on
	rofi                        "Launcher and window switcher (X11/Wayland)" on
	grim                        "Screenshot tool for Wayland" on
	slurp                       "Region selector for screenshots (Wayland)" on
	wl-clipboard                "Clipboard manager for Wayland" on
)
hypr_utils=()
shrink hypr_utils_dialog hypr_utils

github_apps_dialog=(
	oh-my-posh   "Shell prompt theming engine (cross-shell)" on
	auto-cpufreq "CPU frequency optimizer and power saver" on
)
github_apps=()
shrink github_apps_dialog github_apps


#################################################
firmware_intel_dialog=(
	firmware-misc-nonfree "Misc Intel firmware (Wi-Fi, Bluetooth, etc.)" on
	firmware-linux-nonfree "General non-free Linux firmware" on
	firmware-sof-signed    "Intel Sound Open Firmware (audio DSP)" on
	firmware-iwlwifi       "Intel Wi-Fi firmware" on
)
firmware_intel=()
shrink firmware_intel_dialog firmware_intel
#################################################
firmware_amd_dialog=(
	firmware-amd-graphics "AMD GPU firmware (for display acceleration)" on
)
firmware_amd=()
shrink firmware_amd_dialog firmware_amd
#################################################
firmware_nvidia_dialog=(
	nvidia-driver "Proprietary NVIDIA driver (GPU support)" on
)
firmware_nvidia=()
shrink firmware_nvidia_dialog firmware_nvidia
#################################################

