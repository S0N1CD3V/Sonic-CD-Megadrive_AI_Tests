; ---------------------------------------------------------------------------
; Background layer deformation subroutines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DeformLayers:
		tst.b	(f_nobgscroll).w
		beq.s	@bgscroll
		rts	
; ===========================================================================

	@bgscroll:
		clr.w	(v_fg_scroll_flags).w
		clr.w	(v_bg1_scroll_flags).w
		clr.w	(v_bg2_scroll_flags).w
		clr.w	(v_bg3_scroll_flags).w
		bsr.w	ScrollHoriz
		bsr.w	ScrollVertical
		bsr.w	DynamicLevelEvents
		move.w	(v_screenposx).w,(v_scrposx_dup).w
		move.w	(v_screenposy).w,(v_scrposy_dup).w
		move.w	(v_bgscreenposx).w,(v_bgscreenposx_dup_unused).w
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		move.w	(v_bg3screenposx).w,(v_bg3screenposx_dup_unused).w
		move.w	(v_bg3screenposy).w,(v_bg3screenposy_dup_unused).w
		moveq	#0,d0
		move.b	(v_zone).w,d0
		add.w	d0,d0
		move.w	Deform_Index(pc,d0.w),d0
		jmp	Deform_Index(pc,d0.w)
; End of function DeformLayers

; ===========================================================================
; ---------------------------------------------------------------------------
; Offset index for background layer deformation	code
; ---------------------------------------------------------------------------
Deform_Index:	dc.w Deform_GHZ-Deform_Index, Deform_LZ-Deform_Index
		dc.w Deform_MZ-Deform_Index, Deform_SLZ-Deform_Index
		dc.w Deform_SYZ-Deform_Index, Deform_SBZ-Deform_Index
		zonewarning Deform_Index,2
		dc.w Deform_GHZ-Deform_Index
; ---------------------------------------------------------------------------
; Green	Hill Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_GHZ:
Deform_PPZ:
	moveq	#0,d5					; Reset scroll speed offset
	btst	#1,(v_player+oPlayerCtrl).w		; Is the player on a 3D ramp?
	beq.s	@GotSpeed				; If not, branch
	tst.w	(v_scroll_diff_x).w			; Is the camera scrolling horizontally?
	beq.s	@GotSpeed				; If not, branch
	move.w	(v_player+oXVel).w,d5			; Set scroll speed offset to the player's X velocity
	ext.l	d5
	asl.l	#8,d5

@GotSpeed:
	move.w	(v_scroll_diff_x).w,d4			; Set scroll offset and flags for the clouds
	ext.l	d4
	asl.l	#5,d4
	add.l	d5,d4
	moveq	#6,d6
	bsr.w	SetHorizScrollFlagsBG3

	move.w	(v_scroll_diff_x).w,d4			; Set scroll offset and flags for the mountains
	ext.l	d4
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	add.l	d5,d4
	add.l	d5,d4
	moveq	#4,d6
	bsr.w	SetHorizScrollFlagsBG2

	lea	(v_deform_buffer).w,a1			; Prepare deformation buffer

	move.w	(v_scroll_diff_x).w,d4			; Set scroll offset and flags for the bushes and water
	ext.l	d4
	asl.l	#7,d4
	add.l	d5,d4
	moveq	#2,d6
	bsr.w	SetHorizScrollFlagsBG

	move.w	(v_cam_fg_y).w,d0			; Get background Y position
	cmpi.w	#$800,(v_player+oX).w			; Has the player gone past the first 3D ramp?
	bcs.s	@No3DRamp				; If not, branch
	subi.w	#$1E0,d0				; Get background Y position past the first 3D ramp
	bcs.s	@ChgDir
	lsr.w	#1,d0

@ChgDir:
	addi.w	#$1E0,d0				; Get background Y position before the first 3D ramp

@No3DRamp:
	bsr.w	SetVertiScrollFlagsBG2			; Set BG2 vertical scroll flags

	move.w	(v_cam_bg_y).w,(v_vscroll+2).w		; Update background Y positions
	move.w	(v_cam_bg_y).w,(v_cam_bg2_y).w
	move.w	(v_cam_bg_y).w,(v_cam_bg3_y).w

	move.b	(v_scroll_flags_bg3).w,d0		; Combine background scroll flags for the level drawing routine
	or.b	(v_scroll_flags_bg2).w,d0
	or.b	d0,(v_scroll_flags_bg).w
	clr.b	(v_scroll_flags_bg3).w
	clr.b	(v_scroll_flags_bg2).w

	lea	(v_layer_speeds).l,a2			; Set speeds for the clouds
	addi.l	#$10000,(a2)+
	addi.l	#$E000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$A000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$6000,(a2)+
	addi.l	#$4800,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$2800,(a2)+
	addi.l	#$2000,(a2)+
	addi.l	#$2000,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$10000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$2000,(a2)+

	move.w	(v_cam_fg_x).w,d0			; Prepare scroll cache entry
	neg.w	d0
	swap	d0

	lea	(v_layer_speeds).l,a2			; Prepare cloud speeds
	moveq	#10-1,d6				; Number of cloud sections

