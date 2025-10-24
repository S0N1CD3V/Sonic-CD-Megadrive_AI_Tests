@Echo Off
"_Assembly Tools\AS\asl.exe" -q -cpu Z80 -gnuerrors -c -A -L -xx "Z80.asm"
"_Assembly Tools\AS\p2bin.exe" "Z80.p" "Dual PCM\Z80.bin" -r 0x-0x

"_Assembly Tools\ListEqu.exe" AS z80 "Z80.lst" asm68k 68k "Equz80.asm"

IF NOT EXIST "Z80.p" goto Error
CLS
DEL "Z80.lst"
DEL "Z80.p"
DEL "Z80.h"

"_Assembly Tools\Asm68k.exe" /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /q /p /o ae- /o l. r11a.asm, SCDmd.bin, r11a.sym, r11a.lst
convsym.exe r11a.sym SCDmd.bin -a



if "%1"=="1" goto Finish

:Error
pause

:Finish