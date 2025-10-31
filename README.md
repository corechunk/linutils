# ==========[[ Under Major Construction ]]==========
# 💻 **linutils — A Linux Setup Automation Script**

A modular Linux setup utility that automatically fetches, sources, and runs configuration scripts for essential tools, development environments, and system optimizations.  
Works on **Debian/Ubuntu-based** systems and partially on **Arch-based** systems (under development).

---

## 🚀 **Usage**

This script supports two main usage modes: **online** (run directly from GitHub) or **local** (run from a cloned repository).  

> ⚠️ **Important:** If using locally, always run the script from its **own directory**; otherwise dependency sourcing will fail.

---

### 🟢 **Option 1: Run Directly from GitHub (Online)**
Automatically downloads and runs the latest stable scripts:
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutil.sh)
```
- All required scripts will be fetched and sourced automatically.
- No cloning required.
- Ideal for quick setups or testing.

---

### 🟡 **Option 2: Run Locally (Cloned Repository)**
Use this if you cloned the repo and want offline/local execution:
```
git clone https://github.com/corechunk/linutils.git
cd linutils
bash linutil.sh local
```
- The `local` argument tells the script to source dependencies from the local directory instead of downloading them.
- **Must** be run from the repo root directory (`linutils/`), otherwise dependencies like `base.sh`, `essential.sh`, etc., won't be found.

---

### 🧪 **Beta Version**
For testing the latest features and improvements:
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutilBETA.sh)
```
> Works the same way as above (`local` argument supported if cloned).

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
