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
        [[ $pkg == _HEADER_* ]] && continue   # skip headers
        dest_ref+=("$pkg")
        #echo "$pkg"
    done
}

# Now define the array using the variables
dev_cli_dialog=(
    git                     "Version control system" on
    "$build_essential_pkg"  "Essential build tools (gcc, g++, make)" on
    gdb                     "Debugging tools for C/C++" on
    "$manpages_pkg"         "Developer manual pages" on
    make                    "GNU build utility" on
    ninja-build             "Fast alternative build system" on
    cmake                   "Cross-platform C++ build tool" on
    "$openjdk_pkg"          "Java Development Kit (includes JRE)" on
    python3                 "Python programming language" off
    python3-pip             "Python package manager" off
)
dev_cli=()
shrink dev_cli_dialog dev_cli

#echo ""
#for pkg in ${dev_cli[@]};do
#    echo $pkg
#done

#for ((i=0; i<${#dev_cli_dialog[@]}; i+=3)); do
#    pkg="${dev_cli_dialog[i]}"
#    [[ $pkg == _HEADER_* ]] && continue   # skip headers
#    dev_cli+=("$pkg")
#    echo "$pkg"
#done

core_cli_dialog=(
    gawk               "Needed for ble.sh (core dependency)" on
    tmux               "Terminal multiplexer (split panes, sessions)" on
    neovim             "Modern Vim-based text editor" on
    nano               "Beginner-friendly terminal text editor" on
    mpv                "CLI/GUI media player (audio/video)" off
    btop               "System monitor (like Task Manager)" on
    fastfetch          "System information fetcher (like neofetch)" on
    zip                "File compression utility" on
    unzip              "File decompression utility" on
    bat                "Modern cat alternative with syntax highlighting" on
    lsd                "Modern ls alternative with icons and colors" on
    zoxide             "Smarter cd command that learns directory usage" on
    fzf                "Fuzzy finder for fast search" on
    ripgrep            "Fast grep alternative for searching text" on
    fonts-firacode     "Monospace developer font (no glyphs)" off
)
core_cli=()
shrink core_cli_dialog core_cli

network_tools_cli_dialog=(
    wget          "Command-line downloader (HTTP, HTTPS, FTP)" on
    # net-tools  # ill add when i understand each
    # nmap
    # iwd
    ufw           "Simple firewall manager (iptables frontend)" on
    fail2ban      "Intrusion prevention tool for SSH and services" on
)
network_tools_cli=()
shrink network_tools_cli_dialog network_tools_cli

unknown_dialog=(
    pipewire                       "Modern audio/video server (PulseAudio/Jack replacement)" on
    pipewire-audio-client-libraries "Audio client libraries for PipeWire" on
)
unknown=()
shrink unknown_dialog unknown

core_gui_dialog=(
    blueman             "Bluetooth device manager GUI (blueman-manager)" on
    network-manager     "Network connection manager (wired/wireless)" on
    kitty               "GPU-accelerated terminal emulator (images, ligatures)" on
    thunar              "Lightweight file manager (XFCE)" on
    mousepad            "Simple GUI text editor (Notepad-like)" on
    mpv                 "Media player for audio/video (CLI+GUI)" on
    zathura             "Keyboard-driven document viewer (PDF, EPUB, etc.)" on
    obs-studio          "Screen recorder and streamer (open-source)" on
    shotcut             "Non-linear video editor (free)" off
    xdg-desktop-portal  "Desktop integration/screen share service (required by DEs)" on
    xdg-utils           "CLI desktop tools (xdg-open, mime handling, etc.)" on
    maim                "CLI screenshot utility (full/region)" on
    xclip               "CLI clipboard manager (X11/Wayland)" on
)
core_gui=()
shrink core_gui_dialog core_gui

hypr_utils_dialog=(
    xdg-desktop-portal-hyprland "Hyprland portal backend for screenshots/sharing" on
    hyprpaper                   "Wallpaper daemon for Hyprland" on
    hyprcursor                  "Cursor theme manager for Hyprland" on
    waybar                      "Customizable status/task bar for Wayland" on
    rofi                        "Launcher and window switcher (X11/Wayland)" on
    grim                        "Screenshot tool for Wayland" on
    slurp                       "Region selector for screenshots (Wayland)" on
    wl-copy                     "Clipboard manager for Wayland" on
)
hypr_utils=()
shrink hypr_utils_dialog hypr_utils

github_apps_dialog=(
    oh-my-posh   "Shell prompt theming engine (cross-shell)" on
    auto-cpufreq "CPU frequency optimizer and power saver" on
)
github_apps=()
shrink github_apps_dialog github_apps



firmware_intel_dialog=(
    firmware-misc-nonfree "Misc Intel firmware (Wi-Fi, Bluetooth, etc.)" on
    firmware-linux-nonfree "General non-free Linux firmware" on
    firmware-sof-signed    "Intel Sound Open Firmware (audio DSP)" on
    firmware-iwlwifi       "Intel Wi-Fi firmware" on
)
firmware_intel=()
shrink firmware_intel_dialog firmware_intel

firmware_amd_dialog=(
    firmware-amd-graphics "AMD GPU firmware (for display acceleration)" on
)
firmware_amd=()
shrink firmware_amd_dialog firmware_amd

firmware_nvidia_dialog=(
    nvidia-driver "Proprietary NVIDIA driver (GPU support)" on
)
firmware_nvidia=()
shrink firmware_nvidia_dialog firmware_nvidia




























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
hyprcursor            | Cursor theme manager for Hyprland              | Wayland (Hyprland)       | Controls custom cursor themes     | N/A
waybar                | Customizable status/task bar                   | Wayland (All)            | System info and tray bar          | waybar
rofi                  | Launcher and window switcher                   | X11/Wayland              | Similar to dmenu, very extensible | rofi
grim                  | Screenshot tool                                | Wayland only             | Works with slurp for region grab  | grim
slurp                 | Region selector for screenshots                | Wayland only             | Used with grim                   | slurp
wl-copy               | Clipboard utility                              | Wayland only             | Works like xclip alternative      | wl-copy

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