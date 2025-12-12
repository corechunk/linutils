SHELL := /usr/bin/env bash

# Define the name of the combined script
TARGET_SCRIPT := linutils

# List all dependency files in the correct order for concatenation
DEPENDENCY_FILES := \
    base/base.sh \
	base/ascii.sh \
    base/pkg_mng_debian.sh \
    base/pkg_mng_ubuntu.sh \
    base/pkg_mng_arch.sh \
    base/pkg_mng_fedora.sh \
    base/pkg_mng_util.sh \
    tasksel_custom/tasksel_custom.sh \
    essential/github_pkgs/auto-cpufreq.sh \
    essential/github_pkgs/gh_pkg_rofi_patched.sh \
    essential/github_pkgs/gh_pkgs_menu.sh \
    essential/essential_pre.sh \
    essential/essential_pre_pkgs.sh \
    essential/essential_pre_info.sh \
    essential/essential.sh \
    essential/security.sh \
    dotfiles/dotfiles.sh \
	NixOS/main_nixos.sh

# Define installation directory
INSTALL_DIR := /usr/local/bin

.PHONY: all build install clean

all: build install

re-all: clean build install

# Target to clean up generated files
clean:
	@echo "Cleaning up generated files..."
	rm -f $(TARGET_SCRIPT)
	@echo "Clean up complete."
# Target to build the combined script
build: $(TARGET_SCRIPT)

$(TARGET_SCRIPT): linutils.sh $(DEPENDENCY_FILES)
	@echo "Building $(TARGET_SCRIPT)..."
	# Extract the "top part" from linutils.sh (from line 1 up to before 'main="https://...'
	# This includes the original shebang, initial comments, check_sudo, DISTRO_ID detection.
	# The 'main=' line itself is excluded.
	sed -n '1,/^main="https:\/\/raw.githubusercontent.com\/corechunk\/linutils\/main"/ { /^main=/!p }' linutils.sh > $(TARGET_SCRIPT)
	
	# Concatenate all dependency files, ensuring each is followed by a newline
	for file in $(DEPENDENCY_FILES); do \
		cat "$$file" >> $(TARGET_SCRIPT); \
		echo >> $(TARGET_SCRIPT); \
	done
	
	# Extract the "end part" from linutils.sh (from '# ========= Choose Operation Mode =========' to end)
	# This includes mode selection, "All dependencies loaded" message, main_menu, verify_support.
	sed -n '/^                # ========= Choose Operation Mode =========/,/^#core_end/p' linutils.sh >> $(TARGET_SCRIPT)
	
	# Make the combined script executable
	chmod +x $(TARGET_SCRIPT)
	@echo "Successfully built $(TARGET_SCRIPT)"
rebuild: clean build

# Target to install the script
install: build
	@echo "Installing $(TARGET_SCRIPT) to $(INSTALL_DIR)..."
	sudo cp $(TARGET_SCRIPT) $(INSTALL_DIR)/ 
	@echo "Successfully installed $(TARGET_SCRIPT)"


