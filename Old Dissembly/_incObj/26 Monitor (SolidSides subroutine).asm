; ---------------------------------------------------------------------------
; Subroutine to	make the sides of a monitor solid
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Mon_SolidSides:
	cmpi.b	#$17,oAnim(a1)
	beq.w	@ClearTouch
	btst	#6,oPlayerCtrl(a1)
	bne.w	@ClearTouch
	cmpi.b	#6,oRoutine(a1)
	bcc.w	@ClearTouch
	tst.b	oID(a1)
	beq.w	@ClearTouch
	tst.b	oRender(a0)
	bpl.w	@ClearTouch
	tst.b	(v_debug_mode).l
	bne.w	@ClearTouch
	move.b	oWidth(a0),d1
	ext.w	d1
	addi.w	#$A,d1
	move.w	oX(a1),d0
	sub.w	oX(a0),d0
	add.w	d1,d0
	bmi.w	@ClearTouch
	move.w	d1,d2
	add.w	d2,d2
	cmp.w	d2,d0
	bcc.w	@ClearTouch
	cmpi.b	#$2B,oAnim(a1)
	bne.s	@NotGivingUp
	btst	#3,oStatus(a0)
	bne.s	@CheckYRange
	bra.w	@ClearTouch

; -------------------------------------------------------------------------------

@NotGivingUp:
	cmpi.b	#1,oRoutine2(a0)
	bne.s	@CheckYRange
	tst.w	oYVel(a1)
	beq.s	@CheckYRange
	bmi.w	@ClearTouch

@CheckYRange:
	move.b	oYRadius(a0),d2
	ext.w	d2
	move.b	oYRadius(a1),d3
	ext.w	d3
	add.w	d2,d3
	addq.w	#2,d3
	move.w	oY(a1),d2
	sub.w	oY(a0),d2
	add.w	d3,d2
	bmi.w	@ClearTouch
	move.w	d3,d4
	add.w	d4,d4
	cmp.w	d4,d2
	bcc.w	@ClearTouch
	move.w	d0,d4
	cmp.w	d0,d1
	bcc.s	@GotDistToXEdge
	add.w	d1,d1
	sub.w	d1,d0
	move.w	d0,d4
	neg.w	d4

@GotDistToXEdge:
	move.w	d2,d5
	cmp.w	d2,d3
	bcc.s	@GotDistToYEdge
	add.w	d3,d3
	sub.w	d3,d2
	move.w	d2,d5
	neg.w	d5

@GotDistToYEdge:
	cmp.w	d4,d5
	bcs.w	@CollideVert
	cmpi.b	#1,oRoutine2(a0)
	beq.w	@ClearTouch
	cmpi.b	#id_Springs,oID(a0)
	bne.s	@NotSpring
	btst	#1,oStatus(a1)
	bne.w	@ClearTouch

@NotSpring:
	cmpi.b	#4,d5
	bls.w	@ClearTouch
	bsr.w	CrushBetweenObjects
	move.l	d0,-(sp)
	bsr.w	ClearObjRide
	clr.b	oRoutine2(a0)
	move.l	(sp)+,d0
	sub.w	d0,oX(a1)
	tst.w	d0
	bmi.s	@PlayerLeft
	tst.w	oXVel(a1)
	beq.s	@LeaveXSpd
	bpl.s	@HaltOnX
	bra.s	@LeaveXSpd

; -------------------------------------------------------------------------------

@PlayerLeft:
	tst.w	oXVel(a1)
	beq.s	@LeaveXSpd
	bpl.s	@LeaveXSpd

@HaltOnX:
	bsr.w	CrushAgainstWall
	btst	#1,oStatus(a1)
	bne.s	@ClearXSpd
	bset	#5,oStatus(a1)
	bset	#5,oStatus(a0)
	move.w	#0,oPlayerGVel(a1)

@ClearXSpd:
	move.w	#0,oXVel(a1)
	moveq	#0,d0
	rts

