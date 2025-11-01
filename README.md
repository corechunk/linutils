# ==========[[ Under Major Construction ]]==========
# 💻 **linutils — A Linux Setup Automation Script**

A modular Linux setup utility that automatically fetches, sources, and runs configuration scripts for essential tools, development environments, and system optimizations.  
Works on **Debian/Ubuntu-based** systems and partially on **Arch-based** systems (under development).

---

## 🚀 **Usage**

This script supports **two sourcing modes** — `remote` *(default)* and `local` — and **two interfaces** — `tui` *(dialog-based)* and `cli` *(text-based)*.

- **Sourcing mode:** controls **where** dependency scripts are loaded from  
- **Interface mode:** controls **how** the user interacts (TUI or CLI)

> ⚠️ **Important:** If using locally, always run the script from its **own directory**; otherwise dependency sourcing will fail.
---
You can follow Quick Start : [[ visit page ]](./quick.md)
 
---

### 🟢 **Option 1: Run Directly from GitHub (Remote Sourcing)**
Automatically downloads and runs the latest stable version of all dependency scripts.

**TUI Mode (recommended):**
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutils.sh) remote tui
```

**CLI Mode:**
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutils.sh) remote cli
```

If you omit the second argument (`cli` or `tui`), it defaults to **CLI** mode.

---

### 🟡 **Option 2: Run Locally (Offline / Cloned Repository)**

If you’ve cloned the repository, you can run it locally to use offline dependency sourcing.

**TUI Mode:**
```
git clone https://github.com/corechunk/linutils.git
cd linutils
bash linutils.sh local tui
```

**CLI Mode:**
```
git clone https://github.com/corechunk/linutils.git
cd linutils
bash linutils.sh local cli
```

> 💡 **Note:** You must run it from the **repo root directory** (`linutils/`) so it can find all required `.sh` dependency files.

### Default Way
without additional arguments the default mode is "remote:tui". Also you can keep any single one off or you can keep both off. whatever option you keep off, the default for that will be chosen automatically.

- Sourcing Default : `remote`
- Interface Default : `cli`

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutils.sh)
```

---

### 🔁 **Mode Summary**

| Argument 1 | Description |
|:------------|:------------|
| `remote` *(default)* | Fetch dependencies from GitHub |
| `local` | Source dependencies from local files |

| Argument 2 | Description |
|:------------|:------------|
| `tui` | Launches the dialog-based interface |
| `cli` *(default)* | Runs in standard terminal mode |

**Examples:**
```
bash linutils.sh          # remote sourcing + CLI (default)
bash linutils.sh remote tui
bash linutils.sh local tui
bash linutils.sh local cli
```

---

### 🧪 **Beta Version [nothing new in beta right now]**
For testing the latest experimental features:
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutilsBETA.sh) remote tui
```

> Works the same as above — supports both `local` and `remote`, and both `tui` or `cli`.


---

### 🔹 Notes
- Dependencies are modular; missing or outdated scripts will be fetched automatically when running online.
- Local execution ensures reproducibility without needing internet.
- If you encounter issues with missing packages or scripts, check that you are in the repo root directory.

---

## 📦 **Features**

- 🌐 Auto-downloads and sources required scripts from the main repository.  
- ⚙️ Provides a simple interactive menu for managing:
  - APT sources  
  - Tasksel-based desktop environment installation  
  - Firewall setup (UFW, Fail2Ban)  
  - Battery optimization (auto-cpufreq)  
  - Essential CLI/GUI packages  
  - Developer tools (C++, Java, Python, etc.)
- 🧰 Supports modular dependency files:
  - `base.sh`  
  - `apt-source.sh`  
  - `essential.sh`  
  - `auto-cpufreq.sh`  
  - `security.sh`

---

## 🧩 **Menu Overview**

| Option | Description |
|:--|:--|
| **00** | Edit APT source list *(Debian only)* |
| **01** | Download & install Desktop Environment *(via tasksel)* |
| **1** | Essential CLI/GUI/Dev tools *(modular installer)* |
| **2** | Enable firewall (UFW + Fail2Ban) |
| **3** | Enable battery optimization *(auto-cpufreq)* |
| **4** | Dotfiles and wallpapers *(coming soon)* |
| **x** | Exit script |

---

## 🧰 **Package Groups**

### 🧑‍💻 **Developer Tools (CLI)**
Includes compilers, debuggers, and build systems.
- `git`
- `build-essential` *(Debian)* / `base-devel` *(Arch)*
- `gdb`
- `manpages-dev` *(Debian)* / `man-pages` *(Arch)*
- `make`, `ninja-build`, `cmake`
- `openjdk-25-jdk` *(Debian)* / `jdk-openjdk` *(Arch)*
- `python3`, `python3-pip`

---

### 🧱 **Core CLI Tools**
Essential system and productivity utilities.
- `tmux`
- `neovim`, `nano`
- `mpv`
- `btop`
- `fastfetch`
- `zip`, `unzip`
- `bat`, `lsd`, `zoxide`, `fzf`, `ripgrep`
- `fonts-firacode`

---

### 🖥️ **Core GUI Tools**
GUI-based essentials for desktop systems.
- `kitty`
- `thunar`, `mousepad`
- `mpv`, `zathura`
- `obs-studio`, `shotcut`
- `waybar`, `rofi`
- `xdg-utils`, `xdg-desktop-portal`
- `maim`, `xclip` (for screenshots & clipboard management)

---

### 🌐 **Network & Security Tools**
Network management, firewall, and system security.
- `wget`
- `ufw`
- `fail2ban`
- *(Optional / future)*: `net-tools`, `nmap`, `iwd`

---

### 🧭 **GitHub Projects**
Third-party tools automatically cloned and installed:
- `oh-my-posh`  
- `auto-cpufreq`

---

### 💾 **Firmware Packages**
- **Intel**: `firmware-misc-nonfree`, `firmware-linux-nonfree`, `firmware-sof-signed`, `firmware-iwlwifi`  
- **AMD**: `firmware-amd-graphics`  
- **NVIDIA**: `nvidia-driver`

---

## 🧠 **Development Notes**

### ⚠️ **Current Issues**
- Option **00. edit apt source** — not yet Arch compatible.  
- Option **01. Download Desktop Environment (via tasksel)** — not yet Arch compatible.  
- Firewall detection (UFW + Fail2Ban) may be unstable on some setups.

---

### 💡 **Future Development Ideas**
- Add support to source dependencies **locally** if the repo is cloned.  
- Implement a **tasksel-like system for Arch**.  
- Add support for **dialog-based menus**.  
- Improve **Arch compatibility** (AUR integration via `paru` or `yay`).  

---

### 🔄 **Packages Requiring Manual Update**
These package names may change over time:
- **Debian:** `openjdk-25-jdk` *(currently required because `default-jdk` is still version 21 even in Sid)*  

---

## 🧰 **Third-Party Repository (for Yazi on Debian)**

To add Yazi’s repository (not available in APT by default):

```
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | \
sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
```

Then add the source:

```
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | \
sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
```

---

## 🧾 **Developer Info**

- **Repo:** [corechunk/linutils](https://github.com/corechunk/linutils)  
- **License:** MIT  
- **Author:** [corechunk](https://github.com/corechunk)  
- **Compatible Systems:** Debian / Ubuntu / Arch *(partial)*  

---

🌀 *“Automate the boring setup, so you can focus on creation.”*
