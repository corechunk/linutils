# linutils — A Linux Setup Automation Script



## Introduction

**linutils** is a modular **Bash-based** setup utility for automating essential Linux configuration and package installation.  
It’s designed for **GNU/Linux systems** — primarily **Debian/Ubuntu**, **Arch**, and **Fedora**-based distributions — but runs on any distro with GNU tools and Bash available.

### It automates post-install setup tasks such as : 
- `developer tool installation`
- `CLI/GUI essentials`
- `firmware setup`
- `firewall configuration`
- `power optimization.  `
- plus more

Because it’s written entirely in **Bash**, it works anywhere Bash does — no extra dependencies or frameworks required [ except curl to run it first time ].

> **Note about GNU / Bash:**  
> `linutils` is written in **Bash** and built on **GNU core utilities**, making it compatible with most **GNU/Linux** systems by default.  
> It targets **Debian/Ubuntu**, **Arch**, and **Fedora**, but should run on any distro with `bash`, a supported package manager (`apt`, `pacman`, or `dnf`), and standard GNU tools available.  
> On minimal systems or containers using `sh`, `dash`, or `ash`, simply run it explicitly with:  
> ```
> bash linutils.sh   . . .
> ```

<!--
---
###### will add gallery here  
-->
---

## Usage (Default)

By default, `linutils` runs in **remote + TUI** mode when invoked with no arguments (this is the recommended quick path).

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutils.sh)
```

This default invocation does the following:
- sources dependency scripts remotely from the project repo (the `remote` sourcing mode),
- launches the **TUI** (dialog) menu for interactive selection,
- shows a progress bar while fetching dependencies.

> **Default behavior summary:** `remote` sourcing + `tui` interface.

---

## CLI args

linutils uses **positional** CLI arguments for now. In future versions we will support `--long-args` style flags.

**Current positional arguments:**

1. **Sourcing mode** (first positional arg)
   - `remote` (default): fetch and source dependency scripts from GitHub.
   - `local`: source dependency scripts from the current directory (use when you cloned the repo).

2. **Interface mode** (second positional arg)
   - `tui`: launch the `dialog` based text UI (recommended).
   - `cli` (default): plain CLI prompts and textual menus.

**Examples**

```bash
# Default (remote + TUI)
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutils.sh)

# Remote + CLI
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutils.sh) remote cli

