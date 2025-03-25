# LiveCut

> **Fork 정보**: 이 프로젝트는 [eventual-recluse/LiveCut](https://github.com/eventual-recluse/LiveCut)의 포크로, 자동화된 설치 스크립트를 추가하여 Windows 및 macOS 사용자가 더 쉽게 플러그인을 설치할 수 있도록 개선했습니다.

A version of the [Livecut](https://github.com/mdsp/Livecut) beat-slicer audio plugin adapted for the [DISTRHO Plugin Framework](https://github.com/DISTRHO/DPF)

LiveCut uses [Dear ImGui](https://github.com/ocornut/imgui) for the GUI.

![LiveCut](https://raw.githubusercontent.com/eventual-recluse/LiveCut/master/plugins/LiveCut/LiveCut_Screenshot.png "LiveCut")<br/>

# 주요 개선 사항

이 포크 프로젝트에서는 원본 LiveCut 저장소에 다음 개선 사항을 추가했습니다:

1. **macOS 자동 설치 스크립트**: 코드 서명, 격리 플래그 제거 등 macOS 특유의 보안 제한 우회를 자동화
2. **Windows 자동 설치 스크립트**: Windows 환경에서 표준 플러그인 디렉토리에 자동 설치 지원

자세한 설치 방법은 아래 설명을 참조하세요.

# Build instructions

LV2, VST2, VST3 and CLAP plugins, and a JACK standalone app are built by default. Delete the relevant lines beginning with TARGETS += from the Makefile in plugins/LiveCut if you don't want to build them all.

## Build Instructions: Ubuntu
Install dependencies, clone this repository, enter the cloned repository, then make.
```
sudo apt-get install build-essential git pkg-config freeglut3-dev
git clone --recursive https://github.com/unohee/LiveCut.git
cd LiveCut
make
```
After building, the plugins can be found in the 'bin' folder.

## Build Instructions: Windows 10 64-bit.
LiveCut can be built using [msys2](https://www.msys2.org/)
After installing msys2, launch the MinGW64 shell and enter the following commands to install dependencies, clone this repository, enter the cloned repository, then make.
```
pacman -S base-devel git mingw-w64-x86_64-gcc mingw-w64-x86_64-freeglut
git clone --recursive https://github.com/unohee/LiveCut.git
cd LiveCut
make -f Makefile-windows
```
After building, the plugins can be found in the 'bin' folder.

### Automated Installation on Windows
For Windows users, an automated installation script is provided that will build and install the plugins to the standard plugin directories:

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

After installation, restart your DAW or rescan plugins to detect the newly installed LiveCut plugins.

## Building on macOS.
It should be possible to build on macOS using the Xcode Command Line Tools.

Install Xcode Command Line Tools from the Terminal:
```
xcode-select --install
```
Then enter the following commands in the Terminal to clone this repository, enter the cloned repository, then make.
```
git clone --recursive https://github.com/unohee/LiveCut.git
cd LiveCut
make
```
After building, the plugins can be found in the 'bin' folder.

### Automated Installation on macOS
For macOS users, an automated installation script is provided that will build and install the plugins to the correct locations. This script also handles code signing and security settings to improve compatibility with macOS DAWs (like Ableton Live).

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

# Credits
[Livecut](https://github.com/mdsp/Livecut) by mdsp @ smartelectronix. Livecut Copyright 2004 by Remy Muller. GPL license.

[DISTRHO Plugin Framework.](https://github.com/DISTRHO/DPF) ISC license.

[Dear ImGui.](https://github.com/ocornut/imgui) MIT license.

[Bruno Ace Font](https://fonts.google.com/specimen/Bruno+Ace) designed by Astigmatic. [Open Font License.](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

[Bruno Ace SC Font](https://fonts.google.com/specimen/Bruno+Ace+SC) designed by Astigmatic. [Open Font License.](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)

# Livecut

Livecut is based on BBCut, the BreakBeat Cutting library written by Nick Collins for SuperCollider.

The BBCut Library began out of work on an algorithm to simulate the automatic cutting of breakbeats in the style of early jungle or drum and bass, Nick Collins.

Livecut is only a small subset of what is possible with BBCut, but as it is available as a VST plugin, it is much easier to start experimenting with it.

It is a live beat-slicer but instead of manipulating equal chunks of audio like most beatslicer do, it works on the notion of audio *cuts* whose length and number of repetition depends on the context and the cutting procedure. 
*Cuts* are organized in *blocks* which then form a *phrase*. see Image below. And each phrase can be ended by a *roll* or *fill*.
