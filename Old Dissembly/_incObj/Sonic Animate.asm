; ---------------------------------------------------------------------------
; Subroutine to	animate	Sonic's sprites
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Animate:
ObjSonic_Animate:
	lea	(SonicAniData).l,a1			; Get animation script

	moveq	#0,d0					; Get current animation
	move.b	oAnim(a0),d0
	cmp.b	oPrevAnim(a0),d0			; Are we changing animations?
	beq.s	@Do					; If not, branch

	move.b	d0,oPrevAnim(a0)			; Reset animation flags
	move.b	#0,oAnimFrame(a0)
	move.b	#0,oAnimTime(a0)

@Do:
	bsr.w	ObjSonic_GetMiniAnim			; If we are miniature, get the mini version of the current animation

	add.w	d0,d0					; Get pointer to animation data
	adda.w	(a1,d0.w),a1
	move.b	(a1),d0					; Get animation speed/special flag
	bmi.s	@SpecialAnim				; If it's a special flag, branch

	move.b	oStatus(a0),d1				; Apply status flip flags to render flip flags
	andi.b	#1,d1
	andi.b	#$FC,oRender(a0)
	or.b	d1,oRender(a0)

	subq.b	#1,oAnimTime(a0)			; Decrement frame duration time
	bpl.s	@AniDelay				; If it hasn't run out, branch
	move.b	d0,oAnimTime(a0)			; Reset frame duration time

; -------------------------------------------------------------------------------

@RunAnimScript:
	moveq	#0,d1					; Get animation frame
	move.b	oAnimFrame(a0),d1
	move.b	1(a1,d1.w),d0
	beq.s	@AniNext				; If it's a frame ID, branch
	bpl.s	@AniNext
	cmpi.b	#$FD,d0					; Is it a flag?
	bge.s	@AniFF					; If so, branch

@AniNext:
	move.b	d0,oMapFrame(a0)			; Update animation frame
	addq.b	#1,oAnimFrame(a0)

@AniDelay:
	rts

@AniFF:
	addq.b	#1,d0					; Is the flag $FF (loop)?
	bne.s	@AniFE					; If not, branch

	move.b	#0,oAnimFrame(a0)			; Set animation script frame back to 0
	move.b	1(a1),d0				; Get animation frame at that point
	bra.s	@AniNext

@AniFE:
	addq.b	#1,d0					; Is the flag $FE (loop back to frame)?
	bne.s	@AniFD

	move.b	2(a1,d1.w),d0				; Get animation script frame to go back to
	sub.b	d0,oAnimFrame(a0)
	sub.b	d0,d1					; Get animation frame at that point
	move.b	1(a1,d1.w),d0
	bra.s	@AniNext

@AniFD:
	addq.b	#1,d0					; Is the flag $FD (new animation)?
	bne.s	@End
	move.b	2(a1,d1.w),oAnim(a0)			; Set new animation ID

@End:
	rts

; -------------------------------------------------------------------------------

@SpecialAnim:
	subq.b	#1,oAnimTime(a0)			; Decrement frame duration time
	bpl.s	@AniDelay				; If it hasn't run out, branch

	addq.b	#1,d0					; Is this special animation $FF (walking/running)?
	bne.w	@RollAnim				; If not, branch

	tst.b	(v_mini_sonic).l			; Are we minature?
	bne.w	@MiniSonicRun				; If so, branch

	moveq	#0,d1					; Initialize flip flags
	move.b	oAngle(a0),d0				; Get angle
	move.b	oStatus(a0),d2				; Are we flipped horizontally?
	andi.b	#1,d2
	bne.s	@Flipped				; If so, branch
	not.b	d0					; If not, flip the angle

@Flipped:
	btst	#1,oPlayerCtrl(a0)			; Are we on a 3D ramp?
	bne.s	@3DRamp					; If so, branch
	addi.b	#$10,d0					; Center the angle
	bra.s	@CheckInvert				; Continue setting up the animation

@3DRamp:
	addq.b	#8,d0					; Center the angle for the 3D ramp

