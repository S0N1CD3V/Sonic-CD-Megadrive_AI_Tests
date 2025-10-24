TitleScreen:				; XREF: GameModeArray
		move.b	#$E4,d0
		jsr	PlaySound_Special ; stop music
		jsr	ClearPLC
		jsr	Pal_FadeFrom
		move	#$2700,sr
		jsr	SoundDriverLoad
		lea	(VDP_CTRL).l,a6
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8C00,(a6)		; H res 32 cells, no interlace, S/H enabled
		move.w	#$9001,(a6)
		move.w	#$9200,(a6)
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)
		clr.b	($FFFFF64E).w
		jsr	ClearScreen
		lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1

Title_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,Title_ClrObjRam ; fill object RAM ($D000-$EFFF) with	$0

		move.l	#$40000000,(VDP_CTRL).l
		lea	(Nem_JapNames).l,a0 ; load Japanese credits
		jsr	NemDec
		move.l	#$54C00000,(VDP_CTRL).l
		lea	(Nem_CreditText).l,a0 ;	load alphabet
		jsr	NemDec
		lea	($FF0000).l,a1
		lea	(Eni_JapNames).l,a0 ; load mappings for	Japanese credits
		move.w	#0,d0
		jsr	EniDec
		lea	($FF0000).l,a1
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics
		lea	($FFFFFB80).w,a1
		moveq	#0,d0
		move.w	#$1F,d1

Title_ClrPallet:
		move.l	d0,(a1)+
		dbf	d1,Title_ClrPallet ; fill pallet with 0	(black)

		moveq	#3,d0		; load Sonic's pallet
		jsr	PalLoad1
;		move.b	#$4A,($FFFFD080).w ; load "SONIC TEAM PRESENTS"	object
		jsr	ObjectsLoad
		jsr	BuildSprites
		jsr	Pal_FadeTo
		move	#$2700,sr
		move.l	#$40000001,(VDP_CTRL).l
		lea	(Nem_TitleFg).l,a0 ; load title	screen patterns
		jsr	NemDec
		move.l	#$60000001,(VDP_CTRL).l
		lea	(Nem_TitleSonic).l,a0 ;	load Sonic title screen	patterns
		jsr	NemDec
		vdp_comm.l	move,ArtTile_Banner,vram,write,(vdp_control_port).l
		lea	(Art_Banner).l,a0
	    jsr	NemDec
		
		lea	(VDP_DATA).l,a6
		move.l	#$50000003,4(a6)
		lea	(Art_Text).l,a5
		move.w	#$28F,d1

Title_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Title_LoadText ; load uncompressed text patterns

		move.b	#0,(v_last_checkpoint).l ; clear lamppost counter
		move.w	#0,($FFFFFE08).w ; disable debug item placement	mode
		move.w	#0,($FFFFFFF0).w ; disable debug mode
		move.w	#0,($FFFFFFEA).w ; Unused
		move.w	#0,(v_zone).l ; set level to	GHZ (00)
		move.w	#0,($FFFFF634).w ; disable pallet cycling
		jsr	LevelSizeLoad
;		jsr	DeformBgLayer
		lea	($FFFFB000).w,a1
		lea	(Blk16_GHZ).l,a0 ; load	GHZ 16x16 mappings
		move.w	#0,d0
		jsr	EniDec
		lea	(Blk256_GHZ).l,a0 ; load GHZ 256x256 mappings
		lea	($FF0000).l,a1
		jsr	KosDec
		jsr	LevelLayoutLoad
	    jsr   LoadMenuArt
		jsr	Pal_FadeFrom
		move	#$2700,sr
		jsr	ClearScreen
		lea	(VDP_CTRL).l,a5
		lea	(VDP_DATA).l,a6
		lea	($FFFFF708).w,a3
		lea	($FFFFA440).w,a4
		move.w	#$6000,d2
		jsr	LoadTilesFromStart2

        lea	($FF0000).l,a1
		lea	(Eni_Title).l,a0 ; load	title screen mappings
		move.w	#$200,d0
		jsr	EniDec

		lea	($FF0000).l,a1
		move.l	#$42060003,d0
		moveq	#$1A-1,d1
	    moveq	#$1F-1,d2
		jsr	ShowVDPGraphics
