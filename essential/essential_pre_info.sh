menu_info(){
	local info_text="
==============================================================
					   $GREEN INFO SECTION$RESET
==============================================================
$RED[ Error Handling ]$RESET
If the software encounters an error (such as unsupported distro, missing dependencies, or failed commands), it will:
- Print a clear error message to the terminal.
- Exit with a non-zero status code.
- In some cases, suggest manual installation or troubleshooting steps.

For example:
- Unsupported distro: 'Unsupported distro' and exit.
- Missing package: Error message with package name.
- Sourcing issues: Message about missing or unsourced files.

==============================================================
=========================$YELLOW Navigation$RESET =========================
$YELLOW Use ↑ ↓ / PgUp / PgDn to scroll vertically
$YELLOW Use ← → to scroll horizontally (with -S mode)
$YELLOW Press 'q' to exit viewer$RESET
==============================================================

───────────────────────────────$MAGENTA[ Development Tools ]$RESET───────────────────────────────
--- Development Tools ---
git                   | Version control system                         | CLI (All)                | Essential for dev work            | git
gh                    | GitHub CLI tool                                | CLI (All)                | GitHub integration                | gh
docker                | Containerization platform                      | CLI (All)                | Docker engine                     | docker
docker-compose        | Container orchestration tool                   | CLI (All)                | Compose multi-container apps      | docker-compose
$(printf "%-21s" "$build_essential_pkg") | Essential build tools (gcc, g++, make)           | CLI (All)                | Core compiler tools               | gcc, g++, make
gdb                   | Debugger for compiled languages                | CLI (All)                | Used for debugging C/C++          | gdb
$(printf "%-21s" "$manpages_pkg") | Developer manual pages                         | CLI (All)                | Adds developer manpages           | man

--- Build Systems ---
make                  | GNU build automation tool                      | CLI (All)                | Often pre-installed               | make
$(printf "%-21s" "$ninja_pkg") | Fast alternative build system                     | CLI (All)                | Alternative to make               | ninja
cmake                 | Cross-platform build system generator          | CLI (All)                | Generates build configs           | cmake
cargo                 | Rust package manager and build tool            | CLI (All)                | Rust build system                 | cargo
npm                   | Node.js package manager                        | CLI (All)                | JavaScript ecosystem              | npm
yarn                  | Alternative Node.js package manager            | CLI (All)                | Alternative to npm                | yarn
gradle                | Build automation tool (Java, Android, etc.)    | CLI (All)                | Java/Android build system         | gradle
maven                 | Java project management tool                   | CLI (All)                | Java build system                 | mvn
ant                   | Java build tool                                | CLI (All)                | Java build system                 | ant
autotools             | GNU build system (autoconf, automake, libtool) | CLI (All)                | C/C++ build system                | autoconf, automake, libtool

--- Compilers & Interpreters ---
gcc                   | C, C++, Objective-C, Fortran, Ada, D, Go       | CLI (All)                | Main compiler suite               | gcc
clang                 | C, C++, Objective-C compiler                   | CLI (All)                | LLVM-based compiler               | clang
javac                 | Java programming language compiler             | CLI (All)                | Java compiler                     | javac
$(printf "%-21s" "$openjdk_pkg") | Java Development Kit (includes JRE)            | CLI/GUI (All)            | Required for Java development     | java, javac
dotnet-sdk            | Microsoft .NET SDK                             | CLI (All)                | .NET development                  | dotnet
kotlin                | Kotlin programming language compiler           | CLI (All)                | JVM language                      | kotlinc
$(printf "%-21s" "$python_pkg") | Python programming language                    | CLI/GUI (All)            | Modern scripting language         | python3
$(printf "%-21s" "$pip_pkg") | Python package manager                         | CLI (All)                | For installing Python modules     | pip3
golang                | Go programming language compiler               | CLI (All)                | Go compiler                       | go
$(printf "%-21s" "$rust_pkg") | Rust programming language compiler                | CLI (All)                | Rust compiler                     | rustc
rust-src              | Rust standard library source code              | CLI (All)                | Rust source for dev               | N/A
nodejs                | JavaScript runtime environment                 | CLI (All)                | Node.js runtime                   | node
php                   | PHP programming language                       | CLI (All)                | Web scripting                     | php
ruby                  | Ruby programming language                      | CLI (All)                | Scripting language                | ruby
perl                  | Perl programming language                      | CLI (All)                | Scripting language                | perl
swift                 | Swift programming language                     | CLI (All)                | Apple language                    | swift
lua                   | Lua programming language                       | CLI (All)                | Embedded scripting                | lua
r-base                | R programming language environment             | CLI (All)                | Statistical computing             | R
julia                 | Julia programming language                     | CLI (All)                | Scientific computing              | julia
erlang                | Erlang programming language                    | CLI (All)                | Concurrent programming            | erl
elixir                | Elixir programming language                    | CLI (All)                | Functional language               | elixir
haskell               | Haskell programming language compiler          | CLI (All)                | Functional language               | ghc
scala                 | Scala programming language                     | CLI (All)                | JVM language                      | scala

───────────────────────────────$BLUE[ Terminal Tools ]$RESET───────────────────────────────
--- Terminals & Editors ---
nano                  | Beginner-friendly terminal text editor         | CLI (All)                | Easy for beginners                | nano
neovim                | Modern Vim-based text editor                   | CLI/GUI (All)            | Vim-based, powerful editor        | nvim
tmux                  | Terminal multiplexer                           | CLI (All)                | Manage multiple sessions          | tmux

--- Media Players & Tools (CLI) ---
mpv                   | CLI/GUI media player                           | CLI/GUI (All)            | Also supports GUI playback        | mpv
ffmpeg                | CLI audio/video converter and recorder         | CLI (All)                | Media conversion                  | ffmpeg

--- System Monitoring ---
btop                  | System monitor (like Task Manager)             | CLI (All)                | Task-manager alternative          | btop
htop                  | Interactive process viewer                     | CLI (All)                | Alternative to btop               | htop
fastfetch             | System info fetcher                            | CLI (All)                | Similar to neofetch               | fastfetch
neofetch              | System info fetcher                            | CLI (All)                | System info display               | neofetch

--- Shell Enhancements ---
gawk                  | Needed for ble.sh (core dependency)            | CLI (All)                | Text processing                   | gawk
ble.sh                | Bash line editor with autosuggestions          | CLI (All)                | Bash enhancement                  | ble.sh
zsh                   | Z shell (alternative to bash)                  | CLI (All)                | Alternative shell                 | zsh

--- File Management ---
ranger                | Console file manager                           | CLI (All)                | File management                   | ranger
yazi                  | Terminal file manager with git integration     | CLI (All)                | Modern file manager               | yazi
zip/unzip             | Compression/decompression utilities            | CLI (All)                | Common file operations            | zip, unzip

--- Useful CLI Tools ---
bat                   | Modern cat alternative with syntax highlighting| CLI (All)                | Enhanced file viewer              | bat
lsd                   | Modern ls alternative with icons and colors    | CLI (All)                | Adds icons and color              | lsd
zoxide                | Smarter cd command                             | CLI (All)                | Learns directory usage            | zoxide
fzf                   | Fuzzy finder for fast search                   | CLI (All)                | Used in scripts and search        | fzf
ripgrep               | Fast grep alternative for searching text       | CLI (All)                | Modern grep alternative           | rg

--- Network Tools (CLI) ---
wget                  | Command-line downloader                        | CLI (All)                | Supports HTTP, HTTPS, FTP         | wget
ufw                   | Simple firewall manager                        | CLI (All)                | Frontend for iptables             | ufw
fail2ban              | Intrusion prevention tool for SSH/services     | CLI (Server/Desktop)     | Protects SSH/services             | fail2ban-client
yt-dlp                | CLI tool to download videos from YouTube       | CLI (All)                | YouTube downloader                | yt-dlp

--- TUI Tools ---
gum                   | Modern CLI UI toolkit                          | CLI (All)                | Interactive CLI UI                | gum
dialog                | Classic CLI dialog tool                        | CLI (All)                | Dialog boxes in shell scripts     | dialog
${whiptail_pkg}       | Whiptail dialog alternative                    | CLI (All)                | Lightweight dialog                | whiptail

───────────────────────────────$GREEN[ Desktop Tools ]$RESET───────────────────────────────
--- File Managers ---
$(printf "%-21s" "$thunar_pkg") | Lightweight file manager (XFCE)                  | Desktop (X11/Wayland)    | XFCE’s file manager               | thunar

--- Document Viewers ---
zathura               | Keyboard-driven document viewer (PDF, EPUB, etc.)| Desktop (All)            | Keyboard-driven UI                | zathura

--- Terminals ---
kitty                 | GPU-accelerated terminal emulator (images, ligatures)| Desktop (All)            | Image and emoji support           | kitty
xfce4-terminal        | XFCE terminal emulator                         | Desktop (All)            | XFCE terminal                     | xfce4-terminal
gnome-terminal        | GNOME terminal emulator                        | Desktop (All)            | GNOME terminal                    | gnome-terminal
alacritty             | GPU-accelerated terminal emulator              | Desktop (All)            | Cross-platform terminal           | alacritty
tilix                 | Tiling terminal emulator (GTK)                 | Desktop (All)            | Tiling terminal                   | tilix
zutty                 | Lightweight terminal emulator (X11)            | Desktop (All)            | Minimal terminal                  | zutty

--- Text Editors ---
mousepad              | Simple GUI text editor                         | Desktop (All)            | Basic Notepad-like editor         | mousepad
gedit                 | GNOME text editor                              | Desktop (All)            | GNOME’s Notepad-like editor       | gedit
leafpad               | Lightweight GUI text editor                    | Desktop (All)            | Minimal Notepad-like editor       | leafpad
pluma                 | MATE text editor                               | Desktop (All)            | MATE’s Notepad-like editor        | pluma
xed                   | Linux Mint text editor                         | Desktop (All)            | Mint’s Notepad-like editor        | xed

--- Media Players ---
mpv                   | Media player                                   | Desktop (All)            | GUI and CLI playback supported    | mpv
vlc                   | Versatile media player (GUI)                   | Desktop (All)            | Popular media player              | vlc

--- Web Browsers ---
firefox               | Web browser                                    | Desktop (All)            | Popular browser                   | firefox
chromium              | Web browser                                    | Desktop (All)            | Chromium browser                  | chromium

--- Content Creation ---
obs-studio            | Screen recorder and streamer                   | Desktop (All)            | Free and open-source              | obs
shotcut               | Video editor                                   | Desktop (All)            | Non-linear video editor           | shotcut
gimp                  | Image editor                                   | Desktop (All)            | Photoshop alternative             | gimp
inkscape              | Vector graphics editor                         | Desktop (All)            | Illustrator alternative           | inkscape

--- Desktop Integration ---
xdg-desktop-portal    | Desktop integration/screen share service       | Desktop (All)            | Required by DEs                   | xdg-desktop-portal
xdg-utils             | CLI desktop tools (xdg-open, mime handling)    | Desktop (All)            | Handles xdg-open, mime, etc.      | xdg-open

--- Audio/Video ---
pulseaudio            | Legacy audio server                            | Desktop (All)            | PulseAudio server                 | pulseaudio
jack-audio-connection-kit| Low-latency audio server (JACK)             | Desktop (All)            | JACK audio server                 | jackd
pipewire              | Modern audio/video server                      | Desktop (All)            | PulseAudio/Jack replacement       | pipewire
$(printf "%-21s" "$pipewire_libs_pkg") | Audio client libraries for PipeWire              | Desktop (All)            | PipeWire client libraries         | N/A
pavucontrol           | PulseAudio/PipeWire volume control GUI         | Desktop (All)            | Volume control GUI                | pavucontrol
vlc-plugin-pipewire   | PipeWire support for VLC media player          | Desktop (All)            | VLC PipeWire plugin               | N/A

--- Screenshot & Clipboard ---
maim                  | CLI screenshot utility (X11 only)              | Desktop (X11)            | Full/region screenshot            | maim
xclip                 | CLI clipboard manager (X11 only)               | Desktop (X11)            | Clipboard access                  | xclip
grim                  | Screenshot tool (Wayland only)                 | Desktop (Wayland)        | Works with slurp                  | grim
slurp                 | Region selector for screenshot (Wayland only)  | Desktop (Wayland)        | Used with grim                    | slurp
wl-clipboard          | Clipboard manager (Wayland only)               | Desktop (Wayland)        | Clipboard access                  | wl-copy, wl-paste
$(printf "%-21s" "$spectacle_pkg") | A widely supported screenshot app                 | Desktop (All)            | KDE screenshot tool               | spectacle
flameshot             | A widely supported screenshot app              | Desktop (All)            | Screenshot tool                   | flameshot

--- Network Tools (GUI) ---
blueman               | Bluetooth device manager GUI                   | Desktop (All)            | GUI frontend for bluetoothctl     | blueman-manager
$(printf "%-21s" "$network_manager_pkg") | Network connection manager (wired/wireless)      | Desktop (All)            | Often used with GUI applets       | nm-connection-editor
network-manager-applet| Network connection manager GUI applet          | Desktop (All)            | Tray applet for NetworkManager    | network-manager-applet
youtubedl-gui         | GUI for youtube-dl/yt-dlp                      | Desktop (All)            | YouTube downloader GUI            | youtubedl-gui

--- Accessibility & Fonts ---
speech-dispatcher     | Needed by softwares that rely on text-to-speech| Desktop (All)            | TTS support for apps              | speech-dispatcher
$(printf "%-21s" "$firacode_pkg") | Monospace developer font                       | GUI/Desktop only         | No glyphs included                | N/A

───────────────────────────────$SKY_BLUE[ Hyprland Utilities ]$RESET────────────────────────────────────
--- Hyprland Utils ---
waybar                | Customizable status/task bar for Wayland        | Wayland (All)            | System info and tray bar          | waybar
rofi                  | Launcher and window switcher (X11/Wayland)     | X11/Wayland              | Similar to dmenu, extensible      | rofi
wofi                  | Wayland native launcher                        | Wayland                  | Launcher for Wayland              | wofi
hyprpaper             | Wallpaper daemon for Hyprland                  | Wayland (Hyprland)       | Lightweight wallpaper manager     | hyprpaper
xdg-desktop-portal-hyprland | Hyprland portal backend                 | Wayland (Hyprland)       | Enables screenshots/sharing       | N/A
$(printf "%-21s" "$hyprcursor_pkg") | Cursor theme manager for Hyprland              | Wayland (Hyprland)       | Controls custom cursor themes     | N/A
cliphist              | Clipboard manager for Wayland                   | Wayland                  | Clipboard history manager         | cliphist
wl-clipboard          | Clipboard manager (Wayland only)               | Wayland                  | Clipboard access                  | wl-copy, wl-paste
grim                  | Screenshot tool (Wayland only)                 | Wayland                  | Works with slurp                  | grim
slurp                 | Region selector for screenshot (Wayland only)  | Wayland                  | Used with grim                    | slurp
swappy                | Post screenshot tool for Wayland                | Wayland                  | Annotate/edit screenshots         | swappy

───────────────────────────────$YELLOW[ GitHub Apps (Custom Install) ]$RESET───────────────────────────
--- GitHub Apps ---
oh-my-posh            | Shell prompt theme engine                      | CLI (All)                | Adds themes and status segments   | oh-my-posh
auto-cpufreq          | CPU frequency optimizer                        | CLI (All)                | Power saving tool                 | auto-cpufreq

────────────────────────────────$ORANGE[ Firmware Packages ]$RESET────────────────────────────────────
--- Firmware ---
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