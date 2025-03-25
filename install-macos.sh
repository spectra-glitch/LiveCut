#!/bin/bash

# LiveCut macOS Build and Install Script
# Author: 

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions: Output messages
print_msg() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function: Create directory
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_msg "Created directory $1."
    else
        print_msg "Directory $1 already exists."
    fi
}

# Function: Install VST plugin
install_plugin() {
    local src="$1"
    local dest="$2"
    
    if [ -d "$src" ]; then
        rm -rf "$dest" 2>/dev/null
        cp -r "$src" "$dest"
        print_msg "Copied $(basename "$src") to $dest."
        
        # Code signing
        codesign --force --deep --sign - "$dest" 2>/dev/null
        print_success "Code signed $(basename "$dest")."
        
        # Remove quarantine flag
        xattr -d com.apple.quarantine "$dest" 2>/dev/null
        print_msg "Removed quarantine flag from $(basename "$dest")."
    else
        print_error "Plugin $src does not exist."
        return 1
    fi
    
    return 0
}

# Start main script
print_msg "Starting LiveCut plugin build and install script."

# Check current directory
if [ ! -f "Makefile" ] || [ ! -d "plugins/LiveCut" ]; then
    print_error "Please run this script from the LiveCut repository root directory."
    exit 1
fi

# Start building
print_msg "Building LiveCut plugins..."
make clean && make
if [ $? -ne 0 ]; then
    print_error "Build failed. Please check for errors."
    exit 1
fi
print_success "Build completed successfully."

# Create plugin folders
VST2_DIR="$HOME/Library/Audio/Plug-Ins/VST"
VST3_DIR="$HOME/Library/Audio/Plug-Ins/VST3"
CLAP_DIR="$HOME/Library/Audio/Plug-Ins/CLAP"
LV2_DIR="$HOME/Library/Audio/Plug-Ins/LV2"

create_dir "$VST2_DIR"
create_dir "$VST3_DIR"
create_dir "$CLAP_DIR"
create_dir "$LV2_DIR"

# Start plugin installation
print_msg "Starting plugin installation..."

# Install VST2 plugin
VST2_SRC="bin/LiveCut.vst"
VST2_DEST="$VST2_DIR/LiveCut.vst"
install_plugin "$VST2_SRC" "$VST2_DEST"
vst2_result=$?

# Install VST3 plugin
VST3_SRC="bin/LiveCut.vst3"
VST3_DEST="$VST3_DIR/LiveCut.vst3"
install_plugin "$VST3_SRC" "$VST3_DEST"
vst3_result=$?

# Install CLAP plugin
CLAP_SRC="bin/LiveCut.clap"
CLAP_DEST="$CLAP_DIR/LiveCut.clap"
install_plugin "$CLAP_SRC" "$CLAP_DEST"
clap_result=$?

# Install LV2 plugin
LV2_SRC="bin/LiveCut.lv2"
LV2_DEST="$LV2_DIR/LiveCut.lv2"
if [ -d "$LV2_SRC" ]; then
    rm -rf "$LV2_DEST" 2>/dev/null
    cp -r "$LV2_SRC" "$LV2_DEST"
    print_msg "Copied LiveCut.lv2 to $LV2_DIR."
    print_success "LV2 plugin installation completed."
    lv2_result=0
else
    print_error "LV2 plugin does not exist."
    lv2_result=1
fi

# Installation summary
echo ""
print_msg "====== Installation Summary ======"
[ $vst2_result -eq 0 ] && print_success "VST2: Installation completed ($VST2_DEST)" || print_error "VST2: Installation failed"
[ $vst3_result -eq 0 ] && print_success "VST3: Installation completed ($VST3_DEST)" || print_error "VST3: Installation failed"
[ $clap_result -eq 0 ] && print_success "CLAP: Installation completed ($CLAP_DEST)" || print_error "CLAP: Installation failed"
[ $lv2_result -eq 0 ] && print_success "LV2: Installation completed ($LV2_DEST)" || print_error "LV2: Installation failed"

echo ""
print_msg "===== DAW Rescan Required ====="
print_warning "Please restart your DAW or run plugin rescan to recognize the newly installed plugins."
print_warning "Some DAWs (especially Ableton Live) may require security settings changes to recognize VST2 plugins."

echo ""
print_success "Plugin installation script completed successfully!" 