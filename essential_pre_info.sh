menu_info(){
	local info_text="
==============================================================
					   $GREEN INFO SECTION$RESET
==============================================================
=========================$YELLOW Navigation$RESET =========================
$YELLOW Use ↑ ↓ / PgUp / PgDn to scroll vertically
 Use ← → to scroll horizontally (with -S mode)
 Press 'q' to exit viewer$RESET
==============================================================
** AI generated so please check official doc first **
───────────────────────────────$MAGENTA[ Development CLI Packages ]$RESET───────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
git                   | Version control system                         | CLI (All)                | Essential for dev work            | git
build-essential(debian)| GCC, G++, Make build tools                    | CLI (Debian-based)       | Core compiler tools               | gcc, g++, make
base-devel(arch)                                                                                                                      | [same as above]
gdb                   | Debugger for compiled languages                | CLI (All)                | Used for debugging C/C++          | gdb
manpages-dev(debian)  | Developer manual pages                         | CLI (All)                | Adds developer manpages           | man
man-pages(arch)                                                                                                                       | [same as above]
make                  | GNU build automation tool                      | CLI (All)                | Often pre-installed               | make
ninja-build           | Fast build system                              | CLI (All)                | Alternative to make               | ninja
cmake                 | Cross-platform build system generator          | CLI (All)                | Generates build configs           | cmake
openjdk-25-jdk(debian)| Java Development Kit (includes JRE)            | CLI/GUI (All)            | Required for Java development     | java, javac
jdk-openjdk(arch)                                                                                                                     | [same as above]
python3               | Python programming language                    | CLI/GUI (All)            | Modern scripting language         | python3
python3-pip           | Python package manager                         | CLI (All)                | For installing Python modules     | pip3

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
fonts-firacode        | Monospace developer font                       | GUI/Desktop only         | No glyphs included                | N/A

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
network-manager       | Manage wired/wireless connections              | Desktop (All)            | Often used with GUI applets       | nm-connection-editor
kitty                 | GPU-accelerated terminal emulator              | Desktop (All)            | Image and emoji support           | kitty
thunar                | Lightweight file manager                       | Desktop (X11/Wayland)    | XFCE’s file manager               | thunar
mousepad              | Simple GUI text editor                         | Desktop (All)            | Basic Notepad-like editor         | mousepad
mpv                   | Media player                                   | Desktop (All)            | GUI and CLI playback supported    | mpv
zathura               | Document viewer (PDF, EPUB, etc.)              | Desktop (All)            | Keyboard-driven UI                | zathura
obs-studio            | Screen recorder and streamer                   | Desktop (All)            | Free and open-source              | obs
shotcut               | Video editor                                   | Desktop (All)            | Non-linear video editor           | shotcut
xdg-desktop-portal    | Screen sharing and app integration layer       | Desktop (All)            | Required for flatpak/screenshare  | N/A
xdg-utils             | Desktop integration utilities                  | Desktop (All)            | Handles xdg-open, mime, etc.      | xdg-open
maim                  | Screenshot tool                                | Desktop (X11/Wayland)    | Region and full capture support   | maim
xclip                 | Clipboard tool                                 | Desktop (X11/Wayland)    | Scriptable clipboard access       | xclip

───────────────────────────────$SKY_BLUE[ Hyprland Utilities ]$RESET────────────────────────────────────
Package               | Description                                    | Compatibility            | Remarks                          | Command
---------------------------------------------------------------------------------------------------------------
xdg-desktop-portal-hyprland | Hyprland portal backend                 | Wayland (Hyprland)       | Enables screenshots/sharing       | N/A
hyprpaper             | Wallpaper daemon for Hyprland                  | Wayland (Hyprland)       | Lightweight wallpaper manager     | hyprpaper
hyprcursor-util       | Cursor theme manager for Hyprland              | Wayland (Hyprland)       | Controls custom cursor themes     | N/A
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
INTEL                 | firmware-misc-nonfree,firmware-linux-nonfree,  | x86_64 | Enables Intel Wi-Fi, audio, GPU firmware
						  firmware-sof-signed, firmware-iwlwifi 
AMD                   | firmware-amd-graphics                          | x86_64 | Required for AMD GPUs
NVIDIA                | nvidia-driver                                  | x86_64 | Proprietary NVIDIA driver

==================================$RED[[ END ]]$RESET==================================
"

	# Use less for scrollable output
	echo -e "$info_text" | less -RS
}