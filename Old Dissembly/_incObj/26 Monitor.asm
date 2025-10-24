oplayerinvinc equ objoff_32
oplayerspeed  equ objoff_34
; -------------------------------------------------------------------------------

ObjMonitor_Timepost:
	tst.b	oSubtype(a0)
	bne.s	ObjMonitor
	tst.b	(v_time_attack_mode).l
	beq.s	ObjMonitor
	jmp	CheckObjDespawnTime

; -------------------------------------------------------------------------------

ObjMonitor:
	cmpi.b	#8,oSubtype(a0)
	bcc.w	ObjTimepost_TimeIcon
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjMonitor_Index(pc,d0.w),d1
	jmp	ObjMonitor_Index(pc,d1.w)
; End of function ObjMonitor_Timepost

; -------------------------------------------------------------------------------
ObjMonitor_Index:dc.w	ObjMonitor_Init-ObjMonitor_Index
	dc.w	ObjMonitor_Main-ObjMonitor_Index
	dc.w	ObjMonitor_Break-ObjMonitor_Index
	dc.w	ObjMonitor_Animate-ObjMonitor_Index
	dc.w	ObjMonitor_Display-ObjMonitor_Index
; -------------------------------------------------------------------------------

ObjMonitor_Init:
	addq.b	#2,oRoutine(a0)
	move.b	#$E,oYRadius(a0)
	move.b	#$E,oXRadius(a0)
	move.l	#MapSpr_MonitorTimePost,oMap(a0)
	move.w	#$5A8,oTile(a0)
	move.b	#3,oPriority(a0)
	cmpi.b	#6,(v_zone).l
	bne.s	@NotMMZ
	tst.b	oSubtype2(a0)
	bne.s	@NotMMZ
	ori.b	#$80,oTile(a0)
	move.b	#0,oPriority(a0)

@NotMMZ:
	move.b	#4,oRender(a0)
	move.b	#$F,oWidth(a0)
	bsr.w	ObjMonitor_GetRespawn
	bclr	#7,2(a2,d0.w)
	btst	#0,2(a2,d0.w)
	beq.s	@NotBroken
	move.b	#8,oRoutine(a0)
	move.b	#$11,oMapFrame(a0)
	rts

; -------------------------------------------------------------------------------

@NotBroken:
	move.b	#$46,oColType(a0)
	move.b	oSubtype(a0),oAnim(a0)
; End of function ObjMonitor_Init

; -------------------------------------------------------------------------------

ObjMonitor_Main:
	tst.b	oRender(a0)
	bpl.w	ObjMonitor_Display
	move.b	oRoutine2(a0),d0
	beq.s	@CheckSolid
	bsr.w	ObjMoveGrv
	jsr	CheckFloorEdge
	tst.w	d1
	bpl.w	ObjMonitor_Animate
	add.w	d1,oY(a0)
	clr.w	oYVel(a0)
	clr.b	oRoutine2(a0)
	bra.w	ObjMonitor_Animate

; -------------------------------------------------------------------------------

@CheckSolid:
	tst.b	oRender(a0)
	bpl.s	ObjMonitor_Animate
	lea	(v_player).w,a1
	bsr.w	ObjMonitor_SolidObj
; End of function ObjMonitor_Main

; -------------------------------------------------------------------------------

ObjMonitor_Animate:
;	tst.w	(v_time_stop_timer).l
;	bne.s	ObjMonitor_Display
	lea	(Ani_Monitor).l,a1
	bsr.w	AnimateMonitor
; End of function ObjMonitor_Animate

; -------------------------------------------------------------------------------

ObjMonitor_Display:
	bsr.w	DrawObject
	jmp	CheckObjDespawnTime
; End of function ObjMonitor_Display

; -------------------------------------------------------------------------------

