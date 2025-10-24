; ---------------------------------------------------------------------------
; Object 79 - lamppost
; ---------------------------------------------------------------------------

Lamppost:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Lamp_Index(pc,d0.w),d1
		jsr	Lamp_Index(pc,d1.w)
		jmp	(RememberState).l
; ===========================================================================
Lamp_Index:	dc.w Lamp_Main-Lamp_Index
		dc.w Lamp_Blue-Lamp_Index
		dc.w Lamp_Finish-Lamp_Index
		dc.w Lamp_Twirl-Lamp_Index

lamp_origX:	equ $30		; original x-axis position
lamp_origY:	equ $32		; original y-axis position
lamp_time:	equ $36		; length of time to twirl the lamp
; ===========================================================================

Lamp_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Lamp,obMap(a0)
		move.w	#$7A0,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#8,obActWid(a0)
		move.b	#5,obPriority(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bclr	#7,2(a2,d0.w)
		btst	#0,2(a2,d0.w)
		bne.s	@red
		move.b	(v_lastlamp).w,d1
		andi.b	#$7F,d1
		move.b	obSubtype(a0),d2 ; get lamppost number
		andi.b	#$7F,d2
		cmp.b	d2,d1		; is this a "new" lamppost?
		bcs.s	Lamp_Blue	; if yes, branch

@red:
		bset	#0,2(a2,d0.w)
		move.b	#4,obRoutine(a0) ; goto Lamp_Finish next
		move.b	#3,obFrame(a0)	; use red lamppost frame
		rts	
; ===========================================================================

Lamp_Blue:	; Routine 2
		tst.w	(v_debuguse).w	; is debug mode	being used?
		bne.w	@donothing	; if yes, branch
		tst.b	(f_lockmulti).w
		bmi.w	@donothing
		move.b	(v_lastlamp).w,d1
		andi.b	#$7F,d1
		move.b	obSubtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1		; is this a "new" lamppost?
		bcs.s	@chkhit		; if yes, branch
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bset	#0,2(a2,d0.w)
		move.b	#4,obRoutine(a0)
		move.b	#3,obFrame(a0)
		bra.w	@donothing
; ===========================================================================

@chkhit:
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		addq.w	#8,d0
		cmpi.w	#$10,d0
		bcc.w	@donothing
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$68,d0
		bcc.s	@donothing

		sfx	sfx_Lamppost,0,0,0	; play lamppost sound
		addq.b	#2,obRoutine(a0)
		jsr	(FindFreeObj).l
		bne.s	@fail
		move.b	#id_Lamppost,0(a1)	; load twirling	lamp object
		move.b	#6,obRoutine(a1) ; goto Lamp_Twirl next
		move.w	obX(a0),lamp_origX(a1)
		move.w	obY(a0),lamp_origY(a1)
		subi.w	#$18,lamp_origY(a1)
		move.l	#Map_Lamp,obMap(a1)
		move.w	#$7A0,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#8,obActWid(a1)
		move.b	#4,obPriority(a1)
		move.b	#2,obFrame(a1)	; use "ball only" frame
		move.w	#$20,lamp_time(a1)

	@fail:
		move.b	#1,obFrame(a0)	; use "post only" frame
		bsr.w	Lamp_StoreInfo
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bset	#0,2(a2,d0.w)

	@donothing:
		rts	
; ===========================================================================

Lamp_Finish:	; Routine 4
		rts	
; ===========================================================================

Lamp_Twirl:	; Routine 6
		subq.w	#1,lamp_time(a0) ; decrement timer
		bpl.s	@continue	; if time remains, keep twirling
		move.b	#4,obRoutine(a0) ; goto Lamp_Finish next

	@continue:
		move.b	obAngle(a0),d0
		subi.b	#$10,obAngle(a0)
		subi.b	#$40,d0
		jsr	(CalcSine).l
		muls.w	#$C00,d1
		swap	d1
		add.w	lamp_origX(a0),d1
		move.w	d1,obX(a0)
		muls.w	#$C00,d0
		swap	d0
		add.w	lamp_origY(a0),d0
		move.w	d0,obY(a0)
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	store information when you hit a lamppost
; ---------------------------------------------------------------------------

Lamp_StoreInfo:
		move.b	obSubtype(a0),(v_lastlamp).w 	; lamppost number
		move.b	(v_lastlamp).w,($FFFFFE31).w
		move.w	obX(a0),($FFFFFE32).w		; x-position
		move.w	obY(a0),($FFFFFE34).w		; y-position
		move.w	(v_rings).w,($FFFFFE36).w 	; rings
		move.b	(v_lifecount).w,($FFFFFE54).w 	; lives
		move.l	(v_time).w,($FFFFFE38).w 	; time
		move.b	(v_dle_routine).w,($FFFFFE3C).w ; routine counter for dynamic level mod
		move.w	(v_limitbtm2).w,($FFFFFE3E).w 	; lower y-boundary of level
		move.w	(v_screenposx).w,($FFFFFE40).w 	; screen x-position
		move.w	(v_screenposy).w,($FFFFFE42).w 	; screen y-position
		move.w	(v_bgscreenposx).w,($FFFFFE44).w ; bg position
		move.w	(v_bgscreenposy).w,($FFFFFE46).w 	; bg position
		move.w	(v_bg2screenposx).w,($FFFFFE48).w 	; bg position
		move.w	(v_bg2screenposy).w,($FFFFFE4A).w 	; bg position
		move.w	(v_bg3screenposx).w,($FFFFFE4C).w 	; bg position
		move.w	(v_bg3screenposy).w,($FFFFFE4E).w 	; bg position
		move.w	(v_waterpos2).w,($FFFFFE50).w 	; water height
		move.b	(v_wtr_routine).w,($FFFFFE52).w ; rountine counter for water
		move.b	(f_wtr_state).w,($FFFFFE53).w 	; water direction
		rts	