;		move.l	#$40000000,(VDP_CTRL).l
;		lea	(Nem_GHZ_1st).l,a0 ; load GHZ patterns
;		jsr	NemDec
		moveq	#6,d0		; load title screen pallet
		jsr	PalLoad1
    ; Tittle Screen Music Not Here Anymore
		move.b	#0,($FFFFFFFA).w ; disable debug mode
		move.w	#$178,(v_vint_timer).w ; run title	screen for $178	frames
		lea	($FFFFD080).w,a1
		moveq	#0,d0
		move.w	#7,d1

Title_ClrObjRam2:
		move.l	d0,(a1)+
		dbf	d1,Title_ClrObjRam2

		move.b	#$41,(v_player).w ; load big Sonic object
;		move.b	#$F,($FFFFD080).w ; load "PRESS	START BUTTON" object
		move.b	#$41,(v_obj_sonicarm).w 
		move.b  #1,(v_obj_sonicarm+oSubtype)
		move.b	#$41,(v_obj_banner).w 
		move.b  #2,(v_obj_banner+oSubtype)
		move.b	#$4A,(v_obj_titlemenu).w 
;		move.b	#3,($FFFFD0DA).w
;		move.b	#$F,($FFFFD100).w
;		move.b	#2,($FFFFD11A).w
		jsr	ObjectsLoad
;		jsr	DeformBgLayer
		jsr	BuildSprites
;		moveq	#$13,d0
;		jsr	LoadPLC2
		move.w	#0,($FFFFFFE4).w
		move.w	#0,($FFFFFFE6).w
		move.w	($FFFFF60C).w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_CTRL).l
		jsr	Pal_FadeTo

loc_317C:
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
		jsr	ObjectsLoad
;		jsr	DeformBgLayer   
        cmpi.b #1,(v_title_final_state).l
		beq.s  .skip_pal
        jsr	Pal_Title
  .skip_pal:
		jsr	BuildSprites
		jsr	RunPLC_RAM
		move.w	($FFFFD008).w,d0
;		addq.w	#2,d0
;		move.w	d0,($FFFFD008).w ; move	Sonic to the right
		cmpi.w	#$1C00,d0	; has Sonic object passed x-position $1C00?
		bcs.s	Title_ChkRegion	; if not, branch
		move.b	#id_Sega,($FFFFF600).w ; go to Sega screen
		rts	
; ===========================================================================

Title_ChkRegion:
		tst.b	($FFFFFFF8).w	; check	if the machine is US or	Japanese
		bpl.s	Title_RegionJ	; if Japanese, branch
		lea	(LevelSelectCode_US).l,a0 ; load US code
		bra.s	Title_EnterCheat
; ===========================================================================

Title_RegionJ:				; XREF: Title_ChkRegion
		lea	(LevelSelectCode_J).l,a0 ; load	J code

Title_EnterCheat:			; XREF: Title_ChkRegion
		move.w	($FFFFFFE4).w,d0
		adda.w	d0,a0
		move.b	($FFFFF605).w,d0 ; get button press
		andi.b	#$F,d0		; read only up/down/left/right buttons
		cmp.b	(a0),d0		; does button press match the cheat code?
		bne.s	loc_3210	; if not, branch
		addq.w	#1,($FFFFFFE4).w ; next	button press
		tst.b	d0
		bne.s	Title_CountC
		lea	($FFFFFFE0).w,a0
		move.w	($FFFFFFE6).w,d1
		lsr.w	#1,d1
		andi.w	#3,d1
		beq.s	Title_PlayRing
		tst.b	($FFFFFFF8).w
		bpl.s	Title_PlayRing
		moveq	#1,d1
		move.b	d1,1(a0,d1.w)

Title_PlayRing:
		move.b	#1,(a0,d1.w)	; activate cheat
		move.b	#$B5,d0		; play ring sound when code is entered
		jsr	PlaySound_Special
		bra.s	Title_CountC
; ===========================================================================

loc_3210:				; XREF: Title_EnterCheat
		tst.b	d0
		beq.s	Title_CountC
		cmpi.w	#9,($FFFFFFE4).w
		beq.s	Title_CountC
		move.w	#0,($FFFFFFE4).w