@CloudsScroll:
	move.l	(a2)+,d1				; Get cloud section scroll offset
	swap	d1
	add.w	(v_cam_bg3_x).w,d1
	neg.w	d1

	moveq	#0,d5					; Get number of lines in this section
	lea	(CloudSectSizes).l,a3
	move.b	(a3,d6.w),d5

@CloudsScrollSect:
	move.w	d1,(a1)+				; Store scroll offset
	dbf	d5,@CloudsScrollSect			; Loop until this section is stored
	dbf	d6,@CloudsScroll			; Loop until the clouds are finished being processed

	move.w	(v_cam_bg2_x).w,d0			; Scroll top mountains
	neg.w	d0
	moveq	#20-1,d6

@ScrollMountains:
	move.w	d0,(a1)+
	dbf	d6,@ScrollMountains

	move.w	(v_cam_bg_x).w,d0			; Scroll top bushes
	neg.w	d0
	moveq	#4-1,d6

@ScrollBushes:
	move.w	d0,(a1)+
	dbf	d6,@ScrollBushes

	move.w	(v_cam_bg_x).w,d0			; Scroll water (top and upside down)
	neg.w	d0
	move.w	#(28*2)-1,d6

@ScrollWater:
	move.w	d0,(a1)+
	dbf	d6,@ScrollWater

	move.w	(v_cam_bg_x).w,d0			; Scroll upside down bushes
	neg.w	d0
	moveq	#4-1,d6

@ScrollUpsideDownBushes:
	move.w	d0,(a1)+
	dbf	d6,@ScrollUpsideDownBushes

	move.w	(v_cam_bg2_x).w,d0			; Scroll upside down mountains
	neg.w	d0
	moveq	#20-1,d6

@ScrollUpsideDownMountains:
	move.w	d0,(a1)+
	dbf	d6,@ScrollUpsideDownMountains

	moveq	#9-1,d6					; Number of cloud sections

@UpsideDownCloudsScroll:
	move.l	(a2)+,d1				; Get cloud section scroll offset
	swap	d1
	add.w	(v_cam_bg3_x).w,d1
	neg.w	d1

	moveq	#0,d5					; Get number of lines in this section
	lea	(CloudUpsideDownSectSizes).l,a3
	move.b	(a3,d6.w),d5

@UpsideDownCloudsScrollSect:
	move.w	d1,(a1)+				; Store scroll offset
	dbf	d5,@UpsideDownCloudsScrollSect		; Loop until this section is stored
	dbf	d6,@UpsideDownCloudsScroll		; Loop until the clouds are finished being processed

	move.w	(v_cam_bg2_x).w,d0			; Scroll bottom mountains
	neg.w	d0
	moveq	#20-1,d6

@ScrollBtmMountains:
	move.w	d0,(a1)+
	dbf	d6,@ScrollBtmMountains

	move.w	(v_cam_bg_x).w,d0			; Scroll bottom bushes
	neg.w	d0
	moveq	#4-1,d6

@ScrollBtmBushes:
	move.w	d0,(a1)+
	dbf	d6,@ScrollBtmBushes

	move.w	(v_cam_bg_x).w,d0			; Scroll bottom water
	neg.w	d0
	move.w	#16-1,d6

@ScrollBtmWater:
	move.w	d0,(a1)+
	dbf	d6,@ScrollBtmWater

	lea	(v_hscroll).w,a1			; Prepare HScroll cache
	lea	(v_deform_buffer).w,a2			; Prepare deformation buffer

	move.w	(v_cam_bg_y).w,d0			; Get background Y position
	move.w	d0,d2
	move.w	d0,d4
	andi.w	#$7F8,d0
	lsr.w	#2,d0
	moveq	#(240/8)-1,d1				; Max number of blocks to scroll
	lea	(a2,d0.w),a2				; Get starting scroll block
	lea	(WaterDeformSects).l,a3			; Prepare water deformation section information
	bra.w	ApplyBGHScroll				; Apply HScroll

