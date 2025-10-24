; -------------------------------------------------------------------------------

ObjTimeIcon:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjTimeIcon_Index(pc,d0.w),d0
	jsr	ObjTimeIcon_Index(pc,d0.w)
	tst.b	(v_time_warp_dir).w
	beq.s	@End
	cmpi.w	#$5A,(v_time_warp_timer).w
	bcs.s	@Display
	btst	#0,(v_frame_timer+1).l
	bne.s	@End

@Display:
	jmp	DrawObject

; -------------------------------------------------------------------------------

@End:
	rts
; End of function ObjTimeIcon

; -------------------------------------------------------------------------------
ObjTimeIcon_Index:dc.w	ObjTimeIcon_Init-ObjTimeIcon_Index
	dc.w	ObjTimeIcon_Main-ObjTimeIcon_Index
; -------------------------------------------------------------------------------

ObjTimeIcon_Init:
	addq.b	#2,oRoutine(a0)
	move.l	#MapSpr_MonitorTimePost,oMap(a0)
	move.w	#$85A8,oTile(a0)
	move.w	#$C4,oX(a0)
	move.w	#$152,oYScr(a0)
; End of function ObjTimeIcon_Init

; -------------------------------------------------------------------------------

ObjTimeIcon_Main:
	move.b	#$12,oMapFrame(a0)
	tst.b	(v_time_warp_dir).w
	bmi.s	@End
	move.b	#$13,oMapFrame(a0)

@End:
	rts
; End of function ObjTimeIcon_Main

; -------------------------------------------------------------------------------

ObjTimepost_TimeIcon:
	tst.b	(v_time_attack_mode).l
	beq.s	@Proceed
	jmp	DeleteObject

; -------------------------------------------------------------------------------

@Proceed:
	cmpi.b	#$A,oSubtype(a0)
	beq.w	ObjTimeIcon

ObjTimepost:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjTimepost_Index(pc,d0.w),d0
	jsr	ObjTimepost_Index(pc,d0.w)
	jsr	DrawObject
	jmp	CheckObjDespawnTime
; End of function ObjTimepost_TimeIcon

; -------------------------------------------------------------------------------
ObjTimepost_Index:dc.w	ObjTimepost_Init-ObjTimepost_Index
	dc.w	ObjTimepost_Main-ObjTimepost_Index
	dc.w	ObjTimepost_Spin-ObjTimepost_Index
	dc.w	ObjTimepost_Done-ObjTimepost_Index
; -------------------------------------------------------------------------------

ObjTimepost_Init:
	addq.b	#2,oRoutine(a0)
	move.b	#$20,oYRadius(a0)
	move.b	#$E,oXRadius(a0)
	move.l	#MapSpr_MonitorTimePost,oMap(a0)
	move.w	#$5A8,oTile(a0)
	move.b	#4,oRender(a0)
	move.b	#3,oPriority(a0)
	cmpi.b	#6,(v_zone).l
	bne.s	@NotFront
	tst.b	oSubtype2(a0)
	bne.s	@NotFront
	move.b	#0,oPriority(a0)
	ori.b	#$80,oTile(a0)

@NotFront:
	move.b	#$F,oWidth(a0)
	move.b	oSubtype(a0),oAnim(a0)
	bsr.w	ObjMonitor_GetRespawn
	bclr	#7,2(a2,d0.w)
	move.b	#$A,oMapFrame(a0)
	cmpi.b	#8,oSubtype(a0)
	beq.s	@ChkActive
	addq.b	#2,oMapFrame(a0)

@ChkActive:
	btst	#0,2(a2,d0.w)
	beq.s	@StillActive
	addq.b	#1,oMapFrame(a0)
	move.b	#6,oRoutine(a0)
	rts

; -------------------------------------------------------------------------------

@StillActive:
	move.b	#$DF,oColType(a0)
; End of function ObjTimepost_Init

; -------------------------------------------------------------------------------

ObjTimepost_Main:
	tst.b	oColStatus(a0)
	beq.s	@End
	clr.b	oColStatus(a0)
	cmpi.b	#6,(v_zone).l
	bne.s	@ChkTouch
	tst.b	oSubtype2(a0)
	beq.s	@NotBack
	tst.b	(v_display_low_plane).l
	beq.s	@End
	bra.s	@ChkTouch

; -------------------------------------------------------------------------------

@NotBack:
	tst.b	(v_display_low_plane).l
	bne.s	@End

@ChkTouch:
	move.b	#$3C,oVar2A(a0)
	addq.b	#2,oRoutine(a0)
	bsr.w	ObjMonitor_GetRespawn
	bset	#0,2(a2,d0.w)
	move.w	#$8F,d0
	move.b	#$FF,(v_time_warp_dir).w
	cmpi.b	#8,oSubtype(a0)
	beq.s	@PlaySnd
	move.b	#1,(v_time_warp_dir).w
	subq.w	#1,d0

@PlaySnd:
	jsr	PlaySample

@End:
	rts
; End of function ObjTimepost_Main

; -------------------------------------------------------------------------------

ObjTimepost_Spin:
	subq.b	#1,oVar2A(a0)
	beq.s	@StopSpin
	lea	(Ani_Monitor).l,a1
	bra.w	AnimateMonitor

; -------------------------------------------------------------------------------

@StopSpin:
	addq.b	#2,oRoutine(a0)
	move.b	#$B,oMapFrame(a0)
	cmpi.b	#8,oSubtype(a0)
	beq.s	ObjTimepost_Done
	addq.b	#2,oMapFrame(a0)
; End of function ObjTimepost_Spin

; -------------------------------------------------------------------------------

ObjTimepost_Done:
	rts
; End of function ObjTimepost_Done

; -------------------------------------------------------------------------------

ObjMonitor_GetRespawn:
	lea	(v_obj_respawns).l,a2
	moveq	#0,d0
	move.b	oRespawn(a0),d0
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	(v_time_zone).l,d1
	bclr	#7,d1
	beq.s	@GotTime
	move.b	(v_time_warp_dir).w,d2
	ext.w	d2
	neg.w	d2
	add.w	d2,d1
	bpl.s	@ChkOverflow
	moveq	#0,d1
	bra.s	@GotTime

; -------------------------------------------------------------------------------

@ChkOverflow:
	cmpi.w	#3,d1
	bcs.s	@GotTime
	moveq	#2,d1

@GotTime:
	add.w	d1,d0
	rts
; End of function ObjMonitor_GetRespawn

; -------------------------------------------------------------------------------

ObjMonitor_SolidObj:
	cmpi.b	#6,(v_zone).l
	bne.s	@DoSolid
	tst.b	(v_display_low_plane).l
	beq.s	@ChkHighPlane
	tst.b	oSubtype2(a0)
	bne.s	@DoSolid
	rts

; -------------------------------------------------------------------------------

@ChkHighPlane:
	tst.b	oSubtype2(a0)
	beq.s	@DoSolid
	rts

; -------------------------------------------------------------------------------

@DoSolid:
	move.w	oX(a0),d3
	move.w	oY(a0),d4
	jmp	Mon_SolidSides
; End of function ObjMonitor_SolidObj

; -------------------------------------------------------------------------------
MapSpr_MonitorTimePost: include "timepost/map.asm"
                        even
Ani_Monitor: include "timepost/anim.asm"
             even    
Nem_TimePost: incbin "timepost/art.bin"
             even  		                      			                    