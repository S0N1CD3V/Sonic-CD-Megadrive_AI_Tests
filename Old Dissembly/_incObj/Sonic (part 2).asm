; ---------------------------------------------------------------------------
; Sonic	when he	gets hurt
; ---------------------------------------------------------------------------

Sonic_Hurt:	; Routine 4
		jsr	(SpeedToPos).l
		addi.w	#$30,obVelY(a0)
		btst	#6,obStatus(a0)
		beq.s	loc_1380C
		subi.w	#$20,obVelY(a0)

loc_1380C:
		bsr.w	Sonic_HurtStop
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Animate
;		bsr.w	Sonic_LoadGfx
		jmp	(DisplaySprite).l

; ---------------------------------------------------------------------------
; Subroutine to	stop Sonic falling after he's been hurt
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HurtStop:
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0
		bcs.s	Go_KillSonic
		bsr.w	Sonic_Floor
		btst	#1,obStatus(a0)
		bne.s	locret_13860
		moveq	#0,d0
		move.w	d0,obVelY(a0)
		move.w	d0,obVelX(a0)
		move.w	d0,obInertia(a0)
		move.b	#id_Walk,obAnim(a0)
		subq.b	#2,obRoutine(a0)
		move.w	#$78,$30(a0)

locret_13860:
		rts	
; End of function Sonic_HurtStop
killplayer:
Go_KillSonic:
        jmp (KillSonic).l
; ---------------------------------------------------------------------------
; Sonic	when he	dies
; ---------------------------------------------------------------------------

Sonic_Death:	; Routine 6
		bsr.w	GameOver
		jsr	(ObjectFall).l
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Animate
;		bsr.w	Sonic_LoadGfx
		jmp	(DisplaySprite).l

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


GameOver:
		move.w	(v_limitbtm2).w,d0
		addi.w	#$100,d0
		cmp.w	obY(a0),d0
		bcc.w	locret_13900
		move.w	#-$38,obVelY(a0)
		addq.b	#2,obRoutine(a0)
		clr.b	(f_timecount).w	; stop time counter
		addq.b	#1,(f_lifecount).w ; update lives counter
		subq.b	#1,(v_lives).w	; subtract 1 from number of lives
		bne.s	loc_138D4
		move.w	#0,$3A(a0)
		move.b	#id_GameOverCard,(v_objspace+$80).w ; load GAME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object
		move.b	#1,(v_objspace+$C0+obFrame).w ; set OVER object to correct frame
		clr.b	(f_timeover).w

loc_138C2:
		music	bgm_GameOver,0,0,0	; play game over music
		moveq	#3,d0
		jmp	(AddPLC).l	; load game over patterns
; ===========================================================================

loc_138D4:
		move.w	#60,$3A(a0)	; set time delay to 1 second
		tst.b	(f_timeover).w	; is TIME OVER tag set?
		beq.s	locret_13900	; if not, branch
		move.w	#0,$3A(a0)
		move.b	#id_GameOverCard,(v_objspace+$80).w ; load TIME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object
		move.b	#2,(v_objspace+$80+obFrame).w
		move.b	#3,(v_objspace+$C0+obFrame).w
		bra.s	loc_138C2
; ===========================================================================

locret_13900:
		rts	
; End of function GameOver

; ---------------------------------------------------------------------------
; Sonic	when the level is restarted
; ---------------------------------------------------------------------------

Sonic_ResetLevel:; Routine 8
		tst.w	$3A(a0)
		beq.s	locret_13914
		subq.w	#1,$3A(a0)	; subtract 1 from time delay
		bne.s	locret_13914
		move.w	#1,(f_restart).w ; restart the level

	locret_13914:
		rts	
; -------------------------------------------------------------------------------
; Save various variables for time travel
; -------------------------------------------------------------------------------

TimeTravel_SaveData:					; Save some values
	move.b	(v_reset_lvl_flags).l,(v_travel_reset_lvl_flags).l
	move.w	oX(a0),(v_travel_x).l
	move.w	oY(a0),(v_travel_y).l
	move.w	oPlayerGVel(a0),(v_travel_gvel).l
	move.w	oXVel(a0),(v_travel_xvel).l
	move.w	oYVel(a0),(v_travel_yvel).l
	move.b	oStatus(a0),(v_travel_status).l
	bclr	#3,(v_travel_status).l			; Don't be marked as standing on an object
	bclr	#6,(v_travel_status).l			; Don't be marked as being underwater
	move.b	(v_water_routine).w,(v_travel_water_rout).l
	move.w	(v_bottom_bound).w,(v_travel_btm_bound).l
	move.w	(v_cam_fg_x).w,(v_travel_cam_fg_x).l
	move.w	(v_cam_fg_y).w,(v_travel_cam_fg_y).l
	move.w	(v_cam_bg_x).w,(v_travel_cam_bg_x).l
	move.w	(v_cam_bg_y).w,(v_travel_cam_bg_y).l
	move.w	(v_cam_bg2_x).w,(v_travel_cam_bg2_x).l
	move.w	(v_cam_bg2_y).w,(v_travel_cam_bg2_y).l
	move.w	(v_cam_bg3_x).w,(v_travel_cam_bg3_x).l
	move.w	(v_cam_bg3_y).w,(v_travel_cam_bg3_y).l
	move.w	(v_water_height2).w,(v_travel_water_height2).l
	move.b	(v_water_routine).w,(v_travel_water_rout).l
	move.b	(v_water_full).w,(v_travel_water_full).l
	move.w	(v_ring_count).l,(v_travel_ring_count).l
	move.b	(v_1up_flags).l,(v_travel_1up_flags).l

	move.l	(v_time).l,d0				; Move the level timer to 5:00 if we are past that
	cmpi.l	#$50000,d0
	bcs.s	@CapTime
	move.l	#$50000,d0

