# linutil
### Stable Usage
```
sh <(curl -L https://raw.githubusercontent.com/corechunk/linutils/main/linutil.sh)
```
### Beta Usage
```
sh <(curl -L https://raw.githubusercontent.com/corechunk/linutils/main/linutilBETA.sh)
```

.

.

.

.

.

.

.

.













for my futureself [dev note] yazi's repo as its not added in apt [third party repo]
```
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
```
```
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
```