Title_CountC:
		move.b	($FFFFF605).w,d0
		andi.b	#$20,d0		; is C button pressed?
		beq.s	loc_3230	; if not, branch
		addq.w	#1,($FFFFFFE6).w ; increment C button counter

loc_3230:
;		tst.w	(v_vint_timer).w
;		beq.w	Demo
		andi.b	#button_start_mask,($FFFFF605).w ; check if Start is pressed
		beq.w	loc_317C	; if not, branch

Title_ChkLevSel:
		tst.b	($FFFFFFE0).w	; check	if level select	code is	on
		beq.w	PlayLevel	; if not, play level
		btst	#6,($FFFFF604).w ; check if A is pressed
		beq.w	PlayLevel	; if not, play level
		moveq	#2,d0
		jsr	PalLoad2	; load level select pallet
		lea	($FFFFCC00).w,a1
		moveq	#0,d0
		move.w	#$DF,d1

Title_ClrScroll:
		move.l	d0,(a1)+
		dbf	d1,Title_ClrScroll ; fill scroll data with 0

		move.l	d0,($FFFFF616).w
		move	#$2700,sr
		lea	(VDP_DATA).l,a6
		move.l	#$60000003,(VDP_CTRL).l
		move.w	#$3FF,d1

Title_ClrVram:
		move.l	d0,(a6)
		dbf	d1,Title_ClrVram ; fill	VRAM with 0

		jsr	LevSelTextLoad

; ---------------------------------------------------------------------------
; Level	Select
; ---------------------------------------------------------------------------

LevelSelect:
		move.b	#$04,($FFFFF62A).w
		jsr	DelayProgram
		jsr	LevSelControls
		jsr	RunPLC_RAM
		tst.l	($FFFFF680).w
		bne.s	LevelSelect
		andi.b	#$F0,($FFFFF605).w ; is	A, B, C, or Start pressed?
		beq.s	LevelSelect	; if not, branch
		move.w	($FFFFFF82).w,d0
		cmpi.w	#$14,d0		; have you selected item $14 (sound test)?
		bne.s	LevSel_Level_SS	; if not, go to	Level/SS subroutine
		move.w	($FFFFFF84).w,d0
		addi.w	#$80,d0
		tst.b	($FFFFFFE3).w	; is Japanese Credits cheat on?
		beq.s	LevSel_NoCheat	; if not, branch
		cmpi.w	#$9F,d0		; is sound $9F being played?
		beq.s	LevSel_Ending	; if yes, branch
		cmpi.w	#$9E,d0		; is sound $9E being played?
		beq.s	LevSel_Credits	; if yes, branch

LevSel_NoCheat:
		cmpi.w	#$95,d0		; is sound $80-$94 being played?
		bcs.s	LevSel_PlaySnd	; if yes, branch
		cmpi.w	#$A0,d0		; is sound $95-$A0 being played?
		bcs.s	LevelSelect	; if yes, branch

LevSel_PlaySnd:
		jsr	PlaySound_Special
		bra.s	LevelSelect
; ===========================================================================

LevSel_Ending:				; XREF: LevelSelect
		move.b	#$18,($FFFFF600).w ; set screen	mode to	$18 (Ending)
		move.w	#$600,(v_zone).l ; set level	to 0600	(Ending)
		rts	
; ===========================================================================

LevSel_Credits:				; XREF: LevelSelect
		move.b	#$1C,($FFFFF600).w ; set screen	mode to	$1C (Credits)
		move.b	#$91,d0
		jsr	PlaySound_Special ; play credits music
		move.w	#0,($FFFFFFF4).w
		rts	
; ===========================================================================

LevSel_Level_SS:			; XREF: LevelSelect
		add.w	d0,d0
		move.w	LSelectPointers(pc,d0.w),d0 ; load level number
		bmi.w	LevelSelect
		cmpi.w	#id_ST*$100,d0	; check	if level is 0700 (Special Stage)
		bne.w	CheckOther	; if not, branch
		move.b	#$10,($FFFFF600).w ; set screen	mode to	$10 (Special Stage)
		clr.w	(v_zone).l	; clear	level
		move.b	#3,($FFFFFE12).w ; set lives to	3
		moveq	#0,d0
		move.w	d0,($FFFFFE20).w ; clear rings
		move.l	d0,($FFFFFE22).w ; clear time
		move.l	d0,($FFFFFE26).w ; clear score
		rts	