; -------------------------------------------------------------------------------

CloudSectSizes:						; Top cloud section sizes
	dc.b	2-1
	dc.b	4-1
	dc.b	6-1
	dc.b	8-1
	dc.b	8-1
	dc.b	8-1
	dc.b	4-1
	dc.b	6-1
	dc.b	6-1
	dc.b	4-1

CloudUpsideDownSectSizes:				; Upside down and bottom cloud section sizes
	dc.b	2-1
	dc.b	4-1
	dc.b	6-1
	dc.b	8-1
	dc.b	16-1
	dc.b	4-1
	dc.b	10-1
	dc.b	4-1
	dc.b	2-1
	even

WaterDeformSects:					; Water deform section positions and sizes
	dc.w	$280, $E0
	dc.w	$780, $80
	dc.w	$7FFF, $360
; ===========================================================================
ApplyBGHScroll:
ApplyDeformation:
	cmp.w	(a3),d4					; Is the background scrolled past the current water section?
	bcc.s	@FoundWaterSection			; If so, branch

@ScrollUnmodified:
	andi.w	#7,d2					; Get the number of lines to scroll for the first block of lines
	sub.w	d2,d4
	addq.w	#8,d4
	add.w	d2,d2

	move.w	(a2)+,d0				; Start scrolling
	jmp	@ScrollBlock(pc,d2.w)

@ScrollLoop:
	tst.w	d1					; Are we done scrolling?
	bmi.s	@End					; If so, branch
	cmp.w	(a3),d4					; Is the background scrolled past the current water section?
	bcc.s	@FoundWaterSection			; If so, branch

	addq.w	#8,d4					; Scroll another block of lines
	move.w	(a2)+,d0

@ScrollBlock:
	rept	8					; Scroll a block of 8 lines
		move.l	d0,(a1)+
	endr
	dbf	d1,@ScrollLoop				; Loop until finished

@End:
	rts

@FoundWaterSection:
	move.w	d4,d5					; Determine how deep we are into the section
	sub.w	(a3),d5
	move.w	2(a3),d6				; Get number of scanlines to scroll
	sub.w	d5,d6
	bcs.s	@SectOffscreen				; If the section is offscreen now, branch
	beq.s	@NextSection

	move.w	#224,d3					; Get base water deformation speed
	move.w	(v_cam_bg_x).w,d0
	move.w	(v_cam_fg_x).w,d2
	sub.w	d0,d2
	ext.l	d2
	asl.l	#8,d2
	divs.w	d3,d2
	ext.l	d2
	asl.l	#8,d2
	moveq	#0,d3
	move.w	d0,d3

	subq.w	#1,d5					; Get number of scanlines in which the section is offscreen
	bmi.s	@GotStartWaterSpeed			; to help get the starting water deformation speed

@GetStartWaterSpeed:
	move.w	d3,d0					; Increment starting water deformation speed
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d5,@GetStartWaterSpeed			; Loop until we got it

@GotStartWaterSpeed:
	move.w	d6,d5					; Decrement section size from scroll block count
	lsr.w	#3,d5
	sub.w	d5,d1
	bcc.s	@StartWaterDeform			; If we still have some scroll blocks left over, branch

	move.w	d1,d5					; Shrink the size of the section down to fit only up to the bottom of the screen
	neg.w	d5
	lsl.w	#3,d5
	sub.w	d5,d6
	beq.s	@NextSection				; If the size of the section shrinks down to 0 pixels, branch

@StartWaterDeform:
	subq.w	#1,d6					; Prepare section size

@DoWaterDeform:
	move.w	d3,d0					; Scroll line
	neg.w	d0
	move.l	d0,(a1)+

	swap	d3					; Increment water deformation speed
	add.l	d2,d3
	swap	d3

	addq.w	#1,d4					; Next line
	move.w	d4,d0
	andi.w	#7,d0					; Have we crossed a block?
	bne.s	@NextLine				; If not, branch
	addq.w	#2,a2					; Skip block in the deformation buffer

@NextLine:
	dbf	d6,@DoWaterDeform			; Loop until section is scrolled

@NextSection:
	addq.w	#4,a3					; Next section
	bra.w	@ScrollLoop				; Start scrolling regular blocks of lines again

@SectOffscreen:
	addq.w	#4,a3					; Next section
	move.w	d4,d2					; Start scrolling regular blocks of lines again
	bra.w	@ScrollUnmodified
; ===========================================================================

