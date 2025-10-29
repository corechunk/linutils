# 💻 **linutils — A Linux Setup Automation Script**

A modular Linux setup utility that automatically fetches, sources, and runs configuration scripts for essential tools, development environments, and system optimizations.  
Works on **Debian/Ubuntu-based** systems and partially on **Arch-based** systems (under development).

---

## 🚀 **Usage**

### ✅ **Stable Version**
For a stable and reliable experience:
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutil.sh)
```

### 🧪 **Beta Version**
For testing the latest features and improvements:
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutilBETA.sh)
```

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

## 🛠️ **Package Groups**

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
- `xdg-utils`

---

### 🌐 **Network & Security Tools**
Network management, firewall, and system security.
- `wget`
- `net-tools`
- `nmap`
- `iwd`
- `ufw`
- `fail2ban`

---

### 🧭 **GitHub Projects**
Third-party tools automatically cloned and installed:
- `oh-my-posh`  
- `auto-cpufreq`

---

## 🧠 **Development Notes**

### ⚠️ **Current Issues**
- Option **`00. edit apt source`** — not yet Arch compatible.  
- Option **`01. Download Desktop Environment (via tasksel)`** — not yet Arch compatible.  
- **Firewall check (UFW + Fail2Ban)** — detection is unstable/broken on some setups.

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