; ===========================================================================

LevSel_Level:				; XREF: LevSel_Level_SS
		andi.w	#$3FFF,d0
		move.w	d0,(v_zone).l ; set level number

PlayLevel:				; XREF: ROM:00003246j ...
        ;move.b  #1,(Title_Press_Start).l
		;jmp (loc_317C).l
		;rts
		move.b	#id_Level,($FFFFF600).w ; set	screen mode to $0C (level)
		move.b	#3,($FFFFFE12).w ; set lives to	3
		moveq	#0,d0
		move.w	d0,($FFFFFE20).w ; clear rings
		move.l	d0,($FFFFFE22).w ; clear time
		move.l	d0,($FFFFFE26).w ; clear score
		move.b	d0,($FFFFFE16).w ; clear special stage number
		move.b	d0,($FFFFFE57).w ; clear emeralds
		move.l	d0,($FFFFFE58).w ; clear emeralds
		move.l	d0,($FFFFFE5C).w ; clear emeralds
		move.b	d0,($FFFFFE18).w ; clear continues
		move.b	#$E0,d0
		jsr	PlaySound_Special ; fade out music
		rts	

PlayLevel2:
		move.b	#id_SoundTest,($FFFFF600).w			; set screen mode to sound test $20
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level	select - level pointers
; ---------------------------------------------------------------------------
LSelectPointers:
		dc.b id_GHZ, 0
		dc.b id_GHZ, 1
		dc.b id_GHZ, 2
		dc.b id_LZ, 0
		dc.b id_LZ, 1
		dc.b id_LZ, 2
		dc.b id_MZ, 0
		dc.b id_MZ, 1
		dc.b id_MZ, 2
		dc.b id_SLZ, 0
		dc.b id_SLZ, 1
		dc.b id_SLZ, 2
		dc.b id_SYZ, 0
		dc.b id_SYZ, 1
		dc.b id_SYZ, 2
		dc.b id_SBZ, 0
		dc.b id_SBZ, 1
		dc.b id_LZ, 3		; Scrap Brain Zone 3
		dc.b id_SBZ, 2		; Final Zone
		dc.b id_ST, 0		; Special Stage
		dc.w $8000		; Sound Test
		even
CheckOther:
        cmpi.w	#id_LZ*$100,d0	; check	if level is 0700 (Special Stage)
		bne.w	LevSel_Level	; if not, branch
		move.w  #id_GHZ*$100,(v_zone).l
		move.b  #0,(v_time_zone).l
		bra.w   LevSel_Level		
; ---------------------------------------------------------------------------
; Level	select codes
; ---------------------------------------------------------------------------
LevelSelectCode_J:
		incbin	misc\ls_jcode.bin
		even

LevelSelectCode_US:
		incbin	misc\ls_ucode.bin
		even
; ===========================================================================

; ---------------------------------------------------------------------------
; Demo mode
; ---------------------------------------------------------------------------

Demo:					; XREF: TitleScreen
		move.w	#$1E,(v_vint_timer).w

loc_33B6:				; XREF: loc_33E4
		move.b	#4,($FFFFF62A).w
		jsr	DelayProgram
;		jsr	DeformBgLayer
		jsr	PalCycle_Load
		jsr	RunPLC_RAM
		move.w	($FFFFD008).w,d0
		addq.w	#2,d0
		move.w	d0,($FFFFD008).w
		cmpi.w	#$1C00,d0
		bcs.s	loc_33E4
		move.b	#0,($FFFFF600).w ; set screen mode to 00 (level)
		rts	
; ===========================================================================

