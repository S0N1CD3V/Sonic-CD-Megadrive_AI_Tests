ObjWaterfall:
	moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjWaterfall_Index(pc,d0.w),d0
	jsr	ObjWaterfall_Index(pc,d0.w)
	lea	(Ani_Waterfall).l,a1
	jsr	AnimateObject
	jmp	DrawObject

; -------------------------------------------------------------------------------
ObjWaterfall_Index:
	dc.w	ObjWaterfall_Init-ObjWaterfall_Index
	dc.w	ObjWaterfall_Main-ObjWaterfall_Index
; -------------------------------------------------------------------------------

ObjWaterfall_Init:
	addq.b	#2,oRoutine(a0)
	move.l	#MapSpr_Waterfall,oMap(a0)
	move.b	#4,oRender(a0)
	move.b	#1,oPriority(a0)
	move.b	#$10,oWidth(a0)
	move.w	#$3BA,oTile(a0)
	andi.w	#$FFF0,oY(a0)
	move.w	$C(a0),oVar2A(a0)
	addi.w	#$180,oVar2A(a0)
	rts

; -------------------------------------------------------------------------------

ObjWaterfall_Main:
	move.w	oY(a0),d0
	addq.w	#4,d0
	cmp.w	oVar2A(a0),d0
	bcs.s	@NoDel
	jmp	DeleteObject

@NoDel:
	move.w	d0,oY(a0)
	moveq	#2,d3
	bset	#$D,d3
	move.w	oY(a0),d4
	move.w	oX(a0),d5
	subi.w	#$60,d5
	move.w	d4,d6
	andi.w	#$F,d6
	bne.s	@End
	moveq	#$B,d6

@Loop:
	jsr	DrawBlockAtPos
	addi.w	#$10,d5
	dbf	d6,@Loop

@End:
	rts

; -------------------------------------------------------------------------------

ObjNull8:
	rts
; End of function ObjWaterfall_Main

; -------------------------------------------------------------------------------

ObjNull5:
	rts
; End of function ObjNull5

; -------------------------------------------------------------------------------
Ani_Waterfall:
	include	"waterfall/anim.asm"
	even
		
MapSpr_Waterfall:
	include	"waterfall/map.asm"
	even
; -------------------------------------------------------------------------------
; Draw a block at a position in the level
; -------------------------------------------------------------------------------
; NOTE: This routine is possibly bugged. It was designed to only ever place a 
; single block in the entire level, but because it also overwrites chunk data in
; order for Sonic to interact with it, it affects all instances of the
; overwritten chunk. Best used on a chunk that only has 1 instance of use.
; -------------------------------------------------------------------------------
; PARAMETERS:
;	d3.w	- Block metadata
;	d4.w	- Y position
;	d5.w	- X position
; -------------------------------------------------------------------------------

DrawBlockAtPos:
	move.l	a0,-(sp)

	lea	(v_lvl_layout).w,a4			; Prepare level layout
	lea	(VDP_CTRL).l,a5				; Prepare VDP ports
	lea	(VDP_DATA).l,a6
	move.w	#$4000,d2				; Set to draw on plane A
	move.l	#$800000,d7				; VDP command row delta

	movem.l	d3-d5,-(sp)
	bsr.w	GetBlockDataAbsXY			; Get the pointer to the block at our position
	bne.s	@GotBlock				; If we ended up getting a block, branch
	movem.l	(sp)+,d3-d5
	bra.s	@End

@GotBlock:
	movem.l	(sp)+,d3-d5

	move.w	d3,(a0)					; Overwrite the block in the chunk found
	bsr.w	ChkBlockPosOnscreen			; Check if this block is onscreen
	bne.s	@End					; If it's not, branch

	movem.l	d3-d5,-(sp)				; Draw the block
	lea	(v_level_blocks).l,a1
	andi.w	#$3FF,d3
	lsl.w	#3,d3
	adda.w	d3,a1
	bsr.w	GetBlockVDPCmdAbsXY
	bsr.w	DrawBlock
	movem.l	(sp)+,d3-d5

@End:
	movea.l	(sp)+,a0
	rts

; -------------------------------------------------------------------------------
; Check if a block position is onscreen
; -------------------------------------------------------------------------------
; PARAMETERS:
;	d4.w	- Y position
;	d5.w	- X position
; RETURNS:
;	d0.w	- Return status
;	z/nz	- Onscreen/offscreen
; -------------------------------------------------------------------------------

ChkBlockPosOnscreen:
	move.w	(v_cam_fg_y).w,d0			; Is the block above the top of the screen?
	move.w	d0,d1
	andi.w	#$FFF0,d0
	subi.w	#16,d0
	cmp.w	d0,d4
	bcs.s	@Offscreen				; If so, branch

	addi.w	#224+16,d1				; Is the block below the bottom of the screen?
	andi.w	#$FFF0,d1
	cmp.w	d1,d4
	bgt.s	@Offscreen				; If so, branch

	move.w	(v_cam_fg_x).w,d0			; Is the block left of the left side of the screen?
	move.w	d0,d1
	andi.w	#$FFF0,d0
	subi.w	#16,d0
	cmp.w	d0,d5
	bcs.s	@Offscreen				; If so, branch

	addi.w	#320+16,d1				; Is the block right of the right side of the screen?
	andi.w	#$FFF0,d1
	cmp.w	d1,d5
	bgt.s	@Offscreen				; If so, branch

	moveq	#0,d0					; Mark as onscreen
	rts

@Offscreen:
	moveq	#1,d0					; Mark as offscreen
	rts