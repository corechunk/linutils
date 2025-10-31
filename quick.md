
### ⚡ Quickstart

**Step 1: Choose execution mode**

| Mode   | Command | Notes |
|--------|---------|-------|
| Online | ```bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutil.sh)``` | Auto-downloads and sources scripts |
| Local  | ```bash linutil.sh local``` | Must run from repo root directory (`linutils/`) |

**Step 2: Follow the interactive menu**

- Edit APT sources (`00`)
- Install Desktop Environment via tasksel (`01`)  
- Install essential CLI/GUI/Developer tools (`1`)  
- Enable firewall (UFW + Fail2Ban) (`2`)  
- Enable battery optimization (auto-cpufreq) (`3`)  
- Dotfiles & wallpapers (`4`)  
- Exit (`x`)

**Step 3: Optional Beta Testing [ broken right now ]**

```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutilBETA.sh)
```
- Provides latest features for testing  
- Same menu functionality as stable version

**Tip:** Use **local mode** for offline installation, reproducible setups, or if you cloned the repo manually.

---