SetScrollFlagsBG:
		move.l	(v_cam_bg_x).w,d2			; Scroll horizontally
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,(v_cam_bg_x).w

	move.l	d0,d1					; Check if a block has been crossed and set flags accordingly
	swap	d1
	andi.w	#$10,d1
	move.b	(v_horiz_blk_cross_flag_bg).w,d3
	eor.b	d3,d1
	bne.s	@ChkY
	eori.b	#$10,(v_horiz_blk_cross_flag_bg).w
	sub.l	d2,d0
	bpl.s	@MoveRight
	bset	#2,(v_scroll_flags_bg).w
	bra.s	@ChkY

@MoveRight:
	bset	#3,(v_scroll_flags_bg).w

; -------------------------------------------------------------------------------

@ChkY:
	move.l	(v_cam_bg_y).w,d3			; Scroll vertically
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,(v_cam_bg_y).w

	move.l	d0,d1					; Check if a block has been crossed and set flags accordingly
	swap	d1
	andi.w	#$10,d1
	move.b	(v_verti_blk_cross_flag_bg).w,d2
	eor.b	d2,d1
	bne.s	@End
	eori.b	#$10,(v_verti_blk_cross_flag_bg).w
	sub.l	d3,d0
	bpl.s	@MoveDown
	bset	#0,(v_scroll_flags_bg).w
	rts

@MoveDown:
	bset	#1,(v_scroll_flags_bg).w

@End:
	rts
; ===========================================================================

SetVertiScrollFlagsBG:
	move.l	(v_cam_bg_y).w,d3			; Scroll vertically
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,(v_cam_bg_y).w

	move.l	d0,d1					; Check if a block has been crossed and set flags accordingly
	swap	d1
	andi.w	#$10,d1
	move.b	(v_verti_blk_cross_flag_bg).w,d2
	eor.b	d2,d1
	bne.s	@End
	eori.b	#$10,(v_verti_blk_cross_flag_bg).w
	sub.l	d3,d0
	bpl.s	@MoveDown
	bset	#4,(v_scroll_flags_bg).w
	rts

@MoveDown:
	bset	#5,(v_scroll_flags_bg).w

@End:
	rts
; ===========================================================================

SetVertiScrollFlagsBG2:
	move.w	(v_cam_bg_y).w,d3			; Set new position
	move.w	d0,(v_cam_bg_y).w

	move.w	d0,d1					; Check if a block has been crossed and set flags accordingly
	andi.w	#$10,d1
	move.b	(v_verti_blk_cross_flag_bg).w,d2
	eor.b	d2,d1
	bne.s	@End
	eori.b	#$10,(v_verti_blk_cross_flag_bg).w
	sub.w	d3,d0
	bpl.s	@MoveDown
	bset	#0,(v_scroll_flags_bg).w
	rts

@MoveDown:
	bset	#1,(v_scroll_flags_bg).w

@End:
	rts
; ===========================================================================

SetHorizScrollFlagsBG:
	move.l	(v_cam_bg_x).w,d2			; Scroll horizontally
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,(v_cam_bg_x).w

	move.l	d0,d1					; Check if a block has been crossed and set flags accordingly
	swap	d1
	andi.w	#$10,d1
	move.b	(v_horiz_blk_cross_flag_bg).w,d3
	eor.b	d3,d1
	bne.s	@End
	eori.b	#$10,(v_horiz_blk_cross_flag_bg).w
	sub.l	d2,d0
	bpl.s	@MoveRight
	bset	d6,(v_scroll_flags_bg).w
	bra.s	@End

@MoveRight:
	addq.b	#1,d6
	bset	d6,(v_scroll_flags_bg).w

@End:
	rts
; ===========================================================================

SetHorizScrollFlagsBG2:
	move.l	(v_cam_bg2_x).w,d2			; Scroll horizontally
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,(v_cam_bg2_x).w

	move.l	d0,d1					; Check if a block has been crossed and set flags accordingly
	swap	d1
	andi.w	#$10,d1
	move.b	(v_horiz_blk_cross_flag_bg2).w,d3
	eor.b	d3,d1
	bne.s	@End
	eori.b	#$10,(v_horiz_blk_cross_flag_bg2).w
	sub.l	d2,d0
	bpl.s	@MoveRight
	bset	d6,(v_scroll_flags_bg2).w
	bra.s	@End


@MoveRight:
	addq.b	#1,d6
	bset	d6,(v_scroll_flags_bg2).w

@End:
	rts
; ===========================================================================

