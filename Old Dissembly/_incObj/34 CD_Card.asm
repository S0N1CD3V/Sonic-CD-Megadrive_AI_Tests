TitleCard:
ObjTitleCard:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjTitleCard_Index(pc,d0.w),d0
	jmp	ObjTitleCard_Index(pc,d0.w)
; End of function ObjTitleCard

; -------------------------------------------------------------------------------
ObjTitleCard_Index:dc.w	ObjTitleCard_Init-ObjTitleCard_Index
	dc.w	ObjTitleCard_SlideInVert-ObjTitleCard_Index
	dc.w	ObjTitleCard_SlideInHoriz-ObjTitleCard_Index
	dc.w	ObjTitleCard_SlideOutVert-ObjTitleCard_Index
	dc.w	ObjTitleCard_SlideOutHoriz-ObjTitleCard_Index
	dc.w	ObjTitleCard_WaitPLC-ObjTitleCard_Index
; -------------------------------------------------------------------------------

ObjTitleCard_Init:
	move.b	#2,oRoutine(a0)
	move.w	#$118,oX(a0)
	move.w	#$30,oYScr(a0)
	move.w	#$30,oVar30(a0)
	move.w	#$F0,oVar2E(a0)
	move.b	#$5A,oAnimTime(a0)
	move.w	#$8360,oTile(a0)
	move.l	#MapSpr_TitleCard_PPZ,oMap(a0)
	move.b	#4,oPriority(a0)
	moveq	#0,d1
	moveq	#7,d6
	lea	(ObjTitleCard_Data).l,a2

@Loop:
	jsr	FindObjSlot
	move.b	#$34,oID(a1)
	move.b	#4,oRoutine(a1)
	move.w	#$8360,oTile(a1)
	move.l	#MapSpr_TitleCard_PPZ,4(a1)
	cmpi.b  #0,(v_zone).w  ;  is PPZ
	beq.s   @Load_Titlecard
    move.l	#MapSpr_TitleCard_TTZ,4(a1)
	cmpi.b  #1,(v_zone).w  ;  is TTZ
	beq.s   @Load_Titlecard
	move.l	#MapSpr_TitleCard_WWZ,4(a1)
	cmpi.b  #2,(v_zone).w  ;  is WWZ
	beq.s   @Load_Titlecard
	move.l	#MapSpr_TitleCard_SSZ,4(a1)
	cmpi.b  #3,(v_zone).w  ;  is SSZ
	beq.s   @Load_Titlecard
	move.l	#MapSpr_TitleCard_CCZ,4(a1)
	cmpi.b  #4,(v_zone).w  ;  is CCZ
	beq.s   @Load_Titlecard
	move.l	#MapSpr_TitleCard_MMZ,4(a1)
 @Load_Titlecard:
	move.w	d1,d2
	lsl.w	#3,d2
	move.w	(a2,d2.w),oYScr(a1)
	move.w	2(a2,d2.w),oX(a1)
	move.w	2(a2,d2.w),oVar2C(a1)
	move.w	4(a2,d2.w),oVar2A(a1)
	move.b	6(a2,d2.w),oMapFrame(a1)
	cmpi.b	#5,d1
	bne.s	@NotActNum
	move.b	(v_act).l,d3
	add.b	d3,oMapFrame(a1)

@NotActNum:
	move.b	7(a2,d2.w),oAnimTime(a1)
	addq.b	#1,d1
	dbf	d6,@Loop
	rts
; End of function ObjTitleCard_Init

; -------------------------------------------------------------------------------

ObjTitleCard_SlideInVert:
	moveq	#8,d0
	move.w	oVar2E(a0),d1
	cmp.w	oYScr(a0),d1
	beq.s	@DidSlide
	bge.s	@DoYSlide
	neg.w	d0

@DoYSlide:
	add.w	d0,oYScr(a0)
	jmp	DrawObject

; -------------------------------------------------------------------------------

