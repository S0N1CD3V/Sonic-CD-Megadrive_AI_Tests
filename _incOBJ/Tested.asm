; ===========================================================================
; ----------------------------------------------------------------------------
; Object 0F - Title screen menu
; ----------------------------------------------------------------------------
; Sprite_13600:
TitleMenu:
	moveq	#0,d0
	move.b	routine(a0),d0
	move.w	TitleMenu_Index(pc,d0.w),d1
	jsr	TitleMenu_Index(pc,d1.w)
	jmp	DisplaySprite
; ===========================================================================
; off_13612: TitleMenu_States:
TitleMenu_Index:
		dc.w TitleMenu_Init-TitleMenu_Index	; 0
		dc.w TitleMenu_Main-TitleMenu_Index	; 2
; ===========================================================================
; loc_13616:
TitleMenu_Init:
	move.w	#$10C,x_pixel(a0)
	move.w	#$14C,y_pixel(a0)
	move.l	#TitleMenu_MapUnc_13B70,mappings(a0)
	move.w	#$217C,art_tile(a0)
	move.b	#8,(v_load_menu_art).l
	move.b  #1,oMapFrame(a0)
	bsr.w	TitleMenu_ChkSaveRout
	cmpi.b  #1,(Title_Press_Start).l
	bne.w   EndCode
	move.b  #2,oMapFrame(a0)
	addq.b	#2,routine(a0) ; => TitleMenu_Main

; loc_13644:
TitleMenu_Main:
    btst	#button_right,(v_ctrl1_pressed).w
	bne.s   AddOption
	btst	#button_left,(v_ctrl1_pressed).w
	bne.s   RestOption	
	rts
AddOption	
    addi.b  #1,(Title_screen_option).l
	bsr.s ChangeSprite
    rts
RestOption:
    subq.b  #1,(Title_screen_option).l
	bsr.s ChangeSprite
	rts
ChangeSprite:
    move.b	(Title_screen_option).l,mapping_frame(a0)
	cmpi.b #8,(Title_screen_option).l
	beq.s  RestartCount
	cmpi.b #1,(Title_screen_option).l
	beq.s  RestartCount_2
	rts
RestartCount:
	move.b #2,(Title_screen_option).l
	rts
RestartCount_2:
	move.b #7,(Title_screen_option).l
	rts	
EndCode:
    rts	
TitleMenu_ChkSaveRout:
	move.b	(v_load_menu_art).l,d0
	andi.b	#$F,d0
	cmpi.b	#8,d0
	bcs.s	.SaveRout
	rts

; -------------------------------------------------------------------------------

.SaveRout:
	cmp.b	oRoutine(a0),d0
	beq.s	.Display
	move.b	oRoutine(a0),(v_load_menu_art).l
	bset	#7,(v_load_menu_art).l

.Display:
	jmp	DrawObject

LoadMenuArt:
	bclr	#7,(v_load_menu_art).l
	beq.s	.End
	moveq	#0,d0
	move.b	(v_load_menu_art).l,d0
	subq.b	#2,d0
	add.w	d0,d0
	movea.l	MenuArtIndex(pc,d0.w),a1
	lea	(v_dma_buffer).l,a2
	move.w	#$FF,d0

.Loop:
	move.l	(a1)+,(a2)+
	dbf	d0,.Loop
	lea	(VDP_CTRL).l,a5
	move.l	#$94029340,(a5)
	move.l	#$968C95C0,(a5)
	move.w	#$977F,(a5)
	move.w	#$6880,(a5)
	move.w	#$82,(v_dma_cmd_cache).w
	move.w	(v_dma_cmd_cache).w,(a5)

.End:
	rts
; End of function LoadShieldArt

; -------------------------------------------------------------------------------
MenuArtIndex:	
    dc.l	Art_PressStartText ;0
	dc.l	Art_NewGameText    ;4
	dc.l	Art_ContinueText   ;8
	dc.l	Art_TimeAttackText ;C
	dc.l	Art_RamDataText    ;10
	dc.l	Art_DAGardenText   ;14
	dc.l	Art_VisualModeText ;18
; -----------------------------------------------------------------------------
; sprite mappings
; -----------------------------------------------------------------------------
TitleMenu_MapUnc_13B70:	
    include "level/level/TitleScreen/Data/Mappings (Menu).asm"
	even