Obj3DRamp:
	lea	(v_player).w,a6
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	tst.b	oSubtype2(a0)
	bne.w	Obj3DFall
	move.w	Obj3DRamp_Index(pc,d0.w),d0
	jsr	Obj3DRamp_Index(pc,d0.w)
	jsr	DrawObject
	move.w	oVar2A(a0),d0
	bra.w	CheckObjDespawn2Time
; End of function Obj3DRamp

; -------------------------------------------------------------------------------
Obj3DRamp_Index:dc.w	Obj3DRamp_Init-Obj3DRamp_Index
	dc.w	Obj3DRamp_Main-Obj3DRamp_Index
; -------------------------------------------------------------------------------

Obj3DRamp_Init:
	addq.b	#2,oRoutine(a0)
	move.b	#4,oRender(a0)
	move.b	#1,oPriority(a0)
	move.l	#MapSpr_3DRamp,oMap(a0)
	move.w	#$320,oTile(a0)
	move.b	#$20,oWidth(a0)
	move.b	#$20,oYRadius(a0)
	move.w	oX(a0),oVar2A(a0)
	tst.b	oSubtype(a0)
	beq.s	Obj3DRamp_Main
	bset	#0,oRender(a0)
	bset	#0,oStatus(a0)
; End of function Obj3DRamp_Init

; -------------------------------------------------------------------------------

Obj3DRamp_Main:
	tst.b	oVar2E(a0)
	beq.s	@TimeRunSet
	move.b	#1,oAnim(a0)
	btst	#1,oPlayerCtrl(a6)
	bne.s	@Animate
	addq.b	#1,oAnim(a0)

@Animate:
	lea	(Ani_3DRamp).l,a1
	jsr	AnimateObject
	bra.s	@GetChunkPos

; -------------------------------------------------------------------------------

@TimeRunSet:
	move.b	#0,oMapFrame(a0)
	moveq	#0,d1
	btst	#1,oPlayerCtrl(a6)
	beq.s	@Move3D

@GetChunkPos:
	move.w	oX(a6),d0
	andi.w	#$FF,d0
	tst.b	oSubtype(a0)
	beq.s	@NoFlip
	move.w	d0,d1
	move.w	#$FF,d0
	sub.w	d1,d0

@NoFlip:
	cmpi.w	#$C0,d0
	bcs.s	@GotChunkPos
	cmpi.w	#$F0,d0
	bcc.s	@CapChunkPos
	move.w	#$BF,d0
	bra.s	@GotChunkPos

; -------------------------------------------------------------------------------

@CapChunkPos:
	moveq	#0,d0

@GotChunkPos:
	ext.l	d0
	move.w	d0,d1
	tst.b	oVar2E(a0)
	bne.s	@KeepFrame
	divu.w	#$30,d0
	move.b	d0,oMapFrame(a0)

@KeepFrame:
	lsr.w	#2,d1
	move.w	d1,d2
	lsr.w	#1,d2
	add.w	d2,d1
	tst.b	oSubtype(a0)
	beq.s	@Move3D
	neg.w	d1

@Move3D:
	add.w	oVar2A(a0),d1
	move.w	d1,oX(a0)
	tst.b	oVar2E(a0)
	beq.s	@SkipTimer
	subq.b	#1,oVar2E(a0)
	bra.s	@ChkTouch

; -------------------------------------------------------------------------------

@SkipTimer:
	btst	#1,oStatus(a6)
	bne.s	@End

@ChkTouch:
	move.b	oWidth(a0),d1
	ext.w	d1
	move.w	oX(a6),d0
	sub.w	oX(a0),d0
	add.w	d1,d0
	bmi.s	@End
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	@End
	move.b	oYRadius(a0),d1
	ext.w	d1
	move.w	oY(a6),d0
	sub.w	oY(a0),d0
	add.w	d1,d0
	bmi.s	@End
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	@End
	cmpi.b	#$2B,oAnim(a6)
	beq.s	@End
	tst.b	oVar2E(a0)
	bne.s	@TimerSet
	move.b	#60,oVar2E(a0)