SetHorizScrollFlagsBG3:
	move.l	(v_cam_bg3_x).w,d2			; Scroll horizontally
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,(v_cam_bg3_x).w

	move.l	d0,d1					; Check if a block has been crossed and set flags accordingly
	swap	d1
	andi.w	#$10,d1
	move.b	(v_horiz_blk_cross_flag_bg3).w,d3
	eor.b	d3,d1
	bne.s	@End
	eori.b	#$10,(v_horiz_blk_cross_flag_bg3).w
	sub.l	d2,d0
	bpl.s	@MoveRight
	bset	d6,(v_scroll_flags_bg3).w
	bra.s	@End

@MoveRight:
	addq.b	#1,d6
	bset	d6,(v_scroll_flags_bg3).w

@End:
	rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Labyrinth Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_LZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#7,d4
		move.w	(v_scrshifty).w,d5
		ext.l	d5
		asl.l	#7,d5
		bsr.w	ScrollBlock1
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#223,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		move.w	(v_bgscreenposx).w,d0
		neg.w	d0

loc_63C6:
		move.l	d0,(a1)+
		dbf	d1,loc_63C6
		move.w	(v_waterpos1).w,d0
		sub.w	(v_screenposy).w,d0
		rts	
; End of function Deform_LZ

; ---------------------------------------------------------------------------
; Marble Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_MZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#6,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4
		moveq	#0,d5
		bsr.w	ScrollBlock1
		move.w	#$200,d0
		move.w	(v_screenposy).w,d1
		subi.w	#$1C8,d1
		bcs.s	loc_6402
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		asr.w	#2,d1
		add.w	d1,d0

loc_6402:
		move.w	d0,(v_bg2screenposy).w
		bsr.w	ScrollBlock3
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#223,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		move.w	(v_bgscreenposx).w,d0
		neg.w	d0

loc_6426:
		move.l	d0,(a1)+
		dbf	d1,loc_6426
		rts	
; End of function Deform_MZ

; ---------------------------------------------------------------------------
; Star Light Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SLZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#7,d4
		move.w	(v_scrshifty).w,d5
		ext.l	d5
		asl.l	#7,d5
		bsr.w	ScrollBlock2
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		bsr.w	Deform_SLZ_2
		lea	(v_bgscroll_buffer).w,a2
		move.w	(v_bgscreenposy).w,d0
		move.w	d0,d2
		subi.w	#$C0,d0
		andi.w	#$3F0,d0
		lsr.w	#3,d0
		lea	(a2,d0.w),a2
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#$E,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		andi.w	#$F,d2
		add.w	d2,d2
		move.w	(a2)+,d0
		jmp	loc_6482(pc,d2.w)
; ===========================================================================

loc_6480:
		move.w	(a2)+,d0

loc_6482:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_6480
		rts	
; End of function Deform_SLZ


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SLZ_2:
		lea	(v_bgscroll_buffer).w,a1
		move.w	(v_screenposx).w,d2
		neg.w	d2
		move.w	d2,d0
		asr.w	#3,d0
		sub.w	d2,d0
		ext.l	d0
		asl.l	#4,d0
		divs.w	#$1C,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0
		moveq	#0,d3
		move.w	d2,d3
		move.w	#$1B,d1

loc_64CE:
		move.w	d3,(a1)+
		swap	d3
		add.l	d0,d3
		swap	d3
		dbf	d1,loc_64CE
		move.w	d2,d0
		asr.w	#3,d0
		move.w	#4,d1

loc_64E2:
		move.w	d0,(a1)+
		dbf	d1,loc_64E2
		move.w	d2,d0
		asr.w	#2,d0
		move.w	#4,d1

loc_64F0:
		move.w	d0,(a1)+
		dbf	d1,loc_64F0
		move.w	d2,d0
		asr.w	#1,d0
		move.w	#$1D,d1

loc_64FE:
		move.w	d0,(a1)+
		dbf	d1,loc_64FE
		rts	
; End of function Deform_SLZ_2

; ---------------------------------------------------------------------------
; Spring Yard Zone background layer deformation	code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SYZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#6,d4
		move.w	(v_scrshifty).w,d5
		ext.l	d5
		asl.l	#4,d5
		move.l	d5,d1
		asl.l	#1,d5
		add.l	d1,d5
		bsr.w	ScrollBlock1
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#223,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		move.w	(v_bgscreenposx).w,d0
		neg.w	d0

loc_653C:
		move.l	d0,(a1)+
		dbf	d1,loc_653C
		rts	
; End of function Deform_SYZ