@DidSlide:
	addq.b	#4,oRoutine(a0)
	jmp	DrawObject
; End of function ObjTitleCard_SlideInVert

; -------------------------------------------------------------------------------

ObjTitleCard_SlideInHoriz:
	moveq	#8,d0
	move.w	oVar2A(a0),d1
	cmp.w	oX(a0),d1
	beq.s	@DidSlide
	bge.s	@DoXSlide
	neg.w	d0

@DoXSlide:
	add.w	d0,oX(a0)
	jmp	DrawObject

; -------------------------------------------------------------------------------

@DidSlide:
	addq.b	#4,oRoutine(a0)
	jmp	DrawObject
; End of function ObjTitleCard_SlideInHoriz

; -------------------------------------------------------------------------------

ObjTitleCard_SlideOutVert:
	tst.b	oAnimTime(a0)
	beq.s	@SlideOut
	subq.b	#1,oAnimTime(a0)
	jmp	DrawObject

; -------------------------------------------------------------------------------

@SlideOut:
	moveq	#$10,d0
	move.w	oVar30(a0),d1
	cmp.w	oYScr(a0),d1
	beq.s	@DidSlide
	bge.s	@DoYSlide
	neg.w	d0

@DoYSlide:
	add.w	d0,oYScr(a0)
	jmp	DrawObject

; -------------------------------------------------------------------------------

@DidSlide:
	addq.b	#4,oRoutine(a0)
	move.b	#1,(v_scroll_lock).w
	moveq	#2,d0
	jmp	LoadPLC
; End of function ObjTitleCard_SlideOutVert

; -------------------------------------------------------------------------------

ObjTitleCard_SlideOutHoriz:
	tst.b	oAnimTime(a0)
	beq.s	@SlideOut
	subq.b	#1,oAnimTime(a0)
	jmp	DrawObject

; -------------------------------------------------------------------------------

@SlideOut:
	moveq	#$10,d0
	move.w	oVar2C(a0),d1
	cmp.w	oX(a0),d1
	beq.s	@DidSlide
	bge.s	@DoXSlide
	neg.w	d0

@DoXSlide:
	add.w	d0,oX(a0)
	jmp	DrawObject

; -------------------------------------------------------------------------------

@DidSlide:
	jmp	DeleteObject
; End of function ObjTitleCard_SlideOutHoriz

; -------------------------------------------------------------------------------

ObjTitleCard_WaitPLC:
	tst.l	(v_plc_buffer).w
	bne.s	@End
	clr.b	(v_scroll_lock).w
	clr.b	(v_ctrl_locked).w
	jmp	DeleteObject

; -------------------------------------------------------------------------------

@End:
	rts
; End of function ObjTitleCard_WaitPLC

; -------------------------------------------------------------------------------

ObjTitleCard_Data:
    dc.w	$130, $228, $168, $15A
	dc.w	$100, $238, $178, $25A
	dc.w	$100, $240, $180, $25A
	dc.w	$100, $248, $188, $25A
	dc.w	$120, $230, $170, $35A
	dc.w	$140, $248, $188, $45A
	dc.w	$100, $1D0, $110, $75A
	dc.w	$100, $1D0, $110, $85A
MapSpr_TitleCard_PPZ: INCLUDE "_maps/SCD_TC_PPZ.asm"
	even
MapSpr_TitleCard_TTZ: INCLUDE "_maps/SCD_TC_TTZ.asm"
	even
MapSpr_TitleCard_WWZ: INCLUDE "_maps/SCD_TC_WWZ.asm"
	even	
MapSpr_TitleCard_SSZ: INCLUDE "_maps/SCD_TC_SSZ.asm"
	even
MapSpr_TitleCard_CCZ: INCLUDE "_maps/SCD_TC_CCZ.asm"
	even	
MapSpr_TitleCard_MMZ: INCLUDE "_maps/SCD_TC_MMZ.asm"
	even			