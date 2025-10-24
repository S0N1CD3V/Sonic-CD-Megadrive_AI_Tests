#!/bin/bash

# --- Full Build Script for macOS using Wine ---
# This script attempts to compile the Z80 sound driver.

# Stop on first error
set -e

clear

# Check if Wine is installed
if ! command -v wine &> /dev/null
then
    echo "*****************************************************************"
    echo "* ERROR: Wine is not installed or not found in your PATH.       *"
    echo "* Please install it to run the Windows build tools.             *"
    echo "* The easiest way is to use Homebrew: brew install wine-stable  *"
    echo "*****************************************************************"
    exit 1
fi

echo "--- Assembling Z80 Sound Driver ---"
wine "_Assembly Tools/AS/asl.exe" -q -cpu Z80 -gnuerrors -c -A -L -xx "Z80.asm"

echo "--- Converting Z80 binary ---"
wine "_Assembly Tools/AS/p2bin.exe" "Z80.p" "Dual PCM/Z80.bin" -r 0x-0x

echo "--- Generating 68k Equates for Z80 ---"
wine "_Assembly Tools/ListEqu.exe" AS z80 "Z80.lst" asm68k 68k "Equz80.asm"

echo ""
echo "--- Assembling 68k Main Program ---"
wine "_Assembly Tools/Asm68k.exe" /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /q /p /o ae- /o l. r11a.asm, SCDmd.bin, r11a.sym, r11a.lst

echo ""
echo "--- Generating Symbols ---"
wine convsym.exe r11a.sym SCDmd.bin -a

echo ""
echo "--- Cleaning up intermediate files ---"
rm -f Z80.lst Z80.p Z80.h

echo ""
echo "************************"
echo "* Build Succeeded!     *"
echo "* ROM is SCDmd.bin     *"
echo "************************"