; -------------------------------------------------------------------------------

@LeaveXSpd:
	bsr.w	ClearObjPush
	bsr.w	CrushAgainstWall
	bclr	#5,oStatus(a1)
	bclr	#5,oStatus(a0)
	moveq	#0,d0
	rts

; -------------------------------------------------------------------------------

@CollideVert:
	cmpi.b	#id_Monitor,oID(a0)
	bne.s	@NotMonitor
	btst	#2,oStatus(a1)
	bne.w	@ClearTouch

@NotMonitor:
	move.b	oYRadius(a0),d0
	ext.w	d0
	move.b	oYRadius(a1),d1
	ext.w	d1
	add.w	d0,d1
	tst.w	d2
	beq.s	@SonicAbove
	bmi.w	@SonicBelow

@SonicAbove:
	cmpi.b	#$2B,oAnim(a1)
	beq.s	@NotGivingUp2
	tst.w	oYVel(a1)
	beq.s	@NotGivingUp2
	bmi.w	@ClearTouch

@NotGivingUp2:
	move.w	oY(a0),oY(a1)
	sub.w	d1,oY(a1)
	moveq	#0,d1
	move.w	oXVel(a0),d1
	ext.l	d1
	asl.l	#8,d1
	move.l	oX(a1),d0
	add.l	d1,d0
	move.l	d0,oX(a1)
	move.b	#$C0,d0
	tst.w	oXVel(a0)
	beq.s	@MoveOnY
	bpl.s	@AbsSpeed
	neg.b	d0

@AbsSpeed:
	movem.l	a0-a1,-(sp)
	movea.l	a1,a0
	jsr	Player_CalcRoomInFront
	movem.l	(sp)+,a0-a1
	tst.w	d1
	bpl.s	@MoveOnY
	tst.w	oXVel(a0)
	bpl.s	@MoveOutOfWall
	neg.w	d1

@MoveOutOfWall:
	add.w	d1,oX(a1)

@MoveOnY:
	moveq	#0,d1
	move.w	oYVel(a0),d1
	ext.l	d1
	asl.l	#8,d1
	move.l	oY(a1),d0
	add.l	d1,d0
	move.l	d0,oY(a1)
	cmpi.b	#id_Springs,oID(a0)
	beq.s	@SetRide
	tst.w	oYVel(a0)
	bmi.s	@CheckCrushCeiling
	movem.l	a0-a1,-(sp)
	movea.l	a1,a0
	jsr	Player_CheckFloor
	movem.l	(sp)+,a0-a1
	tst.w	d1
	bpl.s	@CheckCrushCeiling
	add.w	d1,oY(a1)
	bra.w	@ClearTouch

; -------------------------------------------------------------------------------

@CheckCrushCeiling:
	tst.w	oYVel(a0)
	bpl.s	@SetRide
	movem.l	a0-a1,-(sp)
	movea.l	a1,a0
	jsr	Player_GetCeilDist
	movem.l	(sp)+,a0-a1
	tst.w	d1
	bpl.s	@SetRide
	movem.l	a0-a1,-(sp)
	movea.l	a1,a0
	jsr	KillSonic
	movem.l	(sp)+,a0-a1
	bra.s	@ClearTouch

; -------------------------------------------------------------------------------

@SetRide:
	bsr.w	RideObject
	moveq	#1,d0
	rts

; -------------------------------------------------------------------------------

@SonicBelow:
	cmpi.b	#1,oRoutine2(a0)
	beq.s	@ClearTouch
	cmpi.b	#id_SwingingPlatform,oID(a0)
	beq.s	@ClearTouch
	cmpi.b	#id_Springs,oID(a0)
	bne.s	@CheckCrushFloor
	cmpi.b	#2,oRoutine2(a0)
	beq.s	@AlignToBottom
	btst	#1,oRender(a0)
	bne.s	@AlignToBottom
	bra.s	@ClearTouch

; -------------------------------------------------------------------------------