# Local + TUI (run from repo root)
git clone https://github.com/corechunk/linutils.git
cd linutils
bash linutils.sh local tui
```

**Notes**
- If you omit the second argument, the script will use `cli` as the default for the interface.
- If you omit the first argument, the script will assume `remote`.
- Future versions: plan to add `--remote/--local`, `--tui/--cli`, and other `--` flags for clearer, non-positional invocation and better scripting.

---

## Features (at-a-glance)

- #### Loading The Script :
  - Modular dependency sourcing (remote or local) with a progress bar.
  - Dual interface: TUI (`dialog`) and CLI.
- #### Post Loading Functionalities :
  - Package group installer with cross-distro package-name mapping (Debian ↔ Arch ↔ Fedora).
  - Distro-aware package manager menu with specific options (e.g., enable Sid for Debian, Multilib for Arch, RPM Fusion for Fedora).
  - Firmware install groups (Intel / AMD / NVIDIA / generic).
  - **Developer toolchain** group (build-essential/base-devel, compilers, debuggers).
  - Essential **Server** and **Desktop** packages (editors, terminals, screenshot tools, media tools).
  - **Firewall and security menu (UFW, Fail2Ban).**
  - **Battery and power optimizations (auto-cpufreq installer).**
  - Helpful UX: colorized messages, pauses/halt for user review, and clean terminal resets.
>- #### Purpose kept in mind when making
>  - Desktop packages section might contain cli tools that needs Desktop environment cause the section is meant for post Desktop environment setup so packages don't pull desktop environment with itself.
>  - Extendable repo that can be modified by beginner coders/programmers.

---

## Menu overview

When launched, the main menu exposes options like:

- `00` __ Package Manager Utilities
- `01` __ Install Desktop Environment (via `tasksel`)
- `1`  ___ Essential CLI/Dev tools
- `2`  ___ Core CLI tools
- `3`  ___ Core GUI tools
- `4`  ___ Hyprland / Wayland ecosystem helpers
- `9`  ___ Info page (detailed package list and notes)
- `x`  ___ Exit

Each menu leads to a checklist (TUI) or a batch-selection (CLI). The **Package Manager Utilities** menu is now distro-aware, providing relevant options for your system:
- **Debian:** Edit sources, switch to `sid` (unstable).
- **Ubuntu:** Edit sources, enable `universe`/`multiverse`/`restricted` repos.
- **Arch Linux:** Edit `pacman.conf`, enable `multilib` repository, rank mirrors.
- **Fedora:** Edit `dnf.conf`, enable RPM Fusion repositories.

The script then lets users pick an installation method (install / force / remove / purge, etc.).

---

## How package mapping works (cross-distro)

The script detects the package manager with `package_manager()` (`apt`, `pacman`, `dnf`) and maps names where necessary. Examples:

- `build-essential` (Debian) ↔ `base-devel` (Arch)
- `openjdk-25-jdk` (Debian) ↔ `jdk-openjdk` (Arch)
- `@kde-desktop` (Fedora)
- Firmware: Debian often splits firmware into `firmware-*` packages (and may require `non-free-firmware`), while Arch bundles most firmware in `linux-firmware`.

You’ll find per-category arrays in the code like `essentials_dev_dialog`, `firmware_intel_dialog`, etc. The script uses a `shrink` helper to produce clean package arrays from the dialog-format arrays to use the same array with CLI-interface usage and then installs via `install_pkg_dynamic()` which handles apt/pacman differences.

---

## UX & safety behavior

- The script performs **sanity checks** (detect `dialog`, prompt to install it if missing).
- When installing packages the script checks whether the current user can run `sudo` without a password and informs the user — the sudo password prompt will appear at the first privileged operation when needed.
- After large install batches the script halts so the user can inspect output logs before continuing.
- Color-coded messages (`[OK]`, `[ERROR]`, `[NOTE]`, and `[ACTION]`) help with readability.

---

## Firmware & driver handling notes

Firmware packaging differs across distros; the script treats firmware carefully and asks for user consent:

- **Intel firmware (Debian names):** `firmware-intel-graphics`, `firmware-intel-misc`, `firmware-intel-sound`, `firmware-sof-signed`, `firmware-iwlwifi`  
  (On Arch these are usually present within `linux-firmware` or corresponding community packages.)

- **AMD:** `firmware-amd-graphics` on Debian; on Arch use `linux-firmware` + `mesa` + `vulkan-radeon`.

- **NVIDIA:** On Debian there are `nvidia-driver`, `nvidia-driver-full`, and `firmware-nvidia-graphics`. On Arch use `nvidia`, `nvidia-utils`, `lib32-nvidia-utils`, and rely on `linux-firmware` for firmware.

> **Important:** many firmware packages are `non-free` on Debian. The script warns users and will not force non-free firmware installs without consent. Infact the user choose non-free-firmware packages and they will install via the installation type they choose and the firmware will only be found if they have edited their package-manager-source-list to include non-free/non-free-firmware.

---

## Extensibility & development notes

- The script is intentionally modular: dependency files (e.g. `base.sh`, `pkg_mng_debian.sh`, `pkg_mng_arch.sh`, `pkg_mng_fedora.sh`, `essential.sh`, etc.) are sourced. Add new modules to the repo and list them in the main script to expand functionality.
- You can add or edit package arrays to customize the default installation sets.
- Future improvements planned:
  - now (fix/change all menu appearences and fix_flickering)
  - add (hyprland+sddm) in DE section, make tasksel like equivalent for arch-based distro.
    - the script default will be tasksel like custom function for both arch/debian but tasksel option will be optionally selectable
  - Full `--flag` style CLI options (instead of positional args).
  - Better AUR handling for Arch (auto-detect and use `paru`/`yay` or build from source).
  - More robust detection and handling of non-Debian/Arch distros.
  - Optional dry-run mode and verbose logging.
  - add gaming dependency pkgs
  - sub-catagorize the existing arrays to let users find a specific packages when they wanna install just a few pkgs. (instead of deselecting everything from big-pkg-catagories for 1 application)
    - Cause [Chris's](https://github.com/ChrisTitusTech) linutil kinda lacks the [winutil](https://github.com/ChrisTitusTech/winutil) like behaviour where you can choose from large numbers of softwares by toggling/select_all/deselect_all.

---

## 🤝 Contribution Guidelines

If you want to help:
- for improved package mappings per-distro.
- Add modules for distro-specific installers.
- Improve detection for non-interactive environments (CI / containers).

If you’d like to contribute improvements (package mappings, distro-specific modules, or CI/container support), please contact me first via DM, message, or issue comment before creating a PR. This ensures your ideas are discussed and aligned with the project’s direction.

All contributions will go through review to maintain quality, and any changes are merged by the maintainer.

When contributing, please:
- Keep code POSIX-friendly where possible.
- Keep `dialog` UI friendly for 90w×30h or larger terminals.
- Document new arrays and their purpose.

---

## Example: quick local run (if you cloned repo)

```bash
git clone https://github.com/corechunk/linutils.git
cd linutils
# Run with local sourcing + dialog TUI
bash linutils.sh local tui
```

---

## Final notes

- This README was updated to reflect the current code structure and UX choices. If you contribute for changes, then update the behavior/changes in this README accordingly.  
- The project aims to balance **safe defaults** (ask before changing system firmware or critical settings) with **convenience** (bulk install groups and helpful prompts).

---

## License - MIT
<!--
 — see the repository for details.
-->