@TimerSet:
	tst.w	oYVel(a6)
	bpl.s	@LaunchDown
	move.w	#-$C00,oYVel(a6)
	rts

; -------------------------------------------------------------------------------

@LaunchDown:
	move.w	#$C00,oYVel(a6)

@End:
	rts
; End of function Obj3DRamp_Main

Obj3DFall:
	move.w	Obj3DFall_Index(pc,d0.w),d0
	jsr	Obj3DFall_Index(pc,d0.w)
	bra.w	CheckObjDespawnTime
; End of function Obj3DFall

; -------------------------------------------------------------------------------
Obj3DFall_Index:dc.w	Obj3DFall_Init-Obj3DFall_Index
	dc.w	Obj3DFall_Main-Obj3DFall_Index
; -------------------------------------------------------------------------------

Obj3DFall_Init:
	addq.b	#2,oRoutine(a0)
	ori.b	#4,oRender(a0)
; End of function Obj3DFall_Init

; -------------------------------------------------------------------------------

Obj3DFall_Main:
	cmpi.b	#$2B,oAnim(a6)
	beq.w	@End
	move.w	oY(a0),d0
	sub.w	oY(a6),d0
	addi.w	#$40,d0
	cmpi.w	#$80,d0
	bcc.s	@End
	move.w	oX(a0),d0
	sub.w	oX(a6),d0
	addi.w	#$20,d0
	cmpi.w	#$40,d0
	bcc.s	@End
	move.w	oX(a0),d0
	move.w	oXVel(a6),d1
	tst.w	d1
	bpl.s	@End
	cmp.w	oX(a6),d0
	bcs.s	@End
	move.w	d0,oX(a6)
	move.w	#0,oXVel(a6)
	move.w	#0,oPlayerGVel(a6)
	move.b	#$37,oAnim(a6)
	move.b	#1,oPlayerJump(a6)
	clr.b	oPlayerStick(a6)
	move.b	#$E,oYRadius(a0)
	move.b	#7,oXRadius(a0)
	addq.w	#5,oY(a0)
	bset	#2,oStatus(a6)

@End:
	rts
MapSpr_3DRamp:include	"3dramp/map.asm"
    even
Ani_3DRamp:include	"3dramp/anim.asm"
; End of function Obj3DFall_Main

CheckObjDespawnTime:
	move.w	obX(a0),d0
; End of function CheckObjDespawnTime

; START	OF FUNCTION CHUNK FOR ObjAnton

CheckObjDespawn2Time:
	tst.b	oRender(a0)
	bmi.s	CheckObjDespawn_OnScreen
	andi.w	#$FF80,d0
	move.w	(v_screenposx).w,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bls.s	CheckObjDespawn_OnScreen

CheckObjDespawnTime_Despawn:
	moveq	#0,d0
	move.b	oRespawn(a0),d0
	beq.s	@DelObj
	lea	(v_objstate).l,a1
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	(v_time_zone).l,d1
	bclr	#7,d1
	beq.s	@SetRespawn
	move.b	(v_time_warp_dir).w,d2
	ext.w	d2
	neg.w	d2
	add.w	d2,d1
	bpl.s	@NoCap
	moveq	#0,d1
	bra.s	@SetRespawn

; -------------------------------------------------------------------------------

@NoCap:
	cmpi.w	#3,d1
	bcs.s	@SetRespawn
	moveq	#2,d1

@SetRespawn:
	add.w	d1,d0
	bclr	#7,2(a1,d0.w)

@DelObj:
	jsr	DeleteObject
	moveq	#1,d0
	rts

; -------------------------------------------------------------------------------

CheckObjDespawn_OnScreen:
	btst	#7,(v_time_zone).l
	bne.s	CheckObjDespawnTime_Despawn
	moveq	#0,d0
	rts
; END OF FUNCTION CHUNK	FOR ObjAnton