loc_33E4:				; XREF: Demo
		andi.b	#$80,($FFFFF605).w ; is	Start button pressed?
		bne.w	Title_ChkLevSel	; if yes, branch
		tst.w	(v_vint_timer).w
		bne.w	loc_33B6
		move.b	#$E0,d0
		jsr	PlaySound_Special ; fade out music
		move.w	($FFFFFFF2).w,d0 ; load	demo number
		andi.w	#7,d0
		add.w	d0,d0
		move.w	Demo_Levels(pc,d0.w),d0	; load level number for	demo
		move.w	d0,(v_zone).l
		addq.w	#1,($FFFFFFF2).w ; add 1 to demo number
		cmpi.w	#4,($FFFFFFF2).w ; is demo number less than 4?
		bcs.s	loc_3422	; if yes, branch
		move.w	#0,($FFFFFFF2).w ; reset demo number to	0

loc_3422:
		move.w	#1,($FFFFFFF0).w ; turn	demo mode on
		move.b	#8,($FFFFF600).w ; set screen mode to 08 (demo)
		cmpi.w	#$600,d0	; is level number 0600 (special	stage)?
		bne.s	Demo_Level	; if not, branch
		move.b	#$10,($FFFFF600).w ; set screen	mode to	$10 (Special Stage)
		clr.w	(v_zone).l	; clear	level number
		clr.b	($FFFFFE16).w	; clear	special	stage number

Demo_Level:
		move.b	#3,($FFFFFE12).w ; set lives to	3
		moveq	#0,d0
		move.w	d0,($FFFFFE20).w ; clear rings
		move.l	d0,($FFFFFE22).w ; clear time
		move.l	d0,($FFFFFE26).w ; clear score
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Levels used in demos
; ---------------------------------------------------------------------------
Demo_Levels:	incbin	misc\dm_ord1.bin
		even

; ---------------------------------------------------------------------------
; Subroutine to	change what you're selecting in the level select
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevSelControls:				; XREF: LevelSelect
		move.b	($FFFFF605).w,d1
		andi.b	#3,d1		; is up/down pressed and held?
		bne.s	LevSel_UpDown	; if yes, branch
		subq.w	#1,($FFFFFF80).w ; subtract 1 from time	to next	move
		bpl.s	LevSel_SndTest	; if time remains, branch

LevSel_UpDown:
		move.w	#$B,($FFFFFF80).w ; reset time delay
		move.b	($FFFFF604).w,d1
		andi.b	#3,d1		; is up/down pressed?
		beq.s	LevSel_SndTest	; if not, branch
		move.w	($FFFFFF82).w,d0
		btst	#0,d1		; is up	pressed?
		beq.s	LevSel_Down	; if not, branch
		subq.w	#1,d0		; move up 1 selection
		bcc.s	LevSel_Down
		moveq	#$14,d0		; if selection moves below 0, jump to selection	$14

LevSel_Down:
		btst	#1,d1		; is down pressed?
		beq.s	LevSel_Refresh	; if not, branch
		addq.w	#1,d0		; move down 1 selection
		cmpi.w	#$15,d0
		bcs.s	LevSel_Refresh
		moveq	#0,d0		; if selection moves above $14,	jump to	selection 0

LevSel_Refresh:
		move.w	d0,($FFFFFF82).w ; set new selection
		jsr	LevSelTextLoad	; refresh text
		rts	
; ===========================================================================

LevSel_SndTest:				; XREF: LevSelControls
		cmpi.w	#$14,($FFFFFF82).w ; is	item $14 selected?
		bne.s	LevSel_NoMove	; if not, branch
		move.b	($FFFFF605).w,d1
		andi.b	#$C,d1		; is left/right	pressed?
		beq.s	LevSel_NoMove	; if not, branch
		move.w	($FFFFFF84).w,d0
		btst	#2,d1		; is left pressed?
		beq.s	LevSel_Right	; if not, branch
		subq.w	#1,d0		; subtract 1 from sound	test
		bcc.s	LevSel_Right
		moveq	#$64,d0		; if sound test	moves below 0, set to $4F

LevSel_Right:
		btst	#3,d1		; is right pressed?
		beq.s	LevSel_Refresh2	; if not, branch
		addq.w	#1,d0		; add 1	to sound test
		cmpi.w	#$65,d0
		bcs.s	LevSel_Refresh2
		moveq	#0,d0		; if sound test	moves above $4F, set to	0

