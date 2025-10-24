
; ----------------------------------------------------------------------------- ;
;										;
;	Disassembly of R11A from Sonic CD					;
;										;
;	Created by Ralakimus							;
;	Special thanks to flamewing and TheStoneBanana for extensive help	;
;										;
;	File 		constants.asm						;
;	Contents 	Mega Drive constants					;
;										;
; ----------------------------------------------------------------------------- ;

; -------------------------------------------------------------------------------
; ROM (Mega Drive)
; -------------------------------------------------------------------------------

ROM_START		EQU	$000000			; ROM start
ROM_END			EQU	$400000			; ROM end

; -------------------------------------------------------------------------------
; SRAM (Mega Drive)
; -------------------------------------------------------------------------------

SRAM_START		EQU	$200000			; SRAM start
SRAM_ENABLE		EQU	$A130F1			; SRAM enable port

; -------------------------------------------------------------------------------
; Z80
; -------------------------------------------------------------------------------

Z80_RAM			EQU	$A00000			; Z80 RAM start
z80_ram         equ Z80_RAM
Z80_END			EQU	$A02000			; Z80 RAM end
Z80_BUS			EQU	$A11100			; Z80 bus request
z80_bus_request equ Z80_BUS
Z80_RESET		EQU	$A11200			; Z80 reset
z80_reset       equ Z80_RESET

; -------------------------------------------------------------------------------
; Work RAM
; -------------------------------------------------------------------------------

RAM_START		EQU	$FF0000			; Work RAM start
RAM_END			EQU	$1000000		; Work RAM end

; -------------------------------------------------------------------------------
; Sound
; -------------------------------------------------------------------------------

YM_ADDR_0		EQU	$A04000			; YM2612 address port 0
YM_DATA_0		EQU	$A04001			; YM2612 data port 0
YM_ADDR_1		EQU	$A04002			; YM2612 address port 1
YM_DATA_1		EQU	$A04003			; YM2612 data port 1
PSG_CTRL		EQU	$C00011			; PSG control port

; -------------------------------------------------------------------------------
; VDP
; -------------------------------------------------------------------------------

VDP_DATA		EQU	$C00000			; VDP data port
vdp_data_port   equ VDP_DATA
VDP_CTRL		EQU	$C00004			; VDP control port
VDPCTRL         equ VDP_CTRL
vdp_control_port equ VDP_CTRL
VDP_HV			EQU	$C00008			; VDP H/V counter
VDP_DEBUG		EQU	$C0001C			; VDP debug register
VRAMWRITE	EQU	$40000000		; VRAM write
vram_write equ VRAMWRITE

; -------------------------------------------------------------------------------
; I/O
; -------------------------------------------------------------------------------

HW_VERSION		EQU	$A10001			; Hardware version
IO_A_DATA		EQU	$A10003			; I/O port A data port
IO_B_DATA		EQU	$A10005			; I/O port B data port
IO_C_DATA		EQU	$A10007			; I/O port C data port
IO_A_CTRL		EQU	$A10009			; I/O port A control port
IO_B_CTRL		EQU	$A1000B			; I/O port B control port
IO_C_CTRL		EQU	$A1000D			; I/O port C control port

; -------------------------------------------------------------------------------
; TMSS (Mega Drive)
; -------------------------------------------------------------------------------

TMSS_SEGA		EQU	$A14000			; TMSS "SEGA" register
TMSS_MODE		EQU	$A14100			; TMSS bus mode

; -------------------------------------------------------------------------------
; CD memory map (Mega CD)
; -------------------------------------------------------------------------------

CD_START		EQU	$000000			; CD memory start
WORDRAM_2M		EQU	CD_START+$200000	; Word RAM start in 2M mode
WORDRAM_1M		EQU	CD_START+$200000	; Word RAM start in 1M mode
CELL_IMAGE		EQU	WORDRAM_1M+$20000	; Bitmap to cell conversion buffer
PRG_RAM			EQU	CD_START+$20000		; PRG-RAM bank start
SP_START		EQU	PRG_RAM+$6000		; Sub CPU program start in PRG-RAM bank
IP_START		EQU	RAM_START		; Initial program start

; -------------------------------------------------------------------------------
; System RAM assignments (Mega CD)
; -------------------------------------------------------------------------------

_EXCPT			EQU	$FFFFFD00		; Exception
_LEVEL6			EQU	$FFFFFD06		; V-INT
_LEVEL4			EQU	$FFFFFD0C		; H-INT
_LEVEL2			EQU	$FFFFFD12		; EXT-INT
_TRAP00			EQU	$FFFFFD18		; TRAP #00
_TRAP01			EQU	$FFFFFD1E		; TRAP #01
_TRAP02			EQU	$FFFFFD24		; TRAP #02
_TRAP03			EQU	$FFFFFD2A		; TRAP #03
_TRAP04			EQU	$FFFFFD30		; TRAP #04
_TRAP05			EQU	$FFFFFD36		; TRAP #05
_TRAP06			EQU	$FFFFFD3C		; TRAP #06
_TRAP07			EQU	$FFFFFD42		; TRAP #07
_TRAP08			EQU	$FFFFFD48		; TRAP #08
_TRAP09			EQU	$FFFFFD4E		; TRAP #09
_TRAP10			EQU	$FFFFFD54		; TRAP #10
_TRAP11			EQU	$FFFFFD5A		; TRAP #11
_TRAP12			EQU	$FFFFFD60		; TRAP #12
_TRAP13			EQU	$FFFFFD66		; TRAP #13
_TRAP14			EQU	$FFFFFD6C		; TRAP #14
_TRAP15			EQU	$FFFFFD72		; TRAP #15
_CHKERR			EQU	$FFFFFD78		; CHK exception
_ADRERR			EQU	$FFFFFD7E		; Address error
_CODERR			EQU	$FFFFFD7E		; Illegal instruction
_DIVERR			EQU	$FFFFFD84		; Division by zero
_TRPERR			EQU	$FFFFFD8A		; TRAPV
_NOCOD0			EQU	$FFFFFD90		; Line A emulator
_NOCOD1			EQU	$FFFFFD96		; Line F emulator
_SPVERR			EQU	$FFFFFD9C		; Privilege violation
_TRACE			EQU	$FFFFFDA2		; TRACE exception

