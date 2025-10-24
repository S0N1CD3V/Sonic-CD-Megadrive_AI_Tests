ObjCapsule:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjCapsule_Index(pc,d0.w),d0
	jsr	ObjCapsule_Index(pc,d0.w)
	tst.b	oRoutine(a0)
	beq.s	@End
	cmpi.b	#$A,oRoutine(a0)
	beq.s	@Display
	cmpi.b	#6,oRoutine(a0)
	bcc.s	@End

@Display:
	jmp	DrawObject

; -------------------------------------------------------------------------------

@End:
	rts
; End of function ObjCapsule

; -------------------------------------------------------------------------------
ObjCapsule_Index:dc.w	ObjCapsule_Init-ObjCapsule_Index
	dc.w	ObjCapsule_Main-ObjCapsule_Index
	dc.w	ObjCapsule_Explode-ObjCapsule_Index
	dc.w	LoadEndOfAct-ObjCapsule_Index
	dc.w	ObjCapsule_Signpost_Null-ObjCapsule_Index
	dc.w	ObjCapsule_FlowerSeeds-ObjCapsule_Index
; -------------------------------------------------------------------------------

ObjCapsule_Init:
	ori.b	#4,oRender(a0)
	addq.b	#2,oRoutine(a0)
	move.b	#4,oPriority(a0)
	move.l	#MapSpr_FlowerCapsule,4(a0)
	move.w	#$431,oTile(a0)
	move.b	#$20,oXRadius(a0)
	move.b	#$20,oWidth(a0)
	move.b	#$18,oYRadius(a0)
; End of function ObjCapsule_Init

; -------------------------------------------------------------------------------

ObjCapsule_Main:
	lea	(Ani_FlowerCapsule).l,a1
	jsr	AnimateObject
	lea	(v_player).w,a6
	bsr.w	ObjCapsule_CheckCollision
	beq.s	@End
	clr.b	(v_update_time).l
	move.b	#2,oMapFrame(a0)
	move.b	#$78,oVar2A(a0)
	addq.b	#2,oRoutine(a0)
	move.w	(v_player+oX).w,d0
	move.b	(v_player+oXRadius).w,d1
	ext.w	d1
	addi.w	#$20,d1
	sub.w	8(a0),d0
	add.w	d1,d0
	bmi.s	@BounceX
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	@BounceX
	move.w	(v_player+oYVel).w,d0
	neg.w	d0
	asr.w	#2,d0
	move.w	d0,(v_player+oYVel).w
	rts

; -------------------------------------------------------------------------------

@BounceX:
	move.w	(v_player+oXVel).w,d0
	neg.w	d0
	asr.w	#2,d0
	move.w	d0,(v_player+oXVel).w

@End:
	rts
; End of function ObjCapsule_Main

; -------------------------------------------------------------------------------

ObjCapsule_Explode:
	subq.b	#1,oVar2A(a0)
	bmi.s	@FinishUp
	move.b	oVar2A(a0),d0
	move.b	d0,d1
	andi.b	#3,d1
	bne.s	@End
	lsr.w	#2,d0
	andi.w	#7,d0
	add.w	d0,d0
	lea	ObjCapsule_ExplosionLocs(pc,d0.w),a2
	jsr	FindObjSlot
	bne.s	@End
	move.w	#sfx_HitBoss,d0
	jsr	PlaySound_Special
	move.b	#$3F,oID(a1) ;Load Boss Explosion
	move.b	#1,oRoutine2(a1)
	move.w	oX(a0),oX(a1)
	move.w	oY(a0),oY(a1)
	move.b	(a2),d0
	ext.w	d0
	add.w	d0,oX(a1)
	move.b	1(a2),d0
	ext.w	d0
	add.w	d0,oY(a1)
	rts

; -------------------------------------------------------------------------------

@FinishUp:
	bsr.w	ObjCapsule_SpawnSeeds
	addq.b	#2,$24(a0)
	move.b	#$3C,$2A(a0)

@End:
	rts
; End of function ObjCapsule_Explode

; -------------------------------------------------------------------------------
ObjCapsule_ExplosionLocs:dc.b	0, 0
	dc.b	$20, $F8
	dc.b	$E0, 0
	dc.b	$E8, $F8
	dc.b	$18, 8
	dc.b	$F0, 8
	dc.b	$10, 8
	dc.b	$F8, $F8
; -------------------------------------------------------------------------------

ObjCapsule_SpawnSeeds:
	moveq	#0,d0
	move.b	(LevelPaletteID).l,d0
	move.l	d7,d6
	jsr	LoadPalette
	move.l	d6,d7
	moveq	#6,d6
	moveq	#0,d1

@Loop:
	jsr	FindObjSlot
	bne.s	@End
	move.b	#$8F,oID(a1) ;Load Capsule
	ori.b	#4,oRender(a1)
	move.w	oX(a0),oX(a1)
	move.w	oY(a0),oY(a1)
	move.b	#$A,oRoutine(a1)
	move.l	#MapSpr_FlowerCapsule,oMap(a1)
	move.w	#$2481,oTile(a1)
	move.b	#1,oAnim(a1)
	move.w	#-$600,oYVel(a1)
	move.w	ObjCapsule_FlowerLocs(pc,d1.w),oXVel(a1)
	addq.w	#2,d1
	dbf	d6,@Loop

@End:
	rts
; End of function ObjCapsule_SpawnSeeds

; -------------------------------------------------------------------------------
ObjCapsule_FlowerLocs:dc.w	0
	dc.w	$FF80
	dc.w	$80
	dc.w	$FF00
	dc.w	$100
	dc.w	$FE80
	dc.w	$180
	dc.w	$FE00
	dc.w	$200
	dc.w	$FD80
	dc.w	$280
; -------------------------------------------------------------------------------

ObjCapsule_FlowerSeeds:
	lea	(Ani_FlowerCapsule).l,a1
	jsr	AnimateObject
	jsr	ObjectFall
	jsr	CheckFloorEdge
	tst.w	d1
	bpl.s	@End
	move.b	#0,oID(a0) ;Load Flower
	move.b	#1,oSubtype(a0)
	move.b	#0,oRoutine(a0)

@End:
	rts
; End of function ObjCapsule_FlowerSeeds

; -------------------------------------------------------------------------------

ObjCapsule_CheckCollision:
	btst	#2,oStatus(a6)
	beq.s	@NoCollide
	move.b	oXRadius(a6),d1
	ext.w	d1
	addi.w	#$20,d1
	move.w	oX(a6),d0
	sub.w	oX(a0),d0
	add.w	d1,d0
	bmi.s	@NoCollide
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	@NoCollide
	move.b	oYRadius(a6),d1
	ext.w	d1
	addi.w	#$1C,d1
	move.w	oY(a6),d0
	sub.w	oY(a0),d0
	add.w	d1,d0
	bmi.s	@NoCollide
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	@NoCollide
	moveq	#1,d0
	rts

; -------------------------------------------------------------------------------

@NoCollide:
	moveq	#0,d0
	rts
; End of function ObjCapsule_CheckCollision
ObjCapsule_Signpost_Null:
    rts
LevelPaletteID:
               dc.b	5                     ;Capsule Palette?
               dc.b	5                     ;Level Palette
MapSpr_FlowerCapsule:
	include	"flowercapsule/map.asm"
	even
Ani_FlowerCapsule:
	include	"flowercapsule/anim.asm"
	even
