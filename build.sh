#!/bin/sh
rm -f *.LST
rm -f *.OBJ
rm -f *.LDA
rm -f *.SAV
rm -f *.BIN
rm -f *.MAP

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
printf "\n"
#-------------------------------------------------------------------------------
echo "Compiling PCSRAM.MAC ..."
wine cmd.exe /c "$RT11EMU" MACRO PCSRAM.MAC+SYSMAC.SML/LIBRARY 2>/dev/null
echo "Linking PCSRAM.OBJ ..."
wine cmd.exe /c "$RT11EMU" LINK PCSRAM /MAP:PCSRAM.MAP 2>/dev/null
if [ -f PCSRAM.MAP ]; then
   cat PCSRAM.MAP
fi

printf "\n"
ruby pluck.rb -i PCSRAM.SAV -o PCSRAM.BIN -m PCSRAM.MAP
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