; -------------------------------------------------------------------------------
; Gate array
; -------------------------------------------------------------------------------

GA_BASE			EQU	$A12000			; Gate array base
GA_RESET		EQU	GA_BASE+$0000		; Peripheral reset
GA_MEM_MODE		EQU	GA_BASE+$0002		; Memory mode/Write protection
GA_CDC_MODE		EQU	GA_BASE+$0004		; CDC mode/Device destination
GA_HINT			EQU	GA_BASE+$0006		; H-INT address
GA_CDC_HOST		EQU	GA_BASE+$0008		; 16 bit CDC data to host
GA_STOPWATCH		EQU	GA_BASE+$000C		; CDC/gp timer 30.72us LSB
GA_COM_FLAGS		EQU	GA_BASE+$000E		; Communication flags
GA_MAIN_FLAG		EQU	GA_BASE+$000E		; Main CPU communication flag
GA_SUB_FLAG		EQU	GA_BASE+$000F		; Sub CPU communication flag
GA_CMDS			EQU	GA_BASE+$0010		; Communication commands
GA_CMD_0		EQU	GA_BASE+$0010		; Communication command 0
GA_CMD_2		EQU	GA_BASE+$0012		; Communication command 2
GA_CMD_4		EQU	GA_BASE+$0014		; Communication command 4
GA_CMD_6		EQU	GA_BASE+$0016		; Communication command 6
GA_CMD_8		EQU	GA_BASE+$0018		; Communication command 8
GA_CMD_A		EQU	GA_BASE+$001A		; Communication command A
GA_CMD_C		EQU	GA_BASE+$001C		; Communication command C
GA_CMD_E		EQU	GA_BASE+$001E		; Communication command E
GA_STATS		EQU	GA_BASE+$0020		; Communication statuses
GA_STAT_0		EQU	GA_BASE+$0020		; Communication status 0
GA_STAT_2		EQU	GA_BASE+$0022		; Communication status 2
GA_STAT_4		EQU	GA_BASE+$0024		; Communication status 4
GA_STAT_6		EQU	GA_BASE+$0026		; Communication status 6
GA_STAT_8		EQU	GA_BASE+$0028		; Communication status 8
GA_STAT_A		EQU	GA_BASE+$002A		; Communication status A
GA_STAT_C		EQU	GA_BASE+$002C		; Communication status C
GA_STAT_E		EQU	GA_BASE+$002E		; Communication status E

; -------------------------------------------------------------------------------

; Game modes
id_Level:	equ ptr_GM_Level-GameModes	
id_SoundTest: equ ptr_GM_ST-GameModes	
id_Sega:	equ ptr_GM_Sega-GameModes	
id_Title:	equ ptr_GM_Title-GameModes	

id_Demo:	equ ptr_GM_Demo-GameModes	
id_Special:	equ ptr_GM_Special-GameModes
id_Continue:equ ptr_GM_Cont-GameModes	
id_Ending:	equ ptr_GM_Ending-GameModes	
id_Credits:	equ ptr_GM_Credits-GameModes

id_GHZ:		equ 0
id_LZ:		equ 1
id_MZ:		equ 2
id_SLZ:		equ 3
id_SYZ:		equ 4
id_SBZ:		equ 5
id_EndZ:	equ 6
id_ST:		equ 7

; PLC Id's
PLCID_PPZ:	        equ ptr_PPZ-PLCIndex	
PLCID_PPZ_Past:     equ ptr_PPZ_Past-PLCIndex	
PLCID_PPZ_Future:	equ ptr_PPZ_Future-PLCIndex	
PLCID_PPZ_GFuture:	equ ptr_PPZ_GFuture-PLCIndex	

; Title Screen
ArtTile_Title_Foreground:	equ $000
ArtTile_Title_Sonic:		equ $300
ArtTile_Title_Trademark:	equ $510
ArtTile_Level_Select_Font:	equ $680

; VRAM Reserved regions, Title screen.
VRAM_TtlScr_Plane_A_Name_Table           equ $C000	; Extends until $CFFF
VRAM_TtlScr_Plane_B_Name_Table           equ $E000	; Extends until $EFFF

ArtTile_Banner equ $20C0
ArtTile_Menu equ $2F80

button_up:			EQU	0
button_down:			EQU	1
button_left:			EQU	2
button_right:			EQU	3
button_B:			EQU	4
button_C:			EQU	5
button_A:			EQU	6
button_start:			EQU	7
; Buttons masks (1 << x == pow(2, x))
button_up_mask:			EQU	1<<button_up	; $01
button_down_mask:		EQU	1<<button_down	; $02
button_left_mask:		EQU	1<<button_left	; $04
button_right_mask:		EQU	1<<button_right	; $08
button_B_mask:			EQU	1<<button_B	; $10
button_C_mask:			EQU	1<<button_C	; $20
button_A_mask:			EQU	1<<button_A	; $40
button_start_mask:		EQU	1<<button_start	; $80

bgm_S3Boss equ $94
;bgm_SCDBoss equ $8C
bgm_SSZP equ $95
sfx_explosion equ $C4
sfx_bumper equ $CC