@CheckCrushFloor:
	btst	#1,oStatus(a1)
	bne.s	@AlignToBottom
	tst.w	oYVel(a0)
	beq.s	@AlignToBottom
	bmi.s	@AlignToBottom
	movem.l	a0-a1,-(sp)
	movea.l	a1,a0
	jsr	KillSonic
	movem.l	(sp)+,a0-a1

@AlignToBottom:
	sub.w	d2,oY(a1)
	move.w	#0,oYVel(a1)
	bsr.w	ClearObjPush
	bsr.w	ClearObjRide
	clr.b	oRoutine2(a0)
	moveq	#1,d0
	rts

; -------------------------------------------------------------------------------

@ClearTouch:
	bsr.w	ClearObjPush
	bsr.w	ClearObjRide
	clr.b	oRoutine2(a0)
	moveq	#0,d0
	rts
; End of function SolidObject
; End of function Obj26_SolidSides
Player_CalcRoomInFront:
CrushAgainstWall:
CrushBetweenObjects:
    rts
; -------------------------------------------------------------------------------
ClearObjPush:
	moveq	#0,d1
	move.b	oPlayerPushObj(a1),d1
	beq.s	@End
	lsl.w	#6,d1
	addi.l	#v_player&$FFFFFF,d1
	cmpa.w	d1,a0
	bne.s	@End
	move.b	#0,oPlayerPushObj(a1)

@End:
	rts
; End of function ClearObjPush
ClearObjRide:
	btst	#3,oStatus(a0)
	beq.s	@End
	btst	#3,oStatus(a1)
	beq.s	@End
	moveq	#0,d0
	move.b	oPlayerStandObj(a1),d0
	lsl.w	#6,d0
	addi.l	#v_player&$FFFFFF,d0
	cmpa.w	d0,a0
	bne.s	@End
	tst.b	oPlayerCharge(a1)
	beq.s	@NoSound
	move.w	#$AB,d0
	jsr	PlaySound

@NoSound:
	clr.b	oPlayerStick(a1)
	bset	#1,oStatus(a1)
	bclr	#3,oStatus(a1)
	bclr	#3,oStatus(a0)
	btst	#6,oPlayerCtrl(a1)
	bne.s	@ReleasePlayer
	cmpi.b	#$17,oAnim(a1)
	beq.s	@ReleasePlayer
	bclr	#0,oPlayerCtrl(a1)

@ReleasePlayer:
	clr.b	oPlayerStandObj(a1)
	cmpi.b	#$2B,oAnim(a1)
	bne.s	@End
	bclr	#1,oStatus(a1)

@End:
	rts
; End of function ClearObjRide

; -------------------------------------------------------------------------------

RideObject:
	cmpi.b	#4,oRoutine(a1)
	bne.s	@NotHurt
	subq.b	#2,oRoutine(a1)
	move.w	#$78,oPlayerHurt(a1)

@NotHurt:
	clr.b	oRoutine2(a0)
	clr.b	oPlayerJump(a1)
	bset	#3,oStatus(a0)
	bne.s	@SetRide
	cmpi.b	#$2B,oAnim(a1)
	bne.s	@NotGivingUp
	bclr	#3,oStatus(a0)
	bra.w	ClearObjRide

; -------------------------------------------------------------------------------

@NotGivingUp:
	bclr	#4,oStatus(a1)
	bclr	#2,oStatus(a1)
	beq.s	@SetRide
	tst.b	(v_mini_sonic).l
	beq.s	@NotMini
	move.b	#$A,oYRadius(a1)
	move.b	#5,oXRadius(a1)
	subq.w	#2,oY(a1)
	bra.s	@SetWalk

; -------------------------------------------------------------------------------

@NotMini:
	move.b	#$13,oYRadius(a1)
	move.b	#9,oXRadius(a1)
	subq.w	#5,oY(a1)

@SetWalk:
	move.b	#0,oAnim(a1)