; ---------------------------------------------------------------------------
; Scrap	Brain Zone background layer deformation	code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SBZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#6,d4
		move.w	(v_scrshifty).w,d5
		ext.l	d5
		asl.l	#4,d5
		asl.l	#1,d5
		bsr.w	ScrollBlock1
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#223,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		move.w	(v_bgscreenposx).w,d0
		neg.w	d0

loc_6576:
		move.l	d0,(a1)+
		dbf	d1,loc_6576
		rts	
; End of function Deform_SBZ

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level horizontally as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollHoriz:
	move.w	(v_cam_fg_x).w,d4			; Handle camera movement
	bsr.s	MoveScreenHoriz
	move.w	(v_cam_fg_x).w,d0			; Check if a block has been crossed and set flags accordingly
	andi.w	#$10,d0
	move.b	(v_horiz_blk_crossed_flag).w,d1
	eor.b	d1,d0
	bne.s	@End
	eori.b	#$10,(v_horiz_blk_crossed_flag).w
	move.w	(v_cam_fg_x).w,d0
	sub.w	d4,d0
	bpl.s	@Forward
	
	bset	#2,(v_scroll_flags).w
	rts

@Forward:
	bset	#3,(v_scroll_flags).w

@End:
	rts	
; End of function ScrollHoriz


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MoveScreenHoriz:
	move.w	(v_player+oX).w,d0			; Get the distance scrolled
	sub.w	(v_cam_fg_x).w,d0
	sub.w	(v_cam_x_center).w,d0
	beq.s	@AtDest					; If not scrolled at all, branch
	bcs.s	MoveScreenHoriz_CamBehind		; If scrolled to the left, branch
	bra.s	MoveScreenHoriz_CamAhead		; If scrolled to the right, branch

@AtDest:
	clr.w	(v_scroll_diff_x).w			; Didn't scroll at all
	rts

MoveScreenHoriz_CamAhead:
	cmpi.w	#16,d0					; Have we scrolled past 16 pixels?
	blt.s	@CapSpeed				; If not, branch
	move.w	#16,d0					; Cap at 16 pixels

@CapSpeed:
	add.w	(v_cam_fg_x).w,d0			; Have we gone past the right boundary?
	cmp.w	(v_right_bound).w,d0
	blt.s	MoveScreenHoriz_MoveCam			; If not, branch
	move.w	(v_right_bound).w,d0			; Cap at the right boundary

MoveScreenHoriz_MoveCam:
	move.w	d0,d1					; Update camera position
	sub.w	(v_cam_fg_x).w,d1
	asl.w	#8,d1
	move.w	d0,(v_cam_fg_x).w
	move.w	d1,(v_scroll_diff_x).w			; Get scroll delta
	rts

MoveScreenHoriz_CamBehind:
	cmpi.w	#-16,d0					; Have we scrolled past 16 pixels?
	bge.s	@CapSpeed				; If not, branch
	move.w	#-16,d0					; Cap at 16 pixels

@CapSpeed:
	add.w	(v_cam_fg_x).w,d0			; Have we gone past the left boundary?
	cmp.w	(v_left_bound).w,d0
	bgt.s	MoveScreenHoriz_MoveCam			; If not, branch
	move.w	(v_left_bound).w,d0			; Cap at the left boundary
	bra.s	MoveScreenHoriz_MoveCam

; -------------------------------------------------------------------------------
; Shift the camera horizontally
; -------------------------------------------------------------------------------
; PARAMETERS:
;	d0.w	- Scroll direction
; -------------------------------------------------------------------------------

ShiftCameraHoriz:
	tst.w	d0					; Are we shifting to the right?
	bpl.s	@MoveRight				; If so, branch
	move.w	#-2,d0					; Shift to the left
	bra.s	MoveScreenHoriz_CamBehind

@MoveRight:
	move.w	#2,d0					; Shift to the right
	bra.s	MoveScreenHoriz_CamAhead

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level vertically as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollVertical:
	moveq	#0,d1					; Get how far we have scrolled vertically
	move.w	(v_player+oY).w,d0
	sub.w	(v_cam_fg_y).w,d0
	btst	#2,(v_player+oStatus).w			; Is the player rolling?
	beq.s	@NoRoll					; If not, branch
	subq.w	#5,d0					; Account for the different height

