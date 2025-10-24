; ---------------------------------------------------------------------------
; Subroutine to find a free object space

; output:
;	a1 = free position in object RAM
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Create_New_Sprite:
FindFreeObj:
		lea	(v_dyn_objects).w,a1
	move.w	#$5F,d0

@Find:
	tst.b	(a1)
	beq.s	@End
	lea	oVarLen(a1),a1
	dbf	d0,@Find

@End:
	rts
; End of function FindObjSlot

; -------------------------------------------------------------------------------
findnextfreeobj:
FindNextObjSlot:
	movea.l	a0,a1
	lea	oVarLen(a1),a1
	move.w	#v_objects_end,d0
	sub.w	a0,d0
	lsr.w	#6,d0
	subq.w	#2,d0
	bcs.s	@End

@Find:
	tst.b	(a1)
	beq.s	@End
	lea	oVarLen(a1),a1
	dbf	d0,@Find

@End:
	rts

; End of function FindNextFreeObj