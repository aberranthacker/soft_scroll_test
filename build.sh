#!/bin/sh
rm -f *.LST
rm -f *.OBJ
rm -f *.LDA
rm -f *.SAV
rm -f *.BIN
rm -f *.MAP
rm -f *.MM

RT11EMU="Z:\home\random\retrodev\tools\RT-11 Emulator\rt11.exe"
#-------------------------------------------------------------------------------
echo "Compiling SRAM.MAC ..."
wine cmd.exe /c "$RT11EMU" MACRO SRAM.MAC+SYSMAC.SML/LIBRARY 2>/dev/null
echo "Linking SRAM.OBJ ..."
wine cmd.exe /c "$RT11EMU" LINK SRAM /MAP:SRAM.MAP 2>/dev/null
if [ -f SRAM.MAP ]; then
   cat SRAM.MAP
fi

printf "\n"
ruby pluck.rb -i SRAM.SAV -o SRAM.BIN -m SRAM.MAP
rm SRAM.SAV
printf "\n"
#-------------------------------------------------------------------------------
echo "Compiling SR2DRM.MAC ..."
wine cmd.exe /c "$RT11EMU" MACRO SR2DRM.MAC+SYSMAC.SML/LIBRARY 2>/dev/null
echo "Linking SR2DRM.OBJ ..."
wine cmd.exe /c "$RT11EMU" LINK SR2DRM /MAP:SR2DRM.MAP 2>/dev/null
if [ -f SR2DRM.MAP ]; then
   cat SR2DRM.MAP
fi

printf "\n"
ruby pluck.rb -i SR2DRM.SAV -o SR2DRM.BIN -m SR2DRM.MAP
rm SR2DRM.SAV
printf "\n"
#-------------------------------------------------------------------------------
echo "Compiling SR2SR.MAC ..."
wine cmd.exe /c "$RT11EMU" MACRO SR2SR.MAC+SYSMAC.SML/LIBRARY 2>/dev/null
echo "Linking SR2SR.OBJ ..."
wine cmd.exe /c "$RT11EMU" LINK SR2SR /MAP:SR2SR.MAP 2>/dev/null
if [ -f SR2SR.MAP ]; then
   cat SR2SR.MAP
fi

printf "\n"
ruby pluck.rb -i SR2SR.SAV -o SR2SR.BIN -m SR2SR.MAP
rm SR2SR.SAV
printf "\n"
#-------------------------------------------------------------------------------

echo "Compiling MAIN.MAC ..."
wine cmd.exe /c "$RT11EMU" MACRO MAIN.MAC+SYSMAC.SML/LIBRARY 2>/dev/null
echo "Linking MAIN.OBJ ..."
wine cmd.exe /c "$RT11EMU" LINK MAIN /MAP:MAIN.MAP 2>/dev/null
if [ -f MAIN.MAP ]; then
   cat MAIN.MAP
fi
#-------------------------------------------------------------------------------
rm -f *.LST
rm -f *.MAP
rm -f *.OBJ
rm -f *.MM
