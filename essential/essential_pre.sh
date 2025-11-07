# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

# Detect package manager
if [[ $(package_manager) == "apt" ]]; then
	# Debian/Ubuntu/Sid  [ or debian based ]
	build_essential_pkg="build-essential"
	manpages_pkg="manpages-dev"
	openjdk_pkg="openjdk-25-jdk"
    ninja_pkg="ninja-build"
elif [[ $(package_manager) == "pacman" ]]; then
	# Arch [ or arch based ]
	build_essential_pkg="base-devel"
	manpages_pkg="man-pages"
	openjdk_pkg="jdk-openjdk"
    ninja_pkg="ninja"
else
	echo "Unsupported distro"
	exit 1
fi

## shrink function was here


