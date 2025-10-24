; ---------------------------------------------------------------------------
; Subroutine to	make an	object fall downwards, increasingly fast
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjectFall:
ObjMoveGrv:
	move.l	oX(a0),d2				; Get position
	move.l	oY(a0),d3

	move.w	oXVel(a0),d0				; Apply X velocity
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d2

	move.w	oYVel(a0),d0				; Get Y velocity

	btst	#3,oPlayerCtrl(a0)			; Is gravity disabled (ignores the 3D ramp)?
	bne.s	@NoGravity				; If so, branch

	bpl.s	@CheckGravity				; If we are moving downwards, branch

	btst	#1,oPlayerCtrl(a0)			; Are we on a 3D ramp?
	beq.s	@CheckGravity				; If not, branch
	cmpi.w	#-$800,oYVel(a0)			; Are we going fast enough?
	bcs.s	@NoGravity				; If so, branch

@CheckGravity:
	btst	#2,oPlayerCtrl(a0)			; Is gravity disabled?
	bne.s	@NoGravity				; If so, branch
	addi.w	#$38,oYVel(a0)				; Apply gravity

@NoGravity:
	tst.w	oYVel(a0)				; Are we moving up?
	bmi.s	@NoDownVelCap				; If so, branch
	cmpi.w	#$1000,oYVel(a0)			; Are we falling down too fast?
	bcs.s	@NoDownVelCap				; If not, branch
	move.w	#$1000,oYVel(a0)			; Cap the fall speed

@NoDownVelCap:
	ext.l	d0					; Apply Y velocity
	asl.l	#8,d0
	add.l	d0,d3

	move.l	d2,oX(a0)				; Update position
	move.l	d3,oY(a0)
	rts

; End of function ObjectFall