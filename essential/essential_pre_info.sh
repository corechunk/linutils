menu_info(){
	local info_text="
==============================================================
					   $GREEN INFO SECTION$RESET
==============================================================
=========================$YELLOW Navigation$RESET =========================
$YELLOW Use ↑ ↓ / PgUp / PgDn to scroll vertically
$YELLOW Use ← → to scroll horizontally (with -S mode)
$YELLOW Press 'q' to exit viewer$RESET
==============================================================
───────────────────────────────$MAGENTA[ Development CLI Packages ]$RESET───────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
git                   | Version control system                         | CLI (All)                | Essential for dev work            | git
$(printf "%-21s" "$build_essential_pkg") | GCC, G++, Make build tools                    | CLI (All)                | Core compiler tools               | gcc, g++, make
gdb                   | Debugger for compiled languages                | CLI (All)                | Used for debugging C/C++          | gdb
$(printf "%-21s" "$manpages_pkg") | Developer manual pages                         | CLI (All)                | Adds developer manpages           | man
make                  | GNU build automation tool                      | CLI (All)                | Often pre-installed               | make
$(printf "%-21s" "$ninja_pkg") | Fast build system                              | CLI (All)                | Alternative to make               | ninja
cmake                 | Cross-platform build system generator          | CLI (All)                | Generates build configs           | cmake
$(printf "%-21s" "$openjdk_pkg") | Java Development Kit (includes JRE)            | CLI/GUI (All)            | Required for Java development     | java, javac
$(printf "%-21s" "$python_pkg") | Python programming language                    | CLI/GUI (All)            | Modern scripting language         | python3
$(printf "%-21s" "$pip_pkg") | Python package manager                         | CLI (All)                | For installing Python modules     | pip3

────────────────────────────────$BLUE[ Core CLI Packages ]$RESET───────────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
gawk                  | Text processing and scripting tool             | CLI (All)                | Dependency for ble.sh             | gawk
tmux                  | Terminal multiplexer                           | CLI (All)                | Manage multiple sessions          | tmux
neovim                | Modern text editor                             | CLI/GUI (All)            | Vim-based, powerful editor        | nvim
nano                  | Simple text editor                             | CLI (All)                | Easy for beginners                | nano
mpv                   | CLI media player                               | CLI/GUI (All)            | Also supports GUI playback        | mpv
btop                  | Modern system monitor                          | CLI (All)                | Task-manager alternative          | btop
fastfetch             | System info viewer                             | CLI (All)                | Similar to neofetch               | fastfetch
zip/unzip             | Compression utilities                          | CLI (All)                | Common file operations            | zip, unzip
bat                   | cat alternative with highlighting              | CLI (All)                | Enhanced file viewer              | bat
lsd                   | Modern ls alternative                          | CLI (All)                | Adds icons and color              | lsd
zoxide                | Smart cd command                               | CLI (All)                | Learns directory usage            | z
fzf                   | Fuzzy finder                                   | CLI (All)                | Used in scripts and search        | fzf
ripgrep               | Fast text searcher                             | CLI (All)                | Modern grep alternative           | rg
$(printf "%-21s" "$firacode_pkg") | Monospace developer font                       | GUI/Desktop only         | No glyphs included                | N/A

───────────────────────────────$ORANGE[ Network Tools CLI ]$RESET────────────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
wget                  | Command-line downloader                        | CLI (All)                | Supports HTTP, HTTPS, FTP         | wget
ufw                   | Simple firewall manager                        | CLI (All)                | Frontend for iptables             | ufw
fail2ban              | Intrusion prevention tool                      | CLI (Server/Desktop)     | Protects SSH/services             | fail2ban-client

────────────────────────────────$GREEN[ Core GUI Packages ]$RESET───────────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
blueman               | Bluetooth device manager (GUI)                 | Desktop (X11/Wayland)    | GUI frontend for bluetoothctl     | blueman-manager
$(printf "%-21s" "$network_manager_pkg") | Manage wired/wireless connections              | Desktop (All)            | Often used with GUI applets       | nm-connection-editor
kitty                 | GPU-accelerated terminal emulator              | Desktop (All)            | Image and emoji support           | kitty
$(printf "%-21s" "$thunar_pkg") | Lightweight file manager                       | Desktop (X11/Wayland)    | XFCE’s file manager               | thunar
mousepad              | Simple GUI text editor                         | Desktop (All)            | Basic Notepad-like editor         | mousepad
mpv                   | Media player                                   | Desktop (All)            | GUI and CLI playback supported    | mpv
zathura               | Document viewer (PDF, EPUB, etc.)              | Desktop (All)            | Keyboard-driven UI                | zathura
obs-studio            | Screen recorder and streamer                   | Desktop (All)            | Free and open-source              | obs
shotcut               | Video editor                                   | Desktop (All)            | Non-linear video editor           | shotcut
xdg-desktop-portal    | Screen sharing and app integration layer       | Desktop (All)            | Required for flatpak/screenshare  | N/A
xdg-utils             | Desktop integration utilities                  | Desktop (All)            | Handles xdg-open, mime, etc.      | xdg-open
maim                  | Screenshot tool                                | Desktop (X11/Wayland)    | Region and full capture support   | maim
xclip                 | Clipboard tool                                 | Desktop (X11/Wayland)    | Scriptable clipboard access       | xclip
$(printf "%-21s" "$spectacle_pkg") | Screenshot tool                                | Desktop (All)            | A widely supported screenshot app | spectacle

───────────────────────────────$SKY_BLUE[ Hyprland Utilities ]$RESET────────────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
xdg-desktop-portal-hyprland | Hyprland portal backend                 | Wayland (Hyprland)       | Enables screenshots/sharing       | N/A
hyprpaper             | Wallpaper daemon for Hyprland                  | Wayland (Hyprland)       | Lightweight wallpaper manager     | hyprpaper
$(printf "%-21s" "$hyprcursor_pkg") | Cursor theme manager for Hyprland              | Wayland (Hyprland)       | Controls custom cursor themes     | N/A
waybar                | Customizable status/task bar                   | Wayland (All)            | System info and tray bar          | waybar
rofi                  | Launcher and window switcher                   | X11/Wayland              | Similar to dmenu, very extensible | rofi
grim                  | Screenshot tool                                | Wayland only             | Works with slurp for region grab  | grim
slurp                 | Region selector for screenshots                | Wayland only             | Used with grim                   | slurp
wl-clipboard          | Clipboard utility                              | Wayland only             | Works like xclip alternative      | wl-copy

───────────────────────────────$YELLOW[ GitHub Apps (Custom Install) ]$RESET───────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
oh-my-posh            | Shell prompt theme engine                      | CLI (All)                | Adds themes and status segments   | oh-my-posh
auto-cpufreq          | CPU frequency optimizer                        | CLI (All)                | Power saving tool                 | auto-cpufreq

────────────────────────────────$ORANGE[ Firmware Packages ]$RESET────────────────────────────────────
Chipset               | Packages                                       | Compatibility            | Remarks
---------------------------------------------------------------------------------------------------------------
INTEL                 | $(if [[ "$(package_manager)" == "apt" ]]; then echo "firmware-misc-nonfree, firmware-linux-nonfree, firmware-sof-signed, firmware-iwlwifi, firmware-intel-graphics, firmware-intel-misc, firmware-intel-sound"; elif [[ "$(package_manager)" == "pacman" ]]; then echo "intel-ucode, linux-firmware, sof-firmware, mesa, vulkan-intel, intel-media-driver"; elif [[ "$(package_manager)" == "dnf" ]]; then echo "microcode_ctl, linux-firmware, alsa-sof-firmware, mesa-vulkan-drivers, intel-media-driver"; fi) | x86_64 | Enables Intel Wi-Fi, audio, GPU firmware
AMD                   | $(if [[ "$(package_manager)" == "apt" ]]; then echo "amd64-microcode, firmware-amd-graphics"; elif [[ "$(package_manager)" == "pacman" ]]; then echo "amd-ucode, linux-firmware, mesa, vulkan-radeon"; elif [[ "$(package_manager)" == "dnf" ]]; then echo "microcode_ctl, linux-firmware, mesa-vulkan-drivers"; fi) | x86_64 | Required for AMD GPUs
NVIDIA                | $(if [[ "$(package_manager)" == "apt" ]]; then echo "nvidia-driver-full, firmware-nvidia-graphics, nvidia-cuda-toolkit (optional)"; elif [[ "$(package_manager)" == "pacman" ]]; then echo "nvidia, nvidia-utils, lib32-nvidia-utils, linux-firmware"; elif [[ "$(package_manager)" == "dnf" ]]; then echo "akmod-nvidia, xorg-x11-drv-nvidia-cuda"; fi) | x86_64 | Proprietary NVIDIA driver

==================================$RED[[ END ]]$RESET==================================
"

	# Use less for scrollable output
	echo -e "$info_text" | less -RS
}