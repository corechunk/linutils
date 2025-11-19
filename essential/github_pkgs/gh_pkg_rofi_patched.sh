#!/bin/bash

install_rofi_patched() {
    echo "=== Installing Rofi (lbonn Wayland fork) ==="

    local PKG_MANAGER=$(package_manager)

    echo "=== Installing dependencies ==="
    if [[ "$PKG_MANAGER" == "apt" ]]; then
        install_pkgs_dynamic install-force \
            meson ninja-build git build-essential pkg-config \
            libpango1.0-dev libcairo2-dev libglib2.0-dev \
            libgdk-pixbuf-2.0-dev libstartup-notification0-dev \
            libxkbcommon-dev libxkbcommon-x11-dev \
            libxcb1-dev libxcb-xkb-dev libxcb-randr0-dev \
            libxcb-xinerama0-dev libxcb-util-dev \
            libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev \
            librsvg2-dev libwayland-dev wayland-protocols \
            libxcb-keysyms1-dev
    elif [[ "$PKG_MANAGER" == "pacman" ]]; then
        install_pkgs_dynamic install-force \
            meson ninja git base-devel pkgconf \
            pango cairo glib2 \
            gdk-pixbuf startup-notification \
            libxkbcommon libxkbcommon-x11 \
            libxcb xcb-util-xkb xcb-util-randr \
            xcb-util-xinerama xcb-util \
            xcb-util-wm xcb-util-cursor \
            librsvg wayland wayland-protocols \
            xcb-util-keysyms
    elif [[ "$PKG_MANAGER" == "dnf" ]]; then
        install_pkgs_dynamic install-force \
            meson ninja-build git @development-tools pkg-config \
            pango-devel cairo-devel glib2-devel \
            gdk-pixbuf2-devel startup-notification-devel \
            libxkbcommon-devel libxkbcommon-x11-devel \
            libxcb-devel libxcb-xkb-devel libxcb-randr-devel \
            libxcb-xinerama-devel libxcb-util-devel \
            libxcb-ewmh-devel libxcb-icccm-devel libxcb-cursor-devel \
            librsvg2-devel wayland-devel wayland-protocols-devel \
            libxcb-keysyms-devel
    else
        echo "Unsupported package manager. Please install dependencies manually."
        return 1
    fi

    echo "=== Creating temp directory ==="
    TMPDIR=$(mktemp -d)
    echo "Temp dir: $TMPDIR"
    cd "$TMPDIR" || { echo "Failed to change to temp directory"; return 1; }

    echo "=== Cloning rofi (lbonn wayland fork) ==="
    git clone --depth=1 https://github.com/lbonn/rofi.git || { echo "Failed to clone rofi"; return 1; }
    cd rofi || { echo "Failed to change to rofi directory"; return 1; }

    echo "=== Meson setup ==="
    meson setup build || { echo "Meson setup failed"; return 1; }

    echo "=== Building ==="
    ninja -C build || { echo "Ninja build failed"; return 1; }

    echo "=== Installing ==="
    sudo ninja -C build install || { echo "Ninja install failed"; return 1; }

    echo "=== Cleaning up ==="
    cd ~ || { echo "Failed to change to home directory"; return 1; }
    rm -rf "$TMPDIR"

    echo "=== DONE ==="
    echo "Rofi Wayland build installed successfully."
    # The original script had a 'read -rp "Press ENTER to exit..."' here.
    # Since this is a function within a larger script, it's better to let the calling script handle pauses.
    # If a pause is desired, it should be added in the menu function that calls this.
}