oplayerstandobj equ objoff_3D
; ---------------------------------------------------------------------------
; Subroutine translating object	speed to update	object position
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SpeedToPos:
ObjMove:
	move.l	oX(a0),d2				; Get position
	move.l	oY(a0),d3

	move.w	oXVel(a0),d0				; Get X velocity

	btst	#3,oStatus(a0)				; Are we standing on an object?
	beq.s	@NotOnObj				; If not, branch

	moveq	#0,d1					; Get the object we are standing on
	move.b	oPlayerStandObj(a0),d1
	lsl.w	#6,d1
	addi.l	#v_objects&$FFFFFF,d1
	movea.l	d1,a1
	cmpi.b	#$1E,oID(a1)				; Is it a pinball flipper from CCZ?
	bne.s	@NotOnObj				; If not, branch

	move.w	#-$100,d1				; Get resistance value
	btst	#0,oStatus(a1)				; Is the object flipped?
	beq.s	@NotNeg					; If not, branch
	neg.w	d1					; Flip the resistance value

@NotNeg:
	add.w	d1,d0					; Apply resistance on the X velocity

@NotOnObj:
	ext.l	d0					; Apply X velocity
	asl.l	#8,d0
	add.l	d0,d2

	move.w	oYVel(a0),d0				; Apply Y velocity
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d3

	move.l	d2,oX(a0)				; Update position
	move.l	d3,oY(a0)
	rts

; End of function SpeedToPos