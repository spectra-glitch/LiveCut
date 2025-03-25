# LiveCut - Enhanced Installation Scripts

> **Fork Information**: This is a fork of [eventual-recluse/LiveCut](https://github.com/eventual-recluse/LiveCut) with added automated installation scripts for Windows and macOS.

This fork focuses on improving the installation experience while maintaining all the functionality of the original LiveCut plugin. For detailed information about the plugin itself, please refer to the [original repository](https://github.com/eventual-recluse/LiveCut).

![LiveCut](https://raw.githubusercontent.com/eventual-recluse/LiveCut/master/plugins/LiveCut/LiveCut_Screenshot.png "LiveCut")<br/>

## Added Features

This fork adds the following improvements to the original LiveCut repository:

1. **macOS Automated Installation Script**: Automates code signing, quarantine flag removal, and other macOS-specific security restriction bypasses
2. **Windows Automated Installation Script**: Supports automatic installation to standard plugin directories on Windows

## Quick Installation Guide

### Windows Installation

```
git clone --recursive https://github.com/unohee/LiveCut.git
cd LiveCut
mingw32-make -f Makefile-windows install-windows
```

The script will:
1. Build all plugin formats (VST2, VST3, CLAP, LV2)
2. Create necessary plugin directories if they don't exist
3. Copy plugins to the standard Windows plugin directories:
   - VST2: %USERPROFILE%\Documents\VST Plugins
   - VST3: %COMMONPROGRAMFILES%\VST3
   - CLAP: %COMMONPROGRAMFILES%\CLAP
   - LV2: %USERPROFILE%\Documents\LV2

### macOS Installation

```
git clone --recursive https://github.com/unohee/LiveCut.git
cd LiveCut
make install-macos
```

The script will:
1. Build all plugin formats (VST2, VST3, CLAP, LV2)
2. Create necessary plugin directories if they don't exist
3. Copy plugins to the standard macOS plugin directories
4. Apply ad-hoc code signatures to the plugins
5. Remove quarantine flags to prevent Gatekeeper blocks

After installation, restart your DAW or rescan plugins to detect the newly installed LiveCut plugins.

## For More Information

For build instructions for specific platforms, plugin details, and general information about the LiveCut plugin, please refer to the [original repository README](https://github.com/eventual-recluse/LiveCut).

## Credits

This project builds upon the work of several open source projects:

- [Livecut](https://github.com/mdsp/Livecut) by mdsp @ smartelectronix (GPL license)
- [DISTRHO Plugin Framework](https://github.com/DISTRHO/DPF) (ISC license)
- [Dear ImGui](https://github.com/ocornut/imgui) (MIT license)
- [Bruno Ace Font](https://fonts.google.com/specimen/Bruno+Ace) and [Bruno Ace SC Font](https://fonts.google.com/specimen/Bruno+Ace+SC) by Astigmatic ([Open Font License](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL))