; ---------------------------------------------------------------------------
; Subroutine to	load stored info when you start	a level	from a lamppost
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Lamp_LoadInfo:
		lea	(v_player).w,a6
	    cmpi.b	#2,(v_reset_lvl_flags).l
	    beq.w	TimeTravel_LoadData
		move.b	($FFFFFE31).w,(v_lastlamp).w
		move.w	($FFFFFE32).w,(v_player+obX).w
		move.w	($FFFFFE34).w,(v_player+obY).w
		move.w	($FFFFFE36).w,(v_rings).w
		move.b	($FFFFFE54).w,(v_lifecount).w
		clr.w	(v_rings).w
		clr.b	(v_lifecount).w
		move.l	($FFFFFE38).w,(v_time).w
		move.b	#59,(v_timecent).w
		subq.b	#1,(v_timesec).w
		move.b	($FFFFFE3C).w,(v_dle_routine).w
		move.b	($FFFFFE52).w,(v_wtr_routine).w
		move.w	($FFFFFE3E).w,(v_limitbtm2).w
		move.w	($FFFFFE3E).w,(v_limitbtm1).w
		move.w	($FFFFFE40).w,(v_screenposx).w
		move.w	($FFFFFE42).w,(v_screenposy).w
		move.w	($FFFFFE44).w,(v_bgscreenposx).w
		move.w	($FFFFFE46).w,(v_bgscreenposy).w
		move.w	($FFFFFE48).w,(v_bg2screenposx).w
		move.w	($FFFFFE4A).w,(v_bg2screenposy).w
		move.w	($FFFFFE4C).w,(v_bg3screenposx).w
		move.w	($FFFFFE4E).w,(v_bg3screenposy).w
		cmpi.b	#1,(v_zone).w	; is this Labyrinth Zone?
		bne.s	@notlabyrinth	; if not, branch

		move.w	($FFFFFE50).w,(v_waterpos2).w
		move.b	($FFFFFE52).w,(v_wtr_routine).w
		move.b	($FFFFFE53).w,(f_wtr_state).w

	@notlabyrinth:
		tst.b	(v_lastlamp).w
		bpl.s	locret_170F6
		move.w	($FFFFFE32).w,d0
		subi.w	#$A0,d0
		move.w	d0,(v_limitleft2).w

locret_170F6:
		rts	
; -------------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR ObjCheckpoint_LoadData

TimeTravel_LoadData:
	move.w	(v_travel_x).l,oX(a6)
	move.w	(v_travel_y).l,oY(a6)
	move.b	(v_travel_status).l,oStatus(a6)
	move.w	(v_travel_gvel).l,oPlayerGVel(a6)
	move.w	(v_travel_xvel).l,oXVel(a6)
	move.w	(v_travel_yvel).l,oYVel(a6)
	move.w	(v_travel_ring_count).l,(v_ring_count).l
	move.b	(v_travel_1up_flags).l,(v_1up_flags).l
	move.l	(v_travel_time).l,(v_time).l
	move.b	(v_travel_water_rout).l,(v_water_routine).w
	move.w	(v_travel_btm_bound).l,(v_bottom_bound).w
	move.w	(v_travel_btm_bound).l,(v_dest_btm_bound).w
	move.w	(v_travel_cam_fg_x).l,(v_cam_fg_x).w
	move.w	(v_travel_cam_fg_y).l,(v_cam_fg_y).w
	move.w	(v_travel_cam_bg_x).l,(v_cam_bg_x).w
	move.w	(v_travel_cam_bg_y).l,(v_cam_bg_y).w
	move.w	(v_travel_cam_bg2_x).l,(v_cam_bg2_x).w
	move.w	(v_travel_cam_bg2_y).l,(v_cam_bg2_y).w
	move.w	(v_travel_cam_bg3_x).l,(v_cam_bg3_x).w
	move.w	(v_travel_cam_bg3_y).l,(v_cam_bg3_y).w
	cmpi.b	#6,(v_zone).l
	bne.s	@NoMini2
	move.b	(v_travel_mini_sonic).l,(v_mini_sonic).l

@NoMini2:
	tst.b	(v_reset_lvl_flags).l
	bpl.s	@End2
	move.w	(v_travel_x).l,d0
	subi.w	#320/2,d0
	move.w	d0,(v_left_bound).w

@End2:
	rts
; END OF FUNCTION CHUNK	FOR ObjCheckpoint_LoadData
; -------------------------------------------------------------------------------