@SetRide:
	bset	#3,oStatus(a1)
	beq.s	@SetInteract
	moveq	#0,d0
	move.b	oPlayerStandObj(a1),d0
	lsl.w	#6,d0
	addi.l	#v_player&$FFFFFF,d0
	cmpa.w	d0,a0
	beq.s	@End
	movea.l	d0,a2
	bclr	#3,oStatus(a2)

@SetInteract:
	move.w	a0,d0
	subi.w	#v_player,d0
	lsr.w	#6,d0
	andi.w	#$7F,d0
	move.b	d0,oPlayerStandObj(a1)
	move.b	#0,oAngle(a1)
	move.w	#0,oYVel(a1)
	cmpi.b	#$A,oID(a0)
	bne.s	@SetInertia
	cmpi.b	#2,oRoutine(a0)
	beq.s	@ClearAirBit

@SetInertia:
	move.w	oXVel(a1),oPlayerGVel(a1)

@ClearAirBit:
	bclr	#1,oStatus(a1)

@End:
	rts
; End of function RideObject

; -------------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ObjSpring_SolidObject3

SolidObject2:
	move.b	#2,oRoutine2(a0)
	jmp	SolidObject
; END OF FUNCTION CHUNK	FOR ObjSpring_SolidObject3
; -------------------------------------------------------------------------------

SolidObject1:
	move.b	#1,oRoutine2(a0)
; End of function SolidObject1

; -------------------------------------------------------------------------------	
; -------------------------------------------------------------------------------
; Animate an object's sprite
; -------------------------------------------------------------------------------
; PARAMETERS:
;	a0.l	- Object RAM
; -------------------------------------------------------------------------------

AnimateMonitor:
	moveq	#0,d0					; Get current animation
	move.b	oAnim(a0),d0
	cmp.b	oPrevAnim(a0),d0			; Are we changing animations?
	beq.s	@Do					; If not, branch

	move.b	d0,oPrevAnim(a0)			; Reset animation flags
	move.b	#0,oAnimFrame(a0)
	move.b	#0,oAnimTime(a0)

@Do:
	subq.b	#1,oAnimTime(a0)
	bpl.s	@End
	add.w	d0,d0					; Get pointer to animation data
	adda.w	(a1,d0.w),a1
	move.b	(a1),oAnimTime(a0)			; Get animation speed

	moveq	#0,d1					; Get animation frame
	move.b	oAnimFrame(a0),d1
	move.b	1(a1,d1.w),d0
	bmi.s	@AniFF					; If it's a flag, branch

@AniNext:
	move.b	d0,d1					; Copy flip flags
	andi.b	#$1F,d0					; Set sprite frame
	move.b	d0,oMapFrame(a0)

	move.b	oStatus(a0),d0				; Apply status flip flags to render flip flags
	rol.b	#3,d1
	eor.b	d0,d1
	andi.b	#3,d1
	andi.b	#$FC,oRender(a0)
	or.b	d1,oRender(a0)

	addq.b	#1,oAnimFrame(a0)			; Update animation frame

@End:
	rts

; -------------------------------------------------------------------------------

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
	bne.s	@AniFC
	move.b	2(a1,d1.w),oAnim(a0)			; Set new animation ID

@AniFC:
	addq.b	#1,d0					; Is the flag $FC (increment routine ID)?
	bne.s	@AniFB					; If not, branch
	addq.b	#2,oRoutine(a0)				; Increment routine ID

@AniFB:
	addq.b	#1,d0					; Is the flag $FB (loop and reset secondary routine ID)?
	bne.s	@AniFA					; If not, branch
	move.b	#0,oAnimFrame(a0)			; Set animation script frame back to 0
	clr.b	oRoutine2(a0)				; Reset secondary routine ID

@AniFA:
	addq.b	#1,d0					; Is the flag $FA (increment secondary routine ID)?
	bne.s	@End2					; If not, branch
	addq.b	#2,oRoutine2(a0)			; Increment secondary routine ID

@End2:
	rts