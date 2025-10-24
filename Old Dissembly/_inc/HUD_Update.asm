; ---------------------------------------------------------------------------
; Subroutine to	update the HUD
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
HUD_Update:
UpdateHUD:
	tst.w	(v_debug_mode_enabled).l
	beq.s	@NormalHUD
	bsr.w	HudDb_XY
	move.l	#$73600002,d0
	moveq	#0,d1
	move.b	(v_obj_respawns).l,d1
	move.w	(v_player+oY).w,d2
	lsr.w	#1,d2
	andi.w	#$380,d2
	move.b	(v_player+oX).w,d1
	andi.w	#$7F,d1
	add.w	d1,d2
	lea	(v_lvl_layout).w,a1
	moveq	#0,d1
	move.b	(a1,d2.w),d1
	andi.w	#$7F,d1
	move.w	(v_debug_block).l,d1
	andi.w	#$7FF,d1
	lea	(Hud_100).l,a2
	moveq	#2,d6
	bsr.w	Hud_Digits
	bra.w	@ChkTime

; -------------------------------------------------------------------------------

@NormalHUD:
	tst.b	(v_update_score).l
	beq.s	@ChkRings
	bpl.s	@UpdateScore
	bsr.w	Hud_Base

@UpdateScore:
	clr.b	(v_update_score).l
	move.l	#$70600002,d0
	move.l	(v_score).l,d1
	bsr.w	Hud_Score

@ChkRings:
	tst.b	(v_update_rings).l
	beq.s	@ChkTime
	bpl.s	@UpdateRings
	bsr.w	Hud_InitRings

@UpdateRings:
	clr.b	(v_update_rings).l
	move.l	#$73600002,d0
	moveq	#0,d1
	move.w	(v_ring_count).l,d1
	cmpi.w	#1000,d1
	bcs.s	@CappedRings
	move.w	#999,d1
	move.w	d1,(v_ring_count).l

@CappedRings:
	bsr.w	Hud_Rings

@ChkTime:
	tst.w	(v_debug_mode_enabled).l
	bne.w	@ChkLives
	tst.b	(v_update_time).l
	beq.w	@ChkLives
	tst.w	(v_paused).w
	bne.w	@ChkLives
	lea	(v_time).l,a1
	cmpi.l	#$93B3B,(a1)+
	beq.w	TimeOver
	tst.b	(v_ctrl_locked).w
	bne.s	@UpdateTimer
	addq.b	#1,-(a1)
	cmpi.b	#60,(a1)
	bcs.s	@UpdateTimer
	move.b	#0,(a1)
	addq.b	#1,-(a1)
	cmpi.b	#60,(a1)
	bcs.s	@UpdateTimer
	move.b	#0,(a1)
	addq.b	#1,-(a1)
	cmpi.b	#9,(a1)
	bcs.s	@UpdateTimer
	move.b	#9,(a1)

@UpdateTimer:
	move.l	#$72200002,d0
	moveq	#0,d1
	move.b	(v_time+1).l,d1
	bsr.w	Hud_Mins
	move.l	#$72600002,d0
	moveq	#0,d1
	move.b	(v_time+2).l,d1
	bsr.w	Hud_SecsCentisecs
	move.l	#$72E00002,d0
	moveq	#0,d1
	move.b	(v_time+3).l,d1
	mulu.w	#100,d1
	divu.w	#60,d1
	swap	d1
	move.w	#0,d1
	swap	d1
	cmpi.l	#$93B3B,(v_time).l
	bne.s	@UpdateCentisecs
	move.w	#99,d1

@UpdateCentisecs:
	bsr.w	Hud_SecsCentisecs

@ChkLives:
	tst.b	(v_update_lives).l
	beq.s	@ChkBonus
	clr.b	(v_update_lives).l
	bsr.w	Hud_Lives

@ChkBonus:
	tst.b	(v_update_bonus_score).w
	beq.s	@End
	clr.b	(v_update_bonus_score).w
	move.l	#$47800002,d0
	cmpi.w	#$502,(v_zone).l
	bne.s	@GotVRAMLoc
	move.l	#$6D400001,d0

@GotVRAMLoc:
	moveq	#0,d1
	move.w	(v_bonus_countdown_1).w,d1
	bsr.w	Hud_Bonus
	move.l	#$48C00002,d0
	cmpi.w	#$502,(v_zone).l
	bne.s	@NotSSZ3
	move.l	#$6E800001,d0

