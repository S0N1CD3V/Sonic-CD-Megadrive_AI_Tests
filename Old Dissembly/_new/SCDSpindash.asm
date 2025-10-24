; ---------------------------------------------------------------------------
; Subroutine to make Sonic perform a Spindash
; ---------------------------------------------------------------------------
; If you use this makes sure to search for ;Peelout in Sonic1.asm
; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

;SCDSpindash:
		btst	#0,$39(a0)
		bne.s	SCDSpindash_Launch
		cmpi.b	#8,obAnim(a0) ;check to see if your ducking
		bne.s	@return
		move.b	(v_jpadpress2).w,d0
		andi.b	#%01110000,d0
		beq.w	@return
		move.w	#0,$3A(a0)
		move.w	#$BE,d0
		jsr		(PlaySound_Special).l 	; Play spindash charge sound
	;	sfx 	sfx_PeeloutCharge 		; These are if you use AMPS
		addq.l	#4,sp
		bset	#0,$39(a0)
		move.w	#$16,obInertia(a0)

		move.b	#$E,$16(a0)
		move.b	#7,$17(a0)
		move.b	#2,obAnim(a0)	; use "rolling"	animation
		addq.w	#5,oby(a0)
		clr.w	obInertia(a0)
 
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos
 
	@return:
		rts	
; ---------------------------------------------------------------------------
 
SCDSpindash_Launch:
		move.b	(v_jpadhold2).w,d0
		btst	#1,d0
		bne.w	SCDSpindash_Charge
		bclr	#0,$39(a0)	; stop Dashing
		cmpi.b	#$2D,$3A(a0)	; have we been charging long enough?
		bne.w	SCDSpindash_Stop_Sound	; if not, branch
		move.b	#$22,obAnim(a0) ;charging spindash animation (walking to running to spindash sprites)

SCDSpindash_Launch2:
		move.b	#2,obAnim(a0)	; launches here (spindash sprites)
		bset	#2,obStatus(a0)	; set rolling bit
		move.w	#1,obVelX(a0)	; force X speed to nonzero for camera lag's benefit
		move.w	obInertia(a0),d0
		subi.w	#$800,d0
		add.w	d0,d0
		andi.w	#$1F00,d0
		neg.w	d0
		addi.w	#$2000,d0
		;move.w	d0,(v_cameralag).w
		btst	#0,obStatus(a0)
		beq.s	@dontflip
		neg.w	obInertia(a0)
 
@dontflip:
		bclr	#7,obStatus(a0)
		move.w	#$BC,d0
		jsr		(PlaySound_Special).l
	;	sfx 	sfx_PeeloutRelease
		bra.w	SCDSpindash_ResetScr
; ---------------------------------------------------------------------------
 
SCDSpindash_Charge:				; If still charging the dash...
		move.w	(v_sonspeedmax).w,d1	; get top spindash speed
		move.w	d1,d2
		add.w	d1,d1
		tst.b   (v_shoes).w 		; test for speed shoes
		beq.s	@noshoes
		asr.w	#1,d2
		sub.w	d2,d1

@noshoes:
		addi.w	#$64,obInertia(a0)		; increment speed
		cmp.w	obInertia(a0),d1
		bgt.s	@inctimer
		move.w	d1,obInertia(a0)

@inctimer:
		addq.b	#1,$3A(a0)		; increment timer
		cmpi.b	#$2D,$3A(a0)
		bcs.s	SCDSpindash_ResetScr
		move.b	#$2D,$3A(a0)
		jmp 	SCDSpindash_ResetScr
		
SCDSpindash_Stop_Sound:
		move.w	#$D3,d0
		jsr		(PlaySound_Special).l
	;	sfx 	sfx_PeeloutStop
		clr.w	obInertia(a0)
		move.b	#$13,$16(a0)
		move.b	#9,$17(a0)
		move.b	#5,obAnim(a0)		; use "standing" animation
		subq.w	#5,oby(a0)

SCDSpindash_ResetScr:
		addq.l	#4,sp			; increase stack ptr
		cmpi.w	#$60,(v_lookshift).w
		beq.s	@finish
		bcc.s	@skip
		addq.w	#4,(v_lookshift).w
 
	@skip:
		subq.w	#2,(v_lookshift).w
 
	@finish:
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos
		rts
		