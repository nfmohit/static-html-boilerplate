#!/bin/bash

# Exit if any command fails
set -e

# Change to the expected directory
cd "$( dirname "$0" )"
cd ..

# Command Colors
BLUE_BOLD='\033[1;34m';
GREEN_BOLD='\033[1;32m';
RED_BOLD='\033[1;31m';
YELLOW_BOLD='\033[1;33m';
COLOR_RESET='\033[0m';

error () {
	echo -e "\n${RED_BOLD}$1${COLOR_RESET}\n"
}
status () {
	echo -e "\n${BLUE_BOLD}$1${COLOR_RESET}\n"
}
success () {
	echo -e "\n${GREEN_BOLD}$1${COLOR_RESET}\n"
}
warning () {
	echo -e "\n${YELLOW_BOLD}$1${COLOR_RESET}\n"
}

status "Initializing archive process"

# Run the build

status "Installing dependencies"
sudo npm install
status "Generating build"
npm run build

built_files=$( ls assets/dist/*/*.{js,css} )

# Generate the archive zip file
status "Creating archive"
zip -r static-html-boilerplate.zip \
	index.html \
	assets/images/* \
	assets/fonts/* \
	$built_files \

success "Done. Archive has been built successfully!"