LevSel_Refresh2:
		move.w	d0,($FFFFFF84).w ; set sound test number
		jsr	LevSelTextLoad	; refresh text

LevSel_NoMove:
		rts	
; End of function LevSelControls

; ---------------------------------------------------------------------------
; Subroutine to load level select text
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevSelTextLoad:				; XREF: TitleScreen
		lea	(LevelMenuText).l,a1
		lea	(VDP_DATA).l,a6
		move.l	#$62100003,d4	; screen position (text)
		move.w	#$E680,d3	; VRAM setting
		moveq	#$14,d1		; number of lines of text

loc_34FE:				; XREF: LevSelTextLoad+26j
		move.l	d4,4(a6)
		jsr	LevSel_ChgLine
		addi.l	#$800000,d4
		dbf	d1,loc_34FE
		moveq	#0,d0
		move.w	($FFFFFF82).w,d0
		move.w	d0,d1
		move.l	#$62100003,d4
		lsl.w	#7,d0
		swap	d0
		add.l	d0,d4
		lea	(LevelMenuText).l,a1
		lsl.w	#3,d1
		move.w	d1,d0
		add.w	d1,d1
		add.w	d0,d1
		adda.w	d1,a1
		move.w	#$C680,d3
		move.l	d4,4(a6)
		jsr	LevSel_ChgLine
		move.w	#$E680,d3
		cmpi.w	#$14,($FFFFFF82).w
		bne.s	loc_3550
		move.w	#$C680,d3

loc_3550:
		move.l	#$6C300003,(VDP_CTRL).l ; screen	position (sound	test)
		move.w	($FFFFFF84).w,d0
		addi.w	#$80,d0

DRAWNUMBER:
		move.b	d0,d2
		lsr.b	#4,d0
		jsr	LevSel_ChgSnd
		move.b	d2,d0
		jsr	LevSel_ChgSnd
		rts	
; End of function LevSelTextLoad


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevSel_ChgSnd:				; XREF: LevSelTextLoad
		andi.w	#$F,d0
		cmpi.b	#$A,d0
		bcs.s	loc_3580
		addi.b	#7,d0

loc_3580:
		add.w	d3,d0
		move.w	d0,(a6)
		rts	
; End of function LevSel_ChgSnd


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevSel_ChgLine:				; XREF: LevSelTextLoad
		moveq	#$17,d2		; number of characters per line

loc_3588:
		moveq	#0,d0
		move.b	(a1)+,d0
		bpl.s	loc_3598
		move.w	#0,(a6)
		dbf	d2,loc_3588
		rts	
; ===========================================================================

loc_3598:				; XREF: LevSel_ChgLine
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc_3588
		rts	
; End of function LevSel_ChgLine

; ===========================================================================
; ---------------------------------------------------------------------------
; Level	select menu text
; ---------------------------------------------------------------------------
LevelMenuText:	incbin	misc\menutext.bin
		even
Eni_Title:	incbin	mapeni\titlescr.bin	; title screen foreground (mappings)
		even
Nem_TitleFg:	incbin	artnem\titlefor.bin	; title screen foreground
		even
art_water:
art_mountains:
Nem_TitleSonic:	incbin	artnem\titleson.bin	; Sonic on title screen
		even
Nem_TitleTM:	incbin	artnem\titletm.bin	; TM on title screen
		even
Eni_JapNames:	incbin	mapeni\japcreds.bin	; Japanese credits (mappings)
		even
Nem_JapNames:	incbin	artnem\japcreds.bin	; Japanese credits
		even
Nem_CreditText:	incbin	artnem\credits.bin	; credits alphabet
		even
Art_Text:	incbin	artunc\menutext.bin	; text used in level select and debug mode
		even						

; -------------------------------------------------------------------------

ObjTitleSonic:
        cmpi.b  #1,oSubtype(a0)
		beq.s   ObjTitleArm
		cmpi.b  #2,oSubtype(a0)
		beq.w   ObjTitleBanner
		moveq	#0,d0
		move.b	oRoutine(a0),d0
		move.w	Obj0E_Index(pc,d0.w),d1
		jmp	Obj0E_Index(pc,d1.w)