ObjMonitor_Break:
	move.w	#$96,d0
	jsr	PlaySound
	addq.b	#4,oRoutine(a0)
	move.b	#0,oColType(a0)
	bsr.w	FindObjSlot
	bne.s	@NoContents
	move.b	#id_PowerUp,oID(a1)
	move.w	oX(a0),oX(a1)
	move.w	oY(a0),oY(a1)
	move.b	oAnim(a0),oAnim(a1)
	move.b	oSubtype2(a0),oSubtype2(a1)

@NoContents:
	bsr.w	FindObjSlot
	bne.s	@NoExplosion
	move.b	#id_ExplosionItem,oID(a1)
	move.w	oX(a0),oX(a1)
	move.w	oY(a0),oY(a1)
	move.b	#1,oRoutine2(a1)
	move.b	#1,oSubtype(a1)
	move.b	oSubtype2(a0),oSubtype2(a1)

@NoExplosion:
	bsr.w	ObjMonitor_GetRespawn
	bset	#0,2(a2,d0.w)
	move.b	#$11,oMapFrame(a0)
	bra.w	DrawObject
; End of function ObjMonitor_Break

; -------------------------------------------------------------------------------

ObjMonitorContents:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjMonitorContents_Index(pc,d0.w),d1
	jsr	ObjMonitorContents_Index(pc,d1.w)
	bra.w	DrawObject
; End of function ObjMonitorContents

; -------------------------------------------------------------------------------
ObjMonitorContents_Index:dc.w	ObjMonitorContents_Init-ObjMonitorContents_Index
	dc.w	ObjMonitorContents_Main-ObjMonitorContents_Index
	dc.w	ObjMonitorContents_Destroy-ObjMonitorContents_Index
; -------------------------------------------------------------------------------

ObjMonitorContents_Init:
	addq.b	#2,oRoutine(a0)
	move.w	#$85A8,oTile(a0)
	tst.b	oSubtype2(a0)
	beq.s	@NotPriority
	andi.b	#$7F,oTile(a0)

@NotPriority:
	move.b	#$24,oRender(a0)
	move.b	#3,oPriority(a0)
	move.b	#8,oWidth(a0)
	move.w	#-$300,oYVel(a0)
	moveq	#0,d0
	move.b	oAnim(a0),d0
	move.b	d0,oMapFrame(a0)
	movea.l	#MapSpr_MonitorTimePost,a1
	add.b	d0,d0
	adda.w	(a1,d0.w),a1
	addq.w	#1,a1
	move.l	a1,oMap(a0)
; End of function ObjMonitorContents_Init

; -------------------------------------------------------------------------------

ObjMonitorContents_Main:

; FUNCTION CHUNK AT 0020A8E4 SIZE 00000006 BYTES
; FUNCTION CHUNK AT 0020A946 SIZE 00000076 BYTES

	tst.w	oYVel(a0)
	bpl.w	@GiveBonus
	bsr.w	ObjMove
	addi.w	#$18,oYVel(a0)
	rts

; -------------------------------------------------------------------------------

@GiveBonus:
	addq.b	#2,oRoutine(a0)
	move.w	#$1D,oAnimTime(a0)
	move.b	oAnim(a0),d0
	bne.s	@Not1UP

@Gain1UP:
	addq.b	#1,(v_life_count).l
	addq.b	#1,(v_update_lives).l
	move.w	#$8C,d0
	jmp	PlaySample

; -------------------------------------------------------------------------------

@Not1UP:
	cmpi.b	#1,d0
	bne.s	@Not10Rings
	addi.w	#10,(v_ring_count).l
	ori.b	#1,(v_update_rings).l
	cmpi.w	#100,(v_ring_count).l
	bcs.s	@RingSound
	bset	#1,(v_1up_flags).l
	beq.w	@Gain1UP
	cmpi.w	#200,(v_ring_count).l
	bcs.s	@RingSound
	bset	#2,(v_1up_flags).l
	beq.w	@Gain1UP

@RingSound:
	move.w	#$B5,d0
	jmp	PlaySound

; -------------------------------------------------------------------------------

@Not10Rings:
	cmpi.b	#2,d0
	bne.s	ObjMonitorContents_NotShield
