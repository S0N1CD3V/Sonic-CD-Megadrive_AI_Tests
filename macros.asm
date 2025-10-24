
; ----------------------------------------------------------------------------- ;
;										;
;	Disassembly of R11A from Sonic CD					;
;										;
;	Created by Ralakimus							;
;	Special thanks to flamewing and TheStoneBanana for extensive help	;
;										;
;	File:		macros.asm						;
;	Contents:	Macros							;
;										;
; ----------------------------------------------------------------------------- ;

; -------------------------------------------------------------------------------
; Align
; -------------------------------------------------------------------------------
; PARAMETERS:
;	bound	- Size boundary
;	value	- Value to pad with
; -------------------------------------------------------------------------------

ALIGN macro &
	bound, value

	if narg>1
		dcb.b	((\bound)-((*)%(\bound)))%(\bound), \value
	else
		dcb.b	((\bound)-((*)%(\bound)))%(\bound), 0
	endif

	endm

; ----------------------------------------------------------------------------- ;
; ---------------------------------------------------------------------------
; stop the Z80
; ---------------------------------------------------------------------------

stopZ80_S1:	macro
		move.w	#$0100,($A11100).l			; request Z80 stop (ON)
		btst.b	#$00,($A11100).l			; has the Z80 stopped yet?
		bne.s	*-$08					; if not, branch
		endm

; ---------------------------------------------------------------------------
; wait for Z80 to stop
; ---------------------------------------------------------------------------

waitZ80_S2:	macro
.wait:	btst	#0,(z80_bus_request).l
		bne.s	.wait
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

resetZ80_S1:	macro
		move.w	#$100,(z80_reset).l
		endm

resetZ80a:	macro
		move.w	#0,(z80_reset).l
		endm

; ---------------------------------------------------------------------------
; start the Z80
; ---------------------------------------------------------------------------

startZ80_S1:	macro
		move.w	#0,(z80_bus_request).l
		endm
	; --- DMA to (a6) containing C00004 ---

DMA:		macro	Size, Source, Destination
		move.l	#(((((Size/$02)<<$08)&$FF0000)+((Size/$02)&$FF))+$94009300),(a6)
		move.l	#((((((Source&$FFFFFF)/$02)<<$08)&$FF0000)+(((Source&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#(((((Source&$FFFFFF)/$02)&$7F0000)+$97000000)+((Destination>>$10)&$FFFF)),(a6)
		move.w	#((Destination&$FF7F)|$80),(a6)
		endm

	; --- Storing 68k address for Z80 as dc ---

dcz80		macro	Sample, SampleRev, SampleLoop, SampleLoopRev
		dc.b	((Sample)&$FF)
		dc.b	((((Sample)>>$08)&$7F)|$80)
		dc.b	(((Sample)&$7F8000)>>$0F)
		dc.b	(((SampleRev)-1)&$FF)
		dc.b	(((((SampleRev)-1)>>$08)&$7F)|$80)
		dc.b	((((SampleRev)-1)&$7F8000)>>$0F)
		dc.b	((SampleLoop)&$FF)
		dc.b	((((SampleLoop)>>$08)&$7F)|$80)
		dc.b	(((SampleLoop)&$7F8000)>>$0F)
		dc.b	(((SampleLoopRev)-1)&$FF)
		dc.b	(((((SampleLoopRev)-1)>>$08)&$7F)|$80)
		dc.b	((((SampleLoopRev)-1)&$7F8000)>>$0F)
		endm

	; --- End marker for PCM samples ---

EndMarker	macro
		dcb.b	Z80E_Read*(($1000+$100)/$100),$00
		endm

; ===========================================================================
VDPCMD macro ins, addr, type, rwd, end, end2
	local	cmd
cmd	= (\type\\rwd\)|(((\addr)&$3FFF)<<16)|((\addr)/$4000)
	if narg=5
		\ins	#\#cmd,\end
	elseif narg>=6
		\ins	#(\#cmd)\end,\end2
	else
		\ins	cmd
	endif
	endm

; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is ($C00004).l)
; ---------------------------------------------------------------------------
ifarg:		macros
		if strlen("\1")>0

ifnotarg:	macros
		if strlen("\1")=0
		
vdp_comm:	macro inst,addr,cmdtarget,cmd,dest,adjustment

		command: = (\cmdtarget\_\cmd\)|((\addr&$3FFF)<<16)|((\addr&$C000)>>14)

		ifarg \dest
			\inst\.\0	#command\adjustment\,\dest
		else
			\inst\.\0	command\adjustment\
		endc
		endm