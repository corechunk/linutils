# linutil
## Stable Usage
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutil.sh)
```
## Beta Usage
```
bash <(curl -fsSL https://raw.githubusercontent.com/corechunk/linutils/main/linutilBETA.sh)
```

.

.

.
## Development Related

### current issues
- the option `00. edit apt source` is not arch compatible
- the option `01. Download Desktop Environment (via tasksel)` is not arch compatible
- ufw and fail2ban checking if they exists and showing is unstable/broken inside option `2. Enable firewall (via ufw & fail2ban)`

### future development ideas
- adding an option to source dependencies locally if cloned from github
- tasksel type system for arch manuall


for my futureself [dev note] yazi's repo as its not added in apt [third party repo]
```
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
```
```
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
```