; ===========================================================================
Obj0E_Index:	
        dc.w Obj0E_Main-Obj0E_Index
		dc.w Obj0E_Delay-Obj0E_Index
		dc.w Obj0E_Move-Obj0E_Index
		dc.w Obj0E_Animate-Obj0E_Index
; ===========================================================================

Obj0E_Main:				; XREF: Obj0E_Index
		addq.b	#2,oRoutine(a0)
		move.w	#$DC,oX(a0)
		move.w	#$90,oYScr(a0)
		move.l	#Map_obj0E,oMap(a0)
		move.w	#$6300,oTile(a0)
		move.b	#1,oPriority(a0)
;		move.b	#29,oVar1F(a0)	; set time delay to 0.5	seconds
		lea	(Ani_obj0E).l,a1
		jsr	AnimateObject

Obj0E_Delay:				; XREF: Obj0E_Index
;		subq.b	#1,oVar1F(a0)	; subtract 1 from time delay
;		bpl.s	Obj0E_Wait	; if time remains, branch
		addq.b	#2,oRoutine(a0)	; go to	next routine
		jmp	DrawObject
; ===========================================================================

Obj0E_Wait:				; XREF: Obj0E_Delay
		rts	
; ===========================================================================

Obj0E_Move:				; XREF: Obj0E_Index
;		subq.w	#8,oYScr(a0)
;		cmpi.w	#$96,oYScr(a0)
;		bne.s	Obj0E_Display
		addq.b	#2,oRoutine(a0)

Obj0E_Display:
        move.b	#$83,d0		; play title screen music
		jsr	PlaySound_Special
		jmp	DrawObject
; ===========================================================================
		rts	
; ===========================================================================

Obj0E_Animate:				; XREF: Obj0E_Index
		lea	(Ani_obj0E).l,a1
		jsr	AnimateObject
		jmp	DrawObject
; ===========================================================================
		rts	

ObjTitleArm:
		moveq	#0,d0
		move.b	oRoutine(a0),d0
		move.w	ObjTitleArm_Index(pc,d0.w),d1
		jmp	ObjTitleArm_Index(pc,d1.w)
; ===========================================================================
ObjTitleArm_Index:	
        dc.w ObjTitleArm_Main-ObjTitleArm_Index
		dc.w ObjTitleArm_Delay-ObjTitleArm_Index
		dc.w ObjTitleArm_Move-ObjTitleArm_Index
		dc.w ObjTitleArm_Animate-ObjTitleArm_Index
; ===========================================================================

ObjTitleArm_Main:				; XREF: Obj0E_Index
		addq.b	#2,oRoutine(a0)
		move.w	#$10C,oX(a0)
		move.w	#$E8,oYScr(a0)
		move.l	#Map_obj0E,oMap(a0)
		move.w	#$6300,oTile(a0)
		move.b	#0,oPriority(a0)
		move.b	#50,oVar1F(a0)	; set time delay to 0.5	seconds
		move.b #1,oAnim(a0)
		lea	(Ani_obj0E).l,a1
		jsr	AnimateObject

ObjTitleArm_Delay:				; XREF: Obj0E_Index
		subq.b	#1,oVar1F(a0)	; subtract 1 from time delay
		bpl.s	ObjTitleArm_Wait	; if time remains, branch
		addq.b	#2,oRoutine(a0)	; go to	next routine
		jmp	DrawObject
; ===========================================================================

ObjTitleArm_Wait:				; XREF: Obj0E_Delay
		rts	
; ===========================================================================

ObjTitleArm_Move:				; XREF: Obj0E_Index
;		subq.w	#8,oYScr(a0)
;		cmpi.w	#$96,oYScr(a0)
;		bne.s	ObjTitleArm_Display
		addq.b	#2,oRoutine(a0)

ObjTitleArm_Display:
		jmp	DrawObject
; ===========================================================================
		rts	
; ===========================================================================

ObjTitleArm_Animate:				; XREF: Obj0E_Index
		move.b #1,oAnim(a0)
		lea	(Ani_obj0E).l,a1
		jsr	AnimateObject
		jmp	DrawObject
; ===========================================================================
		rts	

