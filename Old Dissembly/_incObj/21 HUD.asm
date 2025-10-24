; -------------------------------------------------------------------------------

ObjPoints:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjPoints_Index(pc,d0.w),d0
	jsr	ObjPoints_Index(pc,d0.w)
	jmp	DrawObject
; End of function ObjPoints

; -------------------------------------------------------------------------------
ObjPoints_Index:dc.w	ObjPoints_Init-ObjPoints_Index
	dc.w	ObjPoints_Main-ObjPoints_Index
; -------------------------------------------------------------------------------

ObjPoints_Init:
	addq.b	#2,oRoutine(a0)
	ori.b	#4,oRender(a0)
	move.w	#$6C6,oTile(a0)
	move.l	#MapSpr_Points,oMap(a0)
	move.b	oSubtype(a0),oMapFrame(a0)
	andi.b	#$7F,oMapFrame(a0)
	move.b	#$18,oVar2A(a0)
; End of function ObjPoints_Init

; -------------------------------------------------------------------------------

ObjPoints_Main:
	subq.b	#1,oVar2A(a0)
	bne.s	@Rise
	jmp	DeleteObject

; -------------------------------------------------------------------------------

@Rise:
	subq.w	#2,oY(a0)
	rts
; End of function ObjPoints_Main

; -------------------------------------------------------------------------------
MapSpr_Points:
	include	"points/map.asm"
	even
; -------------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; Object 21 - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------

HUD:
ObjHUD_Points:
	tst.b	oSubtype(a0)
	bmi.w	ObjPoints

ObjHUD:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjHUD_Index(pc,d0.w),d0
	jmp	ObjHUD_Index(pc,d0.w)
; End of function ObjHUD_Points

; -------------------------------------------------------------------------------
ObjHUD_Index:	dc.w	ObjHUD_Init-ObjHUD_Index
	dc.w	ObjHUD_Main-ObjHUD_Index
; -------------------------------------------------------------------------------

ObjHUD_Init:
	addq.b	#2,oRoutine(a0)
	move.l	#MapSpr_HUD,oMap(a0)
	move.w	#$8568,oTile(a0)
	move.w	#$90,oX(a0)
	move.w	#$88,oYScr(a0)
	tst.b	oSubtype2(a0)
	beq.s	@NotRings
	move.b	#3,oMapFrame(a0)
	bra.s	ObjHUD_Main

; -------------------------------------------------------------------------------

@NotRings:
	tst.w	(v_debug_mode_enabled).l
	beq.s	@NoDebug
	move.b	#2,oMapFrame(a0)

@NoDebug:
	tst.b	oSubtype(a0)
	beq.s	ObjHUD_Main
	move.w	#$148,oYScr(a0)
	move.b	#1,oMapFrame(a0)
; End of function ObjHUD_Init

; -------------------------------------------------------------------------------

ObjHUD_Main:
	tst.b	oSubtype(a0)
	bne.s	@Display
	tst.b	oSubtype2(a0)
	beq.s	@ChkDebug
	tst.w	(v_ring_count).l
	beq.s	@ChkFlashRings
	bclr	#5,oTile(a0)
	bra.s	@Display

; -------------------------------------------------------------------------------

@ChkFlashRings:
	move.b	(v_frame_count+3).l,d0
	andi.b	#$F,d0
	bne.s	@Display
	eori.b	#$20,oTile(a0)
	bra.s	@Display

; -------------------------------------------------------------------------------

@ChkDebug:
	move.b	#0,oMapFrame(a0)
	tst.w	(v_debug_mode_enabled).l
	beq.s	@Display
	move.b	#2,oMapFrame(a0)

@Display:
	jmp	DrawObject
; End of function ObjHUD_Main

; -------------------------------------------------------------------------------
MapSpr_HUD:
	include	"hud/map.asm"
	even
; -------------------------------------------------------------------------------