; End of function ObjMonitorContents_Main

; -------------------------------------------------------------------------------

ObjMonitorContents_GainShield:
	move.b	#1,(v_shield).l
	move.b	#id_ShieldItem,(v_obj_shield).w
	move.w	#$AF,d0
	jmp	PlaySound
; End of function ObjMonitorContents_GainShield

; -------------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ObjMonitorContents_Main

ObjMonitorContents_NotShield:
	cmpi.b	#3,d0
	bne.s	ObjMonitorContents_NotInvinc
; END OF FUNCTION CHUNK	FOR ObjMonitorContents_Main
; -------------------------------------------------------------------------------

ObjMonitorContents_GainInvinc:
	move.b	#1,(v_invincible).l
	move.w	#$528,(v_player+oPlayerInvinc).w
	move.b	#id_ShieldItem,(v_obj_inv_star1).w
	move.b	#1,(v_obj_inv_star1+oAnim).w
	move.b	#id_ShieldItem,(v_obj_inv_star2).w
	move.b	#2,(v_obj_inv_star2+oAnim).w
	move.b	#id_ShieldItem,(v_obj_inv_star3).w
	move.b	#3,(v_obj_inv_star3+oAnim).w
	move.b	#id_ShieldItem,(v_obj_inv_star4).w
	move.b	#4,(v_obj_inv_star4+oAnim).w
	tst.b	(v_time_zone).l
	bne.s	@NotPast
	music	bgm_Invincible,1,0,0 ; play invincibility music

@NotPast:
	music	bgm_Invincible,1,0,0 ; play invincibility music
; End of function ObjMonitorContents_GainInvinc

; -------------------------------------------------------------------------------
	rts

; -------------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ObjMonitorContents_Main

ObjMonitorContents_NotInvinc:
	cmpi.b	#4,d0
	bne.s	@NotSpeedShoes

@GainSpeedShoes:
	move.b	#1,(v_speed_shoes).l
	move.w	#$528,(v_player+oPlayerSpeed).w
	move.w	#$C00,(v_sonic_top_speed).w
	move.w	#$18,(v_sonic_acceleration).w
	move.w	#$80,(v_sonic_deceleration).w
	tst.b	(v_time_zone).l
	bne.s	@NotPast
	move.w	#$82,d0
	jsr	PlaySample

@NotPast:
	music	bgm_Speedup,1,0,0		; Speed	up the music

; -------------------------------------------------------------------------------

@NotSpeedShoes:
	cmpi.b	#5,d0
	bne.s	@NotTimeStop
;	move.w	#300,(v_time_stop_timer).l
    move.b  #0,(v_time_zone).w
	move.b  #1,(f_restart).w
	move.b  #1,(v_no_title_card).l
	rts

; -------------------------------------------------------------------------------

@NotTimeStop:
	cmpi.b	#6,d0
	bne.s	@NotBlueRing
	move.w	#$90,d0
	jsr	PlaySample
	move.b	#1,(v_blue_ring).l
;	move.b  #2,(v_time_zone).w
;	move.b  #1,(f_restart).w
;	move.b  #1,(v_no_title_card).l
	rts

; -------------------------------------------------------------------------------

@NotBlueRing:
	move.b  #3,(v_time_zone).w
	move.b  #1,(f_restart).w
	move.b  #1,(v_no_title_card).l
;	bsr.w	ObjMonitorContents_GainShield
;	bsr.w	ObjMonitorContents_GainInvinc
;	bra.s	@GainSpeedShoes
; END OF FUNCTION CHUNK	FOR ObjMonitorContents_Main
; -------------------------------------------------------------------------------

ObjMonitorContents_Destroy:
	subq.w	#1,oAnimTime(a0)
	bmi.w	DeleteObject
	rts
; End of function ObjMonitorContents_Destroy

; -------------------------------------------------------------------------------
Monitor_Solid: include	"_incObj\26 Monitor (SolidSides subroutine).asm"	