@CheckInvert:
	bpl.s	@NoInvert				; If we aren't on an angle where we should flip the sprite, branch
	moveq	#3,d1					; If we are, set the flip flags accordingly

@NoInvert:
	andi.b	#$FC,oRender(a0)			; Apply angle flip flags to render flip flags
	eor.b	d1,d2
	or.b	d2,oRender(a0)

	btst	#5,oStatus(a0)				; Are we pushing on something?
	bne.w	@PushAnim				; If so, branch

	move.w	oPlayerGVel(a0),d2			; Get ground speed
	bpl.s	@CheckSpeed
	neg.w	d2

@CheckSpeed:
	btst	#1,oPlayerCtrl(a0)			; Are we on a 3D ramp?
	beq.s	@No3DRamp				; If not, branch

	lsr.b	#4,d0					; Get offset of the angled sprites we need for 3D running
	lsl.b	#1,d0					; ((((angle + 8) / 8) & 0xE) * 2)
	andi.b	#$E,d0					; (angle is NOT'd if we are facing right)

	lea	(SonAni_Run3D).l,a1			; Get 3D running sprites
	bra.s	@GotRunAnim				; Continue setting up animation

@No3DRamp:
	lsr.b	#4,d0					; Get offset of the angled sprites we need for running and peelout
	andi.b	#6,d0					; ((((angle + 16) / 16) & 6) * 2)
							; (angle is NOT'd if we are facing right)

	lea	(SonAni_Peelout).l,a1			; Get peelout sprites
	cmpi.w	#$A00,d2				; Are we running at peelout speed?
	bcc.s	@GotRunAnim				; If so, branch
	lea	(SonAni_Run).l,a1			; Get running sprites
	cmpi.w	#$600,d2				; Are we running at running speed?
	bcc.s	@GotRunAnim				; If so, branch
	lea	(SonAni_Walk).l,a1			; Get walking sprites

	move.b	d0,d1					; Get offset of the angled sprites we need for walking
	lsr.b	#1,d1					; ((((angle + 16) / 16) & 6) * 3)
	add.b	d1,d0					; (angle is NOT'd if we are facing right)

@GotRunAnim:
	add.b	d0,d0

	move.b	d0,d3					; Get animation duration
	neg.w	d2					; max(-ground speed + 8, 0)
	addi.w	#$800,d2
	bpl.s	@BelowMax
	moveq	#0,d2

@BelowMax:
	lsr.w	#8,d2
	move.b	d2,oAnimTime(a0)

	bsr.w	@RunAnimScript				; Run animation script
	add.b	d3,oMapFrame(a0)			; Add angle offset
	rts

; -------------------------------------------------------------------------------

@RollAnim:
	addq.b	#1,d0					; Is this special animation $FE (rolling)?
	bne.s	@CheckPush				; If not, branch

	move.w	oPlayerGVel(a0),d2			; Get ground speed
	bpl.s	@CheckSpeed2
	neg.w	d2

@CheckSpeed2:
	lea	(SonAni_RollMini).l,a1			; Get mini rolling sprites
	tst.b	(v_mini_sonic).l			; Are we miniature?
	bne.s	@GotRollAnim				; If so, branch

	lea	(SonAni_RollFast).l,a1			; Get fast rolling sprites
	btst	#1,oPlayerCtrl(a0)			; Are we on a 3D ramp?
	beq.s	@No3DRoll				; If not, branch
	move.b	oAngle(a0),d0				; Are we going upwards on the ramp?
	addi.b	#$10,d0
	andi.b	#$C0,d0
	beq.s	@GotRollAnim				; If not, branch
	lea	(SonAni_Roll3D).l,a1			; Get 3D rolling sprites
	bra.s	@GotRollAnim				; Continue setting up animation

@No3DRoll:
	cmpi.w	#$600,d2				; Are we rolling fast?
	bcc.s	@GotRollAnim				; If so, branch
	lea	(SonAni_Roll).l,a1			; If not, use the regular rolling sprites

@GotRollAnim:
	neg.w	d2					; Get animation duration
	addi.w	#$400,d2				; max(-ground speed + 4, 0)
	bpl.s	@BelowMax2
	moveq	#0,d2

@BelowMax2:
	lsr.w	#8,d2
	move.b	d2,oAnimTime(a0)

	move.b	oStatus(a0),d1				; Apply status flip flags to render flip flags
	andi.b	#1,d1
	andi.b	#$FC,oRender(a0)
	or.b	d1,oRender(a0)

	bra.w	@RunAnimScript				; Run animation script

; -------------------------------------------------------------------------------

@CheckPush:
	addq.b	#1,d0					; Is this special animation $FD (pushing)?
	bne.s	@FrozenAnim				; If not, branch

@PushAnim:
	move.w	oPlayerGVel(a0),d2			; Get ground speed (negated)
	bmi.s	@CheckSpeed3
	neg.w	d2

@CheckSpeed3:
	addi.w	#$800,d2				; Get animation duration
	bpl.s	@BelowMax3				; max(-ground speed + 8, 0) * 4
	moveq	#0,d2

@BelowMax3:
	lsr.w	#6,d2
	move.b	d2,oAnimTime(a0)

	lea	(SonAni_PushMini).l,a1			; Get mini pushing sprites
	tst.b	(v_mini_sonic).l			; Are we miniature?
	bne.s	@GotPushAnim				; If so, branch
	lea	(SonAni_Push).l,a1			; Get normal pushing sprites

@GotPushAnim:
	move.b	oStatus(a0),d1				; Apply status flip flags to render flip flags
	andi.b	#1,d1
	andi.b	#$FC,oRender(a0)
	or.b	d1,oRender(a0)

	bra.w	@RunAnimScript				; Run animation script

; -------------------------------------------------------------------------------

@FrozenAnim:
	moveq	#0,d1					; This is special animation $FC (frozen animation)
	move.b	oAnimFrame(a0),d1			; Get animation frame
	move.b	1(a1,d1.w),oMapFrame(a0)
	move.b	#0,oAnimTime(a0)			; Keep duration at 0 and don't advance the animation frame
	rts

; -------------------------------------------------------------------------------

@MiniSonicRun:
	moveq	#0,d1					; Initialize flip flags
	move.b	oAngle(a0),d0				; Get angle
	move.b	oStatus(a0),d2				; Are we flipped horizontally?
	andi.b	#1,d2
	bne.s	@Flipped2				; If so, branch
	not.b	d0					; If not, flip the angle

@Flipped2:
	addi.b	#$10,d0					; Center the angle
	bpl.s	@NoFlip2				; If we aren't on an angle where we should flip the sprite, branch
	moveq	#0,d1					; If we are, then don't set the flags anyways

@NoFlip2:
	andi.b	#$FC,oRender(a0)			; Apply status horizontal flip flag to render flip flags
	or.b	d2,oRender(a0)

	addi.b	#$30,d0					; Are we running on the floor?
	cmpi.b	#$60,d0
	bcs.s	@MiniOnFloor				; If so, branch

	bset	#2,oStatus(a0)				; Mark as rolling
	move.b	#$A,oYRadius(a0)			; Set miniature rolling hitbox size
	move.b	#5,oXRadius(a0)
	move.b	#$FF,d0					; Go run the rolling animation instead
	bra.w	@RollAnim

@MiniOnFloor:
	move.w	oPlayerGVel(a0),d2			; Get ground speed
	bpl.s	@CheckSpeed4
	neg.w	d2

@CheckSpeed4:
	lea	(SonAni_RunMini).l,a1			; Get mini running sprites
	cmpi.w	#$600,d2				; Are we running at running speed?
	bcc.s	@GotRunAnim2				; If so, branch
	lea	(SonAni_WalkMini).l,a1			; Get mini walking sprites

@GotRunAnim2:
	neg.w	d2					; Get animation duration
	addi.w	#$800,d2				; max(-ground speed + 8, 0)
	bpl.s	@BelowMax4
	moveq	#0,d2

@BelowMax4:
	lsr.w	#8,d2
	move.b	d2,oAnimTime(a0)

	bra.w	@RunAnimScript				; Run animation script

; ===========================================================================
ObjSonic_GetMiniAnim:
	tst.b	(v_mini_sonic).l			; Are we miniatu
	beq.s	@End					; If not, branch
	move.b	@MiniAnims(pc,d0.w),d0			; Get mini a                            
@End:
	rts                           
; ------------------------------------------------------                           
@MiniAnims:
	dc.b	$21					; $00
	dc.b	$18					; $01
	dc.b	$23					; $02
	dc.b	$23					; $03
	dc.b	$27					; $04
	dc.b	$1F					; $05
	dc.b	$26					; $06
	dc.b	$28					; $07
	dc.b	$20					; $08
	dc.b	$09					; $09
	dc.b	$0A					; $0A
	dc.b	$0B					; $0B
	dc.b	$0C					; $0C
	dc.b	$24					; $0D
	dc.b	$0E					; $0E
	dc.b	$0F					; $0F
	dc.b	$28					; $10
	dc.b	$11					; $11
	dc.b	$12					; $12
	dc.b	$13					; $13
	dc.b	$14					; $14
	dc.b	$15					; $15
	dc.b	$16					; $16
	dc.b	$17					; $17
	dc.b	$18					; $18
	dc.b	$19					; $19
	dc.b	$25					; $1A
	dc.b	$25					; $1B
	dc.b	$1C					; $1C
	dc.b	$1D					; $1D
	dc.b	$1E					; $1E
	dc.b	$1F					; $1F
	dc.b	$20					; $20
	dc.b	$21					; $21
	dc.b	$22					; $22
	dc.b	$23					; $23
	dc.b	$24					; $24
	dc.b	$25					; $25
	dc.b	$26					; $26
	dc.b	$27					; $27
	dc.b	$28					; $28
	dc.b	$29					; $29
	dc.b	$2A					; $2A
	dc.b	$30					; $2B
	dc.b	$2C					; $2C
	dc.b	$2D					; $2D
	dc.b	$2E					; $2E
	dc.b	$2F					; $2F
	dc.b	$00					; $30
	dc.b	$00					; $31
	dc.b	$00					; $32
	dc.b	$00					; $33
	dc.b	$00					; $34
	dc.b	$00					; $35
	dc.b	$00					; $36
	dc.b	$00					; $37
	dc.b	$39					; $38
	dc.b	$00					; $39
	dc.b	$00					; $3A
	dc.b	$00					; $3B
	dc.b	$00					; $3C
	dc.b	$00					; $3D
	dc.b	$00					; $3E
	dc.b	$00					; $3F
	dc.b	$00					; $40
	dc.b	$00					; $41
	dc.b	$00					; $42
	dc.b	$00					; $43
	dc.b	$00					; $44
	dc.b	$00					; $45
	dc.b	$00					; $46
	dc.b	$00					; $47
	dc.b	$00					; $48
	dc.b	$00					; $49
	dc.b	$00					; $4A
	dc.b	$00					; $4B
	dc.b	$00					; $4C
	dc.b	$00					; $4D
	dc.b	$00					; $4E
	dc.b	$00					; $4F
SonicAniData:
	include "sonic\anim.asm"
	even
; ---------------------------------------------------------------------------
; Sonic	pattern	loading	subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LoadSonicDynPLC:			; XREF: Obj01_Control; et al
		moveq	#0,d0
		move.b	mapping_frame(a0),d0	; load frame number
		cmp.b	(v_sonframenum).w,d0
		beq.s	locret_13C96
		move.b	d0,(v_sonframenum).w
		lea	(SonicDynPLC).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		moveq	#0,d5
		move.b	(a2)+,d5
		subq.w	#1,d5
		bmi.s	locret_13C96
		move.w	#$F000,d4
		move.l	#Art_Sonic,d6

SPLC_ReadEntry:
		moveq	#0,d1
		move.b	(a2)+,d1
		lsl.w	#8,d1
		move.b	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,SPLC_ReadEntry	; repeat for number of entries

locret_13C96:
		rts	
; End of function LoadSonicDynPLC