@NotSSZ3:
	moveq	#0,d1
	move.w	(v_bonus_countdown_2).w,d1
	bsr.w	Hud_Bonus

@End:
	rts

; -------------------------------------------------------------------------------

TimeOver:
	btst	#7,(v_time_zone).l
	bne.s	@End2
	clr.b	(v_update_time).l
	move.l	#0,(v_time).l
	lea	(v_player).w,a0
	movea.l	a0,a2
	jsr	KillPlayer
	move.b	#1,(v_time_over).l

@End2:
	rts
; END OF FUNCTION CHUNK	FOR VInt_Pause
; -------------------------------------------------------------------------------

Hud_InitRings:
	move.l	#$73600002,(VDP_CTRL).l
	lea	Hud_TilesRings(pc),a2
	move.w	#2,d2
	bra.s	Hud_InitCommon
; End of function Hud_InitRings

; -------------------------------------------------------------------------------

Hud_Base:
	lea	(VDP_DATA).l,a6
	bsr.w	Hud_Lives
	move.l	#$70600002,(VDP_CTRL).l
	lea	Hud_TilesBase(pc),a2
	move.w	#6,d2

Hud_InitCommon:
	lea	(ArtUnc_HUD).l,a1

@OuterLoop:
	move.w	#$F,d1
	move.b	(a2)+,d0
	bmi.s	@EmptyTile
	ext.w	d0
	lsl.w	#5,d0
	lea	(a1,d0.w),a3

@InnerLoop:
	move.l	(a3)+,(a6)
	dbf	d1,@InnerLoop

@Next:
	dbf	d2,@OuterLoop
	rts

; -------------------------------------------------------------------------------

@EmptyTile:
	move.l	#0,(a6)
	dbf	d1,@EmptyTile
	bra.s	@Next
; End of function Hud_Base

; -------------------------------------------------------------------------------
Hud_TilesBase:	dc.b	$FF, $FF, $FF, $FF, $FF, $FF, 0, 0
Hud_TilesRings:	dc.b	$FF, $FF, 0, 0
; -------------------------------------------------------------------------------

HudDb_XY:
	move.l	#$70E00002,d0
	moveq	#0,d1
	move.w	(v_player+oX).w,d1
	bsr.w	Hud_Hex
	move.l	#$72600002,d0
	move.w	(v_player+oY).w,d1
	bra.w	Hud_Hex
; End of function HudDb_XY

; -------------------------------------------------------------------------------

Hud_Bonus:
	lea	(Hud_10000).l,a2
	moveq	#4,d6
	moveq	#0,d4
	lea	(ArtUnc_HUD).l,a1

@DigitLoop:
	moveq	#0,d2
	move.l	(a2)+,d3

@Loop:
	sub.l	d3,d1
	bcs.s	@GotDigit
	addq.w	#1,d2
	bra.s	@Loop

; -------------------------------------------------------------------------------

@GotDigit:
	add.l	d3,d1
	tst.w	d2
	beq.s	@NonzeroDigit
	move.w	#1,d4

@NonzeroDigit:
	move.l	d0,4(a6)
	tst.w	d4
	bne.s	@DrawDigit
	tst.w	d6
	bne.s	@BlankTile

@DrawDigit:
	lsl.w	#6,d2
	lea	(a1,d2.w),a3
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)

@Next:
	addi.l	#$400000,d0
	dbf	d6,@DigitLoop
	rts

; -------------------------------------------------------------------------------

@BlankTile:
	moveq	#$F,d5

@Loop2:
	move.l	#0,(a6)
	dbf	d5,@Loop2
	bra.s	@Next
; End of function Hud_Bonus

; -------------------------------------------------------------------------------

Hud_Rings:
	lea	(Hud_100).l,a2
	moveq	#2,d6
	bra.s	Hud_LoadArt
; End of function Hud_Rings

; -------------------------------------------------------------------------------

Hud_Score:
	lea	(Hud_100000).l,a2
	moveq	#5,d6

Hud_LoadArt:
	moveq	#0,d4
	lea	(ArtUnc_HUD).l,a1

@DigitLoop:
	moveq	#0,d2
	move.l	(a2)+,d3

