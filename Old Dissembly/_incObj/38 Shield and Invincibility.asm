; ---------------------------------------------------------------------------
; Object 38 - shield and invincibility stars
; ---------------------------------------------------------------------------

ShieldItem:
		moveq	#0,d0
	move.b	oRoutine(a0),d0
	move.w	ObjPowerup_Index(pc,d0.w),d1
	jmp	ObjPowerup_Index(pc,d1.w)
; End of function ObjPowerup

; -------------------------------------------------------------------------------
ObjPowerup_Index:dc.w	ObjPowerup_Init-ObjPowerup_Index
	dc.w	ObjPowerup_Shield-ObjPowerup_Index
	dc.w	ObjPowerup_InvStars-ObjPowerup_Index
	dc.w	ObjPowerup_TimeStars-ObjPowerup_Index
; -------------------------------------------------------------------------------

ObjPowerup_Init:
	addq.b	#2,oRoutine(a0)
	move.l	#MapSpr_Powerup,oMap(a0)
	move.b	#4,oRender(a0)
	move.b	#1,oPriority(a0)
	move.b	#$10,oWidth(a0)
	move.w	#$544,oTile(a0)
	tst.b	oAnim(a0)
	beq.s	@End
	addq.b	#2,oRoutine(a0)
	cmpi.b	#5,oAnim(a0)
	bcs.s	@End
	addq.b	#2,oRoutine(a0)

@End:
	rts
; End of function ObjPowerup_Init

; -------------------------------------------------------------------------------

ObjPowerup_Shield:

; FUNCTION CHUNK AT 00206540 SIZE 0000002E BYTES

	tst.b	(v_shield).l
	beq.s	@Delete
	tst.b	(v_time_warp_on).l
	bne.s	@End
	tst.b	(v_invincible).l
	bne.s	@End
	move.w	(v_player+oX).w,oX(a0)
	move.w	(v_player+oY).w,oY(a0)
	move.b	(v_player+oStatus).w,oStatus(a0)
	cmpi.b	#6,(v_zone).l
	bne.s	@Animate
	ori.b	#$80,2(a0)
	tst.b	(v_display_low_plane).l
	beq.s	@Animate
	andi.b	#$7F,2(a0)

@Animate:
	lea	(Ani_Powerup).l,a1
	jsr	AnimateObject
	bra.w	ObjPowerup_ChkSaveRout

; -------------------------------------------------------------------------------

@End:
	rts

; -------------------------------------------------------------------------------

@Delete:
	jmp	DeleteObject
; End of function ObjPowerup_Shield

; -------------------------------------------------------------------------------

ObjPowerup_InvStars:

; FUNCTION CHUNK AT 002064CE SIZE 00000072 BYTES

	tst.b	(v_time_warp_on).l
	beq.s	@NoTimeWarp
	rts

; -------------------------------------------------------------------------------

@NoTimeWarp:
	tst.b	(v_invincible).l
	bne.s	ObjPowerup_ShowStars
	jmp	DeleteObject
; End of function ObjPowerup_InvStars

; -------------------------------------------------------------------------------

ObjPowerup_TimeStars:
	tst.b	(v_time_warp_on).l
	bne.s	ObjPowerup_ShowStars
	jmp	DeleteObject
; End of function ObjPowerup_TimeStars

; -------------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ObjPowerup_InvStars

ObjPowerup_ShowStars:
	cmpi.b	#6,(v_zone).l
	bne.s	@GotPriority
	ori.b	#$80,oTile(a0)
	tst.b	(v_display_low_plane).l
	beq.s	@GotPriority
	andi.b	#$7F,oTile(a0)

@GotPriority:
	move.w	(v_sonic_record_index).w,d0
	move.b	oAnim(a0),d1
	subq.b	#1,d1
	cmpi.b	#4,d1
	bcs.s	@GotDelta
	subq.b	#4,d1

@GotDelta:
	lsl.b	#3,d1
	move.b	d1,d2
	add.b	d1,d1
	add.b	d2,d1
	addq.b	#4,d1
	sub.b	d1,d0
	move.b	oVar30(a0),d1
	sub.b	d1,d0
	addq.b	#4,d1
	cmpi.b	#$18,d1
	bcs.s	@NoCap
	moveq	#0,d1

@NoCap:
	move.b	d1,oVar30(a0)
	lea	(v_sonic_record_buf).w,a1
	lea	(a1,d0.w),a1
	move.w	(a1)+,oX(a0)
	move.w	(a1)+,oY(a0)
	move.b	(v_player+oStatus).w,oStatus(a0)
	lea	(Ani_Powerup).l,a1
	jsr	AnimateObject
; END OF FUNCTION CHUNK	FOR ObjPowerup_InvStars
; START	OF FUNCTION CHUNK FOR ObjPowerup_Shield

ObjPowerup_ChkSaveRout:
	move.b	(v_load_shield_art).l,d0
	andi.b	#$F,d0
	cmpi.b	#8,d0
	bcs.s	@SaveRout
	rts

; -------------------------------------------------------------------------------

@SaveRout:
	cmp.b	oRoutine(a0),d0
	beq.s	@Display
	move.b	oRoutine(a0),(v_load_shield_art).l
	bset	#7,(v_load_shield_art).l

@Display:
	jmp	DrawObject
; END OF FUNCTION CHUNK	FOR ObjPowerup_Shield
; -------------------------------------------------------------------------------

LoadShieldArt:
	bclr	#7,(v_load_shield_art).l
	beq.s	@End
	moveq	#0,d0
	move.b	(v_load_shield_art).l,d0
	subq.b	#2,d0
	add.w	d0,d0
	movea.l	ShieldArtIndex(pc,d0.w),a1
	lea	(v_dma_buffer).l,a2
	move.w	#$FF,d0

@Loop:
	move.l	(a1)+,(a2)+
	dbf	d0,@Loop
	lea	(VDP_CTRL).l,a5
	move.l	#$94029340,(a5)
	move.l	#$968C95C0,(a5)
	move.w	#$977F,(a5)
	move.w	#$6880,(a5)
	move.w	#$82,(v_dma_cmd_cache).w
	move.w	(v_dma_cmd_cache).w,(a5)

@End:
	rts
; End of function LoadShieldArt

; -------------------------------------------------------------------------------
ShieldArtIndex:	dc.l	ArtUnc_Shield
	dc.l	ArtUnc_InvStars
	dc.l	ArtUnc_TimeStars
	dc.l	ArtUnc_GameOver
	dc.l	ArtUnc_TimeOver
; -------------------------------------------------------------------------------
Ani_Powerup:
	include	"powerup/anim.asm"
	even
MapSpr_Powerup:
	include	"powerup/map.asm"
	even
ArtUnc_Shield:
	incbin	"powerup/artshield.bin"
	even
ArtUnc_InvStars:
	incbin	"powerup/artinvinc.bin"
	even
ArtUnc_TimeStars:
	incbin	"powerup/artwarp.bin"
	even
ArtUnc_TimeOver:
	incbin	"gameover/arttimeover.bin"
	even
ArtUnc_GameOver:
	incbin	"gameover/artgameover.bin"
	even		