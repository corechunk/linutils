clear
# Set some colors for output messages 
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"
log_start="$GREEN ----------$BLUE  ----------$RESET"
log_end="$BLUE ----------$GREEN  ----------$RESET"
divider="$BLUE ----------$GREEN  ----------$BLUE ----------$GREEN  ----------$RESET"

echo "loading data from online ..."

# these are loaded from the same repo that contained this script itself
# https://github.com/corechunk/linutils
# inside this link you will find all of these scripts that are sourced bellow

#src(){}

main="https://raw.githubusercontent.com/corechunk/linutils/main"
dep=(
    base.sh
    apt-source.sh
    essential.sh
    auto-cpufreq.sh
    security.sh
)

for depp in "${dep[@]}";do
    source <(curl -fsSL "$main/$depp")
done

for pkg in "${dev_cli[@]}";do
    install_pkg_dynamic $pkg install-force
    #echo $pkg;
done