@Loop:
	sub.l	d3,d1
	bcs.s	@GotDigit
	addq.w	#1,d2
	bra.s	@Loop

; -------------------------------------------------------------------------------

@GotDigit:
	add.l	d3,d1
	tst.w	d2
	beq.s	@ChkDraw
	move.w	#1,d4

@ChkDraw:
	tst.w	d4
	beq.s	@SkipDigit
	lsl.w	#6,d2
	move.l	d0,4(a6)
	lea	(a1,d2.w),a3
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)

@SkipDigit:
	addi.l	#$400000,d0
	dbf	d6,@DigitLoop
	rts
; End of function Hud_Score

; -------------------------------------------------------------------------------

ContScrCounter:
	move.l	#$5F800003,(VDP_CTRL).l
	lea	(VDP_DATA).l,a6
	lea	(Hud_10).l,a2
	moveq	#1,d6
	moveq	#0,d4
	lea	(ArtUnc_HUD).l,a1

@DigitLoop:
	moveq	#0,d2
	move.l	(a2)+,d3

@Loop:
	sub.l	d3,d1
	bcs.s	@GotDigit
	addq.w	#1,d2
	bra.s	@Loop

; -------------------------------------------------------------------------------

@GotDigit:
	add.l	d3,d1
	lsl.w	#6,d2
	lea	(a1,d2.w),a3
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	dbf	d6,@DigitLoop
	rts
; End of function ContScrCounter

; -------------------------------------------------------------------------------
Hud_100000:	dc.l	100000
Hud_10000:	dc.l	10000
Hud_1000:	dc.l	1000
Hud_100:	dc.l	100
Hud_10:	dc.l	10
Hud_1:	dc.l	1
Hud_1000h:	dc.l	$1000
Hud_100h:	dc.l	$100
Hud_10h:	dc.l	$10
Hud_1h:	dc.l	1
; -------------------------------------------------------------------------------

Hud_Hex:
	moveq	#3,d6
	lea	(Hud_1000h).l,a2
	bra.s	Hud_Digits
; End of function Hud_Hex

; -------------------------------------------------------------------------------

Hud_Lives:
	move.l	#$74A00002,d0
	moveq	#0,d1
	move.b	(v_life_count).l,d1
	cmpi.b	#9,d1
	bcs.s	@Max9Lives
	moveq	#9,d1

@Max9Lives:
	lea	(Hud_1).l,a2
	moveq	#0,d6
	bra.s	Hud_Digits
; End of function Hud_Lives

; -------------------------------------------------------------------------------

Hud_Mins:
	lea	(Hud_1).l,a2
	moveq	#0,d6
	bra.s	Hud_Digits
; End of function Hud_Mins

; -------------------------------------------------------------------------------

Hud_SecsCentisecs:
	lea	(Hud_10).l,a2
	moveq	#1,d6
; End of function Hud_SecsCentisecs

; -------------------------------------------------------------------------------

Hud_Digits:
	moveq	#0,d4
	lea	(ArtUnc_HUD).l,a1

@DigitLoop:
	moveq	#0,d2
	move.l	(a2)+,d3

@Loop:
	sub.l	d3,d1
	bcs.s	@GotDigit
	addq.w	#1,d2
	bra.s	@Loop

; -------------------------------------------------------------------------------

@GotDigit:
	add.l	d3,d1
	tst.w	d2
	beq.s	@DrawDigit
	move.w	#1,d4

@DrawDigit:
	lsl.w	#6,d2
	move.l	d0,4(a6)
	lea	(a1,d2.w),a3
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	move.l	(a3)+,(a6)
	addi.l	#$400000,d0
	dbf	d6,@DigitLoop
	rts
; End of function Hud_Digits

; -------------------------------------------------------------------------------
; Load life icon
; -------------------------------------------------------------------------------

LoadLifeIcon:
	move.l	#$74200002,d0				; Set VDP write command

	moveq	#0,d2					; Get pointer to life icon
	move.b	(v_time_zone).l,d2
	bclr	#7,d2
	lsl.w	#7,d2
	move.l	d0,4(a6)
	lea	(ArtUnc_LifeIcon).l,a1
	lea	(a1,d2.w),a3

	rept	32
		move.l	(a3)+,(a6)			; Load life icon
	endr

	rts