ObjTitleBanner:
		moveq	#0,d0
		move.b	oRoutine(a0),d0
		move.w	ObjTitleBanner_Index(pc,d0.w),d1
		jmp	ObjTitleBanner_Index(pc,d1.w)
; ===========================================================================
ObjTitleBanner_Index:	
        dc.w ObjTitleBanner_Main-ObjTitleBanner_Index
		dc.w ObjTitleBanner_Delay-ObjTitleBanner_Index
		dc.w ObjTitleBanner_Move-ObjTitleBanner_Index
		dc.w ObjTitleBanner_Animate-ObjTitleBanner_Index
; ===========================================================================

ObjTitleBanner_Main:				; XREF: Obj0E_Index
		addq.b	#2,oRoutine(a0)
		move.w	#-$100,oX(a0)
		move.w	#$100,oYScr(a0)
		move.l	#Map_Banner,oMap(a0)
		move.w	#$0106,oTile(a0)
		move.b	#0,oPriority(a0)
;		move.b	#50,oVar1F(a0)	; set time delay to 0.5	seconds
		move.b #2,oAnim(a0)
		lea	(Ani_obj0E).l,a1
		jsr	AnimateObject

ObjTitleBanner_Delay:				; XREF: Obj0E_Index
;		subq.b	#1,oVar1F(a0)	; subtract 1 from time delay
;		bpl.s	ObjTitleBanner_Wait	; if time remains, branch
		addq.b	#2,oRoutine(a0)	; go to	next routine
		jmp	DrawObject
; ===========================================================================

ObjTitleBanner_Wait:				; XREF: Obj0E_Delay
		rts	
; ===========================================================================

ObjTitleBanner_Move:				; XREF: Obj0E_Index
;		subq.w	#8,oYScr(a0)
;		cmpi.w	#$96,oYScr(a0)
;		bne.s	ObjTitleBanner_Display
		addq.b	#2,oRoutine(a0)

ObjTitleBanner_Display:
		jmp	DrawObject
; ===========================================================================
		rts	
; ===========================================================================

ObjTitleBanner_Animate:				; XREF: Obj0E_Index
		move.b #2,oAnim(a0)
		lea	(Ani_obj0E).l,a1
		jsr	AnimateObject
		jmp	DrawObject
; ===========================================================================
		rts	

Pal_Title:
        cmpi.b #5,(v_player+oMapFrame).w
		bne.s .end
		moveq	#1,d0		; load Sonic's pallet
		jsr	PalLoad1
		jsr Pal_FadeTo
		move.b #1,(v_title_final_state).l
 .end:
    rts
; -------------------------------------------------------------------------
; Sonic mappings
; -------------------------------------------------------------------------
Map_obj0E:
MapSpr_Title_Sonic:
	include	"level/level/TitleScreen/Data/Mappings.asm"
	even
Ani_obj0E:
    dc.w	TitleSonic-Ani_obj0E
    dc.w	TitleArm-Ani_obj0E
	dc.w	TitleBanner-Ani_obj0E
TitleSonic:
    dc.b	5, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, $FE ,1
TitleArm:	
    dc.b	5, 9, 8, 7, 6, 6, 7, 8, 9, $FF ,0
	dc.b	5, 9, 8, 7, 6, 6, 7, 8, 9, $FF ,0
TitleBanner:
    dc.b	5, 0, 0, 0, 0, 0, 0, 0, 0,  $FF ,0	
Map_Banner:
	include	"level/level/TitleScreen/Data/BannerMappings.asm"
	even
Art_Banner:	
	incbin	"level/level/TitleScreen/Data/BannerArt.bin"
	even

Art_PressStartText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, Press Start).unc"
	even
Art_NewGameText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, New Game).unc"
	even
Art_ContinueText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, Continue).unc"
	even
Art_TimeAttackText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, Time Attack).unc"
	even			
Art_RamDataText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, RAM Data).unc"
	even	
Art_DAGardenText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, D.A. Garden).unc"
	even
Art_VisualModeText:	
	incbin	"level/level/TitleScreen/Data/Art (Text, Visual Mode).unc"
	even


    include "_incOBJ/Tested.asm"