@CapTime:
	move.l	d0,(v_travel_time).l

	move.b	(v_mini_sonic).l,(v_travel_mini_sonic).l
	rts

; -------------------------------------------------------------------------------
; Handle time warping for Sonic
; -------------------------------------------------------------------------------

ObjSonic_TimeWarp:
	cmpi.w	#0,(v_zone).l				; Are we in Palmtree Panic act 1?
	bne.s	@NotPPZ1				; If not, branch
	tst.b	(v_time_zone).l				; Are we in the past?
	beq.s	@Past					; If so, branch
	cmpi.b	#2,(v_time_zone).l			; Are we in the future?
	bne.s	@NotPPZ1				; If not, branch

@Past:
	cmpi.w	#$900,oX(a0)				; Are we in the first 3D ramp section?
	bcs.w	@StopTimeWarp				; If so, branch

@NotPPZ1:
	tst.b	oPlayerCharge(a0)			; Are we charging a peelout or spindash?
	bne.w	@End2					; If so, branch
	tst.b	(v_time_warp_dir).w			; Have we touched a time post?
	beq.w	@End2					; If not, branch

	move.w	#$600,d2				; Minimum speed in which to keep the time warp going

	moveq	#0,d0					; Get current ground velocity
	move.w	oPlayerGVel(a0),d0
	bpl.s	@PosInertia
	neg.w	d0

@PosInertia:
	tst.w	(v_time_warp_timer).w			; Is the time warp timer active?
	bne.s	@TimerGoing				; If so, branch
	move.w	#1,(v_time_warp_timer).w		; Make the time warp timer active

@TimerGoing:
	move.w	(v_time_warp_timer).w,d1		; Get current time warp time
	cmpi.w	#230,d1					; Should we time travel now?
	bcs.s	@KeepGoing				; If not, branch

	move.b	#1,(v_level_restart).l			; Set to go to the time travel cutscene
	jmp	FadeOutMusic

@KeepGoing:
	cmpi.w	#210,d1					; Are we about to time travel soon?
	bcs.s	@CheckStars				; If not, branch

	cmpi.b	#2,(v_reset_lvl_flags).l		; Are we already in the process of time travelling?
	beq.s	@End					; If so, branch

	move.b	#1,(v_scroll_lock).w			; Lock the screen in place

	move.b	(v_time_zone).l,d0			; Get current time zone
	bne.s	@GetNewTime				; If we are not in the past, branch

	move.w	#$82,d0					; Fade out music
	jsr	PlaySound

	moveq	#0,d0					; We are currently in the past

@GetNewTime:
	add.b	(v_time_warp_dir).w,d0			; Set the new time period
	bpl.s	@NoUnderflow				; If we aren't trying to go past the past, branch
	moveq	#0,d0					; Stay in this game's "past" time period
	bra.s	@GotNewTime

@NoUnderflow:
	cmpi.b	#3,d0					; Are we trying to go forward past the future?
	bcs.s	@GotNewTime				; If not, branch
	moveq	#2,d0					; Stay in this game's "future" time period

@GotNewTime:
	bset	#7,d0					; Mark time travel as active
	move.b	d0,(v_time_zone).l

	bsr.w	TimeTravel_SaveData			; Save time travel data

	move.b	#2,(v_reset_lvl_flags).l		; Mark that we are now in the process of time travelling

@End:
	rts

@CheckStars:
	cmpi.w	#90,d1					; Have we tried time travelling for a bit already?
	bcc.s	@CheckStop				; If so, branch

	cmp.w	d2,d0					; Are we going fast enough?
	bcc.w	ObjSonic_MakeTimeWarpStars		; If so, branch
	clr.w	(v_time_warp_timer).w			; If not, reset time warping until we go fast again
	clr.b	(v_time_warp_on).l
	rts

@CheckStop:
	cmp.w	d2,d0					; Are we going fast enough?
	bcc.s	@End2					; If so, branch

@StopTimeWarp:
	clr.w	(v_time_warp_timer).w			; Disable time warping altogether until the next time post is touched
	clr.b	(v_time_warp_dir).w
	clr.b	(v_time_warp_on).l

@End2:
	rts		
; -------------------------------------------------------------------------------
; Create time warp stars
; -------------------------------------------------------------------------------

ObjSonic_MakeTimeWarpStars:
	tst.b	(v_obj_timewarp_star1).w		; Are they already loaded?
	bne.s	@End					; If so, branch

	move.b	#1,(v_time_warp_on).l			; Set time warp flag

	move.b	#id_ShieldItem,(v_obj_timewarp_star1).w		; Load time warp stars
	move.b	#5,(v_obj_timewarp_star1+oAnim).w
	move.b	#id_ShieldItem,(v_obj_timewarp_star2).w
	move.b	#6,(v_obj_timewarp_star2+oAnim).w
	move.b	#id_ShieldItem,(v_obj_timewarp_star3).w
	move.b	#7,(v_obj_timewarp_star3+oAnim).w
	move.b	#id_ShieldItem,(v_obj_timewarp_star4).w
	move.b	#8,(v_obj_timewarp_star4+oAnim).w

@End:
	rts
	rts	