@NoRoll:
	btst	#1,(v_player+oStatus).w			; Is the player in the air?
	beq.s	@OnGround				; If not, branch

	addi.w	#$20,d0
	sub.w	(v_cam_y_center).w,d0
	bcs.s	@DoScrollFast				; If the player is above the boundary, scroll to catch up
	subi.w	#$20*2,d0
	bcc.s	@DoScrollFast				; If the player is below the boundary, scroll to catch up

	tst.b	(v_btm_bound_shifting).w		; Is the bottom boundary shifting?
	bne.s	@StopCam				; If it is, branch
	bra.s	@DoNotScroll

@OnGround:
	sub.w	(v_cam_y_center).w,d0			; Subtract center position
	bne.s	@CamMoving				; If the player has moved, scroll to catch up
	tst.b	(v_btm_bound_shifting).w		; Is the bottom boundary shifting?
	bne.s	@StopCam				; If it is, branch

@DoNotScroll:
	clr.w	(v_scroll_diff_y).w			; Didn't scroll at all
	rts

; -------------------------------------------------------------------------------

@CamMoving:
	cmpi.w	#$60,(v_cam_y_center).w			; Is the camera center normal?
	bne.s	@DoScrollSlow				; If not, branch
	move.w	(v_player+oPlayerGVel).w,d1		; Get the player's ground velocity
	bpl.s	@DoScrollMedium
	neg.w	d1

@DoScrollMedium:
	cmpi.w	#8<<8,d1				; Is the player moving very fast?
	bcc.s	@DoScrollFast				; If they are, branch
	move.w	#6<<8,d1				; If the player is going too fast, cap the movement to 6 pixels/frame
	cmpi.w	#6,d0					; Is the player going down too fast?
	bgt.s	@MovingDown				; If so, move the camera at the capped speed
	cmpi.w	#-6,d0					; Is the player going up too fast?
	blt.s	@MovingUp				; If so, move the camera at the capped speed
	bra.s	@GotCamSpeed				; Otherwise, move the camera at the player's speed

@DoScrollSlow:
	move.w	#2<<8,d1				; If the player is going too fast, cap the movement to 2 pixels/frame
	cmpi.w	#2,d0					; Is the player going down too fast?
	bgt.s	@MovingDown				; If so, move the camera at the capped speed
	cmpi.w	#-2,d0					; Is the player going up too fast?
	blt.s	@MovingUp				; If so, move the camera at the capped speed
	bra.s	@GotCamSpeed				; Otherwise, move the camera at the player's speed

@DoScrollFast:
	move.w	#16<<8,d1				; If the player is going too fast, cap the movement to 16 pixels/frame
	cmpi.w	#16,d0					; Is the player going down too fast?
	bgt.s	@MovingDown				; If so, move the camera at the capped speed
	cmpi.w	#-16,d0					; Is the player going up too fast?
	blt.s	@MovingUp				; If so, move the camera at the capped speed
	bra.s	@GotCamSpeed				; Otherwise, move the camera at the player's speed

; -------------------------------------------------------------------------------

@StopCam:
	moveq	#0,d0					; Stop the camera
	move.b	d0,(v_btm_bound_shifting).w		; Clear bottom boundary shifting flag

@GotCamSpeed:
	moveq	#0,d1
	move.w	d0,d1					; Get position difference
	add.w	(v_cam_fg_y).w,d1			; Add old camera Y position
	tst.w	d0					; Is the camera scrolling down?
	bpl.w	@ChkBottom				; If so, branch
	bra.w	@ChkTop

@MovingUp:
	neg.w	d1					; Make the value negative
	ext.l	d1
	asl.l	#8,d1					; Move this into the upper word to align with the camera's Y position variable
	add.l	(v_cam_fg_y).w,d1			; Shift the camera over
	swap	d1					; Get the proper Y position

@ChkTop:
	cmp.w	(v_top_bound).w,d1			; Is the new position past the top boundary?
	bgt.s	@MoveCam				; If not, branch
	cmpi.w	#-$100,d1				; Is Y wrapping enabled?
	bgt.s	@CapTop					; If not, branch
	andi.w	#$7FF,d1				; Apply wrapping
	andi.w	#$7FF,(v_player+oY).w
	andi.w	#$7FF,(v_cam_fg_y).w
	andi.w	#$3FF,(v_cam_bg_y).w
	bra.s	@MoveCam

; -------------------------------------------------------------------------------

@CapTop:
	move.w	(v_top_bound).w,d1			; Cap at the top boundary
	bra.s	@MoveCam

@MovingDown:
	ext.l	d1
	asl.l	#8,d1					; Move this into the upper word to align with the camera's Y position variable
	add.l	(v_cam_fg_y).w,d1			; Shift the camera over
	swap	d1					; Get the proper Y position

@ChkBottom:
	cmp.w	(v_bottom_bound).w,d1			; Is the new position past the bottom boundary?
	blt.s	@MoveCam				; If not, branch
	subi.w	#$800,d1				; Should we wrap?
	bcs.s	@CapBottom				; If not, branch
	andi.w	#$7FF,(v_player+oY).w			; Apply wrapping
	subi.w	#$800,(v_cam_fg_y).w
	andi.w	#$3FF,(v_cam_bg_y).w
	bra.s	@MoveCam

; -------------------------------------------------------------------------------

@CapBottom:
	move.w	(v_bottom_bound).w,d1			; Cap at the bottom boundary

@MoveCam:
	move.w	(v_cam_fg_y).w,d4			; Update the camera position and get the scroll delta
	swap	d1
	move.l	d1,d3
	sub.l	(v_cam_fg_y).w,d3
	ror.l	#8,d3
	move.w	d3,(v_scroll_diff_y).w
	move.l	d1,(v_cam_fg_y).w

	move.w	(v_cam_fg_y).w,d0			; Check if a block has been crossed and set flags accordingly
	andi.w	#$10,d0
	move.b	(v_verti_blk_crossed_flag).w,d1
	eor.b	d1,d0
	bne.s	@End
	eori.b	#$10,(v_verti_blk_crossed_flag).w
	move.w	(v_cam_fg_y).w,d0
	sub.w	d4,d0
	bpl.s	@Downward
	bset	#0,(v_scroll_flags).w
	rts

@Downward:
	bset	#1,(v_scroll_flags).w

@End:
	rts
; End of function ScrollVertical


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock1:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	($FFFFF74C).w,d3
		eor.b	d3,d1
		bne.s	loc_679C
		eori.b	#$10,($FFFFF74C).w
		sub.l	d2,d0
		bpl.s	loc_6796
		bset	#2,(v_bg1_scroll_flags).w
		bra.s	loc_679C
; ===========================================================================

loc_6796:
		bset	#3,(v_bg1_scroll_flags).w

loc_679C:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	($FFFFF74D).w,d2
		eor.b	d2,d1
		bne.s	locret_67D0
		eori.b	#$10,($FFFFF74D).w
		sub.l	d3,d0
		bpl.s	loc_67CA
		bset	#0,(v_bg1_scroll_flags).w
		rts	
; ===========================================================================

loc_67CA:
		bset	#1,(v_bg1_scroll_flags).w

locret_67D0:
		rts	
; End of function ScrollBlock1


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock2:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	($FFFFF74D).w,d2
		eor.b	d2,d1
		bne.s	locret_6812
		eori.b	#$10,($FFFFF74D).w
		sub.l	d3,d0
		bpl.s	loc_680C
		bset	#0,(v_bg1_scroll_flags).w
		rts	
; ===========================================================================

loc_680C:
		bset	#1,(v_bg1_scroll_flags).w

locret_6812:
		rts	
; End of function ScrollBlock2


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock3:
		move.w	(v_bgscreenposy).w,d3
		move.w	d0,(v_bgscreenposy).w
		move.w	d0,d1
		andi.w	#$10,d1
		move.b	($FFFFF74D).w,d2
		eor.b	d2,d1
		bne.s	locret_6842
		eori.b	#$10,($FFFFF74D).w
		sub.w	d3,d0
		bpl.s	loc_683C
		bset	#0,(v_bg1_scroll_flags).w
		rts	
; ===========================================================================

loc_683C:
		bset	#1,(v_bg1_scroll_flags).w

locret_6842:
		rts	
; End of function ScrollBlock3


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock4:
		move.w	(v_bg2screenposx).w,d2
		move.w	(v_bg2screenposy).w,d3
		move.w	(v_scrshiftx).w,d0
		ext.l	d0
		asl.l	#7,d0
		add.l	d0,(v_bg2screenposx).w
		move.w	(v_bg2screenposx).w,d0
		andi.w	#$10,d0
		move.b	($FFFFF74E).w,d1
		eor.b	d1,d0
		bne.s	locret_6884
		eori.b	#$10,($FFFFF74E).w
		move.w	(v_bg2screenposx).w,d0
		sub.w	d2,d0
		bpl.s	loc_687E
		bset	#2,(v_bg2_scroll_flags).w
		bra.s	locret_6884
; ===========================================================================

loc_687E:
		bset	#3,(v_bg2_scroll_flags).w

locret_6884:
		rts	
; End of function ScrollBlock4
