@Echo Off
"_Assembly Tools\AS\asl.exe" -q -cpu Z80 -gnuerrors -c -A -L -xx "Dual PCM\Z80.asm"
"_Assembly Tools\AS\p2bin.exe" "Dual PCM\Z80.p" "Dual PCM\Z80.bin" -r 0x-0x

"_Assembly Tools\ListEqu.exe" AS z80 "Dual PCM\Z80.lst" asm68k 68k "Equz80.asm"
DEL "Dual PCM\Z80.lst"

IF NOT EXIST "Dual PCM\Z80.p" goto Error
CLS
DEL "Dual PCM\Z80.p"
DEL "Dual PCM\Z80.h"

IF EXIST s1built.bin move /Y s1built.bin s1built.prev.bin >NUL
"_Assembly Tools\Asm68k.exe" /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /q /p /o ae- sonic.asm, s1built.bin >errors.txt, sonic.sym, sonic.lst
"_Assembly Tools\CheckFix.exe" "s1built.bin"
convsym sonic.lst s1built.bin -input asm68k_lst -inopt "/localSign=@ /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
fixheadr.exe s1built.bin

:Error
Pause