# some functions/variable called here maybe on other file
# and they are need to be sourced in order to run properly

# Detect package manager
if [ $package_manager="apt" ]; then
	# Debian/Ubuntu/Sid  [ or debian based ]
	build_essential_pkg="build-essential"
	manpages_pkg="manpages-dev"
	openjdk_pkg="openjdk-25-jdk"
elif [ $package_manager="pacman" ]; then
	# Arch [ or arch based ]
	build_essential_pkg="base-devel"
	manpages_pkg="man-pages"
	openjdk_pkg="jdk-openjdk"
else
	echo "Unsupported distro"
	exit 1
fi

shrink() {
	local src="$1"   # name of source array
	local dest="$2"  # name of destination array

	# make src a nameref (reference to original array)
	declare -n src_ref="$src"
	declare -n dest_ref="$dest"

	dest_ref=()  # clear destination array

	#echo ""
	for ((i=0; i<${#src_ref[@]}; i+=3)); do
		pkg="${src_ref[i]}"
		[[ $pkg == *#* ]] && continue   # skip headers
		dest_ref+=("$pkg")
		#echo "$pkg"
	done
}


