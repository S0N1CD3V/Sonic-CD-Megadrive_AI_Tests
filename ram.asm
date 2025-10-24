
; ----------------------------------------------------------------------------- ;
;										;
;	Disassembly of R11A from Sonic CD					;
;										;
;	Created by Ralakimus							;
;	Special thanks to flamewing and TheStoneBanana for extensive help	;
;										;
;	File 		level/ram.asm						;
;	Contents 	Level RAM						;
;										;
; ----------------------------------------------------------------------------- ;

; -------------------------------------------------------------------------------
; Object structure
; -------------------------------------------------------------------------------

	rsreset

oID				rs.b	1		; ID
obj equ oID
oRender				rs.b	1		; Render flags
oSprFlags           equ oRender
oTile				rs.w	1		; Base tile ID
oMap				rs.l	1		; Sprite mappings pointer
oSprites            equ oMap

oX				rs.w	1		; X position
oYScr				rs.b	0		; Y position (screen mode)
oXSub				rs.w	1		; X position subpixel
oY				rs.l	1		; Y position

oXVel				rs.w	1		; X velocity
oYVel				rs.w	1		; Y velocity

oVar14				rs.b	1		; Object specific flags
oVar15				rs.b	1

oYRadius			rs.b	1		; Y radius
oXRadius			rs.b	1		; X radius
oPriority			rs.b	1		; Sprite draw priority level
oWidth				rs.b	1		; Width

oMapFrame			rs.b	1		; Sprite mapping frame ID
oSprFrame           equ oMapFrame
oAnimFrame			rs.b	1		; Animation script frame ID
oAnim				rs.b	1		; Animation ID
oPrevAnim			rs.b	1		; Previous previous animation ID
oAnimTime			rs.b	1		; Animation timer

oVar1F				rs.b	1		; Object specific flag

oVar20				rs.b	0		; Object specific flag
oColType			rs.b	1		; Collision type
oVar21				rs.b	0		; Object specific flag
oColStatus			rs.b	1		; Collision status

oStatus				rs.b	1		; Status flags
oFlags              equ oStatus
oRespawn			rs.b	1		; Respawn table entry ID
oRoutine			rs.b	1		; Routine ID
oVar25				rs.b	0		; Object specific flag
oRoutine2			rs.b	1		; Secondary routine ID
oAngle				rs.b	1		; Angle

oVar27				rs.b	1		; Object specific flag

oSubtype			rs.b	1		; Subtype ID
oSubtype2			rs.b	1		; Secondary subtype ID

oVar2A				rs.b	1		; Object specific flags
oVar2B				rs.b	1
oVar2C				rs.b	1
oVar2D				rs.b	1
oVar2E				rs.b	1
oVar2F				rs.b	1
oVar30				rs.b	1
oVar31				rs.b	1
oVar32				rs.b	1
oVar33				rs.b	1
oVar34				rs.b	1
oVar35				rs.b	1
oVar36				rs.b	1
oVar37				rs.b	1
oVar38				rs.b	1
oVar39				rs.b	1
oVar3A				rs.b	1
oVar3B				rs.b	1
oVar3C				rs.b	1
oVar3D				rs.b	1
oVar3E				rs.b	1
oVar3F				rs.b	1

render_flags:	equ oRender	; bitfield for x/y flip, display mode
art_tile:	equ oTile	; palette line & VRAM setting (2 bytes)
mappings:	equ oMap	; mappings address (4 bytes)
x_pos:		equ oX	; x-axis position (2-4 bytes)
y_pos:		equ oY	; y-axis position (2-4 bytes)
x_vel:		equ oXVel	; x-axis velocity (2 bytes)
y_vel:		equ oYVel	; y-axis velocity (2 bytes)
y_radius:	equ oYRadius	; height/2
x_radius:	equ oXRadius	; width/2
y_pixel =		2+x_pos ; and 3+x_pos ; y coordinate for objects using screen-space coordinate system
x_pixel =		x_pos ; and 1+x_pos ; x coordinate for objects using screen-space coordinate system

priority:	equ oPriority	; sprite stack priority -- 0 is front
width_pixels:	equ oWidth	; action width
mapping_frame:	equ oMapFrame	; current frame displayed
anim_frame:	equ oAnimFrame	; current frame in animation script
anim:		equ oAnim	; current animation
anim_frame_duration: equ oAnimTime ; time to next frame
status:		equ oStatus ; orientation or mode
respawn_index:	equ oRespawn	; respawn list index number
routine:	equ oRoutine	; routine number
routine_secondary: equ oRoutine2 ; secondary routine number
angle:		equ oAngle	; angle
subtype:	equ oSubtype	; object subtype

oVarLen				rs.b	0		; Length of object structure
oSize equ oVarLen
; -------------------------------------------------------------------------------
; Player object variables
; -------------------------------------------------------------------------------

oPlayerGVel			EQU	oVar14		; Ground velocity
oPlayerCharge			EQU	oVar2A		; Peelout/spindash charge timer

oPlayerCtrl			EQU	oVar2C		; Control flags
oPlayerJump			EQU	oVar3C		; Jump flag
oPlayerMoveLock			EQU	oVar3E		; Movement lock timer

oPlayerPriAngle			EQU	oVar36		; Primary angle
oPlayerSecAngle			EQU	oVar37		; Secondary angle
oPlayerStick			EQU	oVar38		; Collision stick flag

oPlayerHurt			EQU	oVar30		; Hurt timer
oPlayerInvinc			EQU	oVar32		; Invincibility timer
oPlayerSpeed			EQU	oVar34		; Speed shoes timer
oPlayerReset			EQU	oVar3A		; Reset timer

oPlayerRotAngle			EQU	oVar2B		; Platform rotation angle
oPlayerRotDist			EQU	oVar39		; Platform rotation distance

oPlayerPushObj			EQU	oVar20		; ID of object being pushed on
oPlayerStandObj			EQU	oVar3D		; ID of object being stood on

; -------------------------------------------------------------------------------
; RAM
; -------------------------------------------------------------------------------

	rsset	RAM_START+$F00

v_ipx_flags			rs.b	1
v_time_attack_mode		rs.b	1
v_saved_zone			rs.w	1
				rs.b	$C
v_time_attack_time		rs.l	1
v_time_attack_level		rs.w	1
v_ipx_vdp_reg1			rs.w	1
v_time_attack_last_lvl		rs.b	1
v_unk_buram_var			rs.b	1
v_good_futures_got		rs.b	1
Title_Press_Start				rs.b	1
v_demo_id			rs.b	1
v_title_menu_flags		rs.b	1
v_title_final_state				rs.b	1
v_buram_init			rs.b	1
v_got_time_stones		rs.b	1
v_cur_spec_stage		rs.b	1
v_pal_clear_flags		rs.b	1
v_unk_ending_flag		rs.b	1
v_ending_id			rs.b	1
v_spec_stage_beat		rs.b	1
				rs.b	$DA
v_unk_buffer 			rs.b	$200
v_obj_respawns 			rs.b	$2FE
ChunkAddress				rs.l	1
v_level_restart			rs.w	1
v_frame_timer 			rs.w	1
v_zone 				rs.b	1
v_act 				rs.b	1
v_life_count 			rs.b	1
v_use_player2 			rs.b	1
v_air_left 			rs.w	1
v_time_over 			rs.b	1
v_1up_flags 			rs.b	1
v_update_lives 			rs.b	1
v_update_rings 			rs.b	1
v_update_time 			rs.b	1
v_update_score 			rs.b	1
v_ring_count 			rs.w	1
v_time 				rs.l	1
v_score 			rs.l	1
v_load_plc_flags		rs.b	1
v_pal_fade_flags		rs.b	1
v_shield 			rs.b	1
v_invincible 			rs.b	1
v_speed_shoes 			rs.b	1
v_time_warp_on 			rs.b	1
v_reset_lvl_flags		rs.b	1
v_saved_reset_lvl_flags		rs.b	1
v_saved_x 			rs.w	1
v_saved_y 			rs.w	1
v_travel_ring_count		rs.w	1
v_saved_time 			rs.l	1
v_time_zone 			rs.b	1
				rs.b	1
v_saved_btm_bound		rs.w	1
v_saved_cam_fg_x		rs.w	1
v_saved_cam_fg_y		rs.w	1
v_saved_cam_bg_x		rs.w	1
v_saved_cam_bg_y		rs.w	1
v_saved_cam_bg2_x		rs.w	1
v_saved_cam_bg2_y		rs.w	1
v_saved_cam_bg3_x		rs.w	1
v_saved_cam_bg3_y		rs.w	1
v_saved_water_height2		rs.b	1
v_saved_water_rout		rs.b	1
v_saved_water_full		rs.b	1
v_travel_1up_flags		rs.b	1
v_travel_reset_lvl_flags	rs.b	1
Title_screen_option				rs.b	1
v_travel_x 			rs.w	1
v_travel_y 			rs.w	1
v_travel_status			rs.b	1
				rs.b	1
v_travel_btm_bound		rs.b	2
v_travel_cam_fg_x		rs.w	1
v_travel_cam_fg_y		rs.w	1
v_travel_cam_bg_x		rs.w	1
v_travel_cam_bg_y		rs.w	1
v_travel_cam_bg2_x		rs.b	2
v_travel_cam_bg2_y		rs.b	2
v_travel_cam_bg3_x		rs.b	2
v_travel_cam_bg3_y		rs.b	2
v_travel_water_height2		rs.w	1
v_travel_water_rout		rs.b	1
v_travel_water_full		rs.b	1
v_travel_gvel 			rs.w	1
v_travel_xvel 			rs.w	1
v_travel_yvel 			rs.w	1
v_good_future 			rs.b	1
goodfuture equ v_good_future
v_load_shield_art		rs.b	1
v_unk_flag 			rs.b	1
v_destroyed_projector		rs.b	1
v_entered_big_ring		rs.b	1
v_blue_ring 			rs.b	1
v_travel_time 			rs.l	1
v_last_camera_plc		rs.w	1
v_load_menu_art				rs.b	1
v_amy_taken			rs.b	1
v_next_score_1up		rs.l	1
v_angle_buffer 			rs.b	1
v_angle_normal_buf		rs.b	1
v_quadrant_normal_buf		rs.b	1
v_floor_dist 			rs.b	1
v_demo_mode 			rs.w	1
BlockAddress				rs.l	1
v_hw_version 			rs.b	1
				rs.b	1
v_debug_mode_enabled		rs.w	1
v_init_flag 			rs.l	1
v_last_checkpoint		rs.b	1
				rs.b	1
v_good_future_flags		rs.b	1
v_saved_mini_sonic		rs.b	1
				rs.b	1
v_travel_mini_sonic		rs.b	1
				rs.b	$6C
v_flower_pos_buffer		rs.b	$300
v_flower_count			rs.b	3
v_enable_display		rs.b	1
v_debug_object 			rs.b	1
				rs.b	1
v_debug_mode 			rs.w	1
				rs.w	1
v_frame_count 			rs.l	1
v_time_stop_timer		rs.w	1
v_logspike_anim_timer		rs.b	1
v_logspike_anim_frame		rs.b	1
v_ring_anim_timer		rs.b	1
v_ring_anim_frame		rs.b	1
v_unk_anim_timer		rs.b	1
v_unk_anim_frame		rs.b	1
v_ring_spill_timer		rs.b	1
v_ring_spill_frame		rs.b	1
v_ring_spill_accum		rs.b	2
				rs.b	$C
v_cam_x_fg_copy			rs.l	1
v_cam_y_fg_copy			rs.l	1
v_cam_x_bg_copy			rs.l	1
v_cam_y_bg_copy			rs.l	1
v_cam_x_bg2_copy		rs.l	1
v_cam_y_bg2_copy		rs.l	1
v_cam_x_bg3_copy		rs.l	1
v_cam_y_bg3_copy		rs.l	1
v_scroll_flags_copy		rs.l	1
				rs.l	1
v_debug_block 			rs.w	1
				rs.l	1
v_debug_subtype2		rs.b	1
				rs.b	1
v_display_low_plane		rs.b	1
v_level_started			rs.b	1
v_boss_music_playing		rs.b	1
				rs.w	1
v_mini_sonic 			rs.b	1
				rs.b	$24
v_dma_buffer 			rs.b	$480
v_layer_speeds 			rs.b	$200
v_level_blocks 			rs.b	$2000
v_unk_buffer2 			rs.b	$1000
v_snddriver_ram  rs.b	$5C0	; start of RAM for the sound driver data ($5C0 bytes)

; =================================================================================
; From here on, until otherwise stated, all offsets are relative to v_snddriver_ram
; =================================================================================
v_startofvariables:	equ $000
v_sndprio:		equ $000	; sound priority (priority of new music/SFX must be higher or equal to this value or it won't play; bit 7 of priority being set prevents this value from changing)
v_main_tempo_timeout:	equ $001	; Counts down to zero; when zero, resets to next value and delays song by 1 frame
v_main_tempo:		equ $002	; Used for music only
f_pausemusic:		equ $003	; flag set to stop music when paused
v_fadeout_counter:	equ $004

v_fadeout_delay:	equ $006
v_communication_byte:	equ $007	; used in Ristar to sync with a boss' attacks; unused here
f_updating_dac:		equ $008	; $80 if updating DAC, $00 otherwise
v_sound_id:		equ $009	; sound or music copied from below
v_soundqueue0:		equ $00A	; sound or music to play
v_soundqueue1:		equ $00B	; special sound to play
v_soundqueue2:		equ $00C	; unused sound to play

f_voice_selector:	equ $00E	; $00 = use music voice pointer; $40 = use special voice pointer; $80 = use track voice pointer

v_voice_ptr:		equ $018	; voice data pointer (4 bytes)

v_special_voice_ptr:	equ $020	; voice data pointer for special SFX ($D0-$DF) (4 bytes)

f_fadein_flag:		equ $024	; Flag for fade in
v_fadein_delay:		equ $025
v_fadein_counter:	equ $026	; Timer for fade in/out
f_1up_playing:		equ $027	; flag indicating 1-up song is playing
v_tempo_mod:		equ $028	; music - tempo modifier
v_speeduptempo:		equ $029	; music - tempo modifier with speed shoes
f_speedup:		equ $02A	; flag indicating whether speed shoes tempo is on ($80) or off ($00)
v_ring_speaker:		equ $02B	; which speaker the "ring" sound is played in (00 = right; 01 = left)
f_push_playing:		equ $02C	; if set, prevents further push sounds from playing

v_music_track_ram:	equ $040	; Start of music RAM

v_music_fmdac_tracks:	equ v_music_track_ram+TrackSz*0
v_music_dac_track:	equ v_music_fmdac_tracks+TrackSz*0
v_music_fm_tracks:	equ v_music_fmdac_tracks+TrackSz*1
v_music_fm1_track:	equ v_music_fm_tracks+TrackSz*0
v_music_fm2_track:	equ v_music_fm_tracks+TrackSz*1
v_music_fm3_track:	equ v_music_fm_tracks+TrackSz*2
v_music_fm4_track:	equ v_music_fm_tracks+TrackSz*3
v_music_fm5_track:	equ v_music_fm_tracks+TrackSz*4
v_music_fm6_track:	equ v_music_fm_tracks+TrackSz*5
v_music_fm_tracks_end:	equ v_music_fm_tracks+TrackSz*6
v_music_fmdac_tracks_end:	equ v_music_fm_tracks_end
v_music_psg_tracks:	equ v_music_fmdac_tracks_end
v_music_psg1_track:	equ v_music_psg_tracks+TrackSz*0
v_music_psg2_track:	equ v_music_psg_tracks+TrackSz*1
v_music_psg3_track:	equ v_music_psg_tracks+TrackSz*2
v_music_psg_tracks_end:	equ v_music_psg_tracks+TrackSz*3
v_music_track_ram_end:	equ v_music_psg_tracks_end

v_sfx_track_ram:	equ v_music_track_ram_end	; Start of SFX RAM, straight after the end of music RAM

v_sfx_fm_tracks:	equ v_sfx_track_ram+TrackSz*0
v_sfx_fm3_track:	equ v_sfx_fm_tracks+TrackSz*0
v_sfx_fm4_track:	equ v_sfx_fm_tracks+TrackSz*1
v_sfx_fm5_track:	equ v_sfx_fm_tracks+TrackSz*2
v_sfx_fm_tracks_end:	equ v_sfx_fm_tracks+TrackSz*3
v_sfx_psg_tracks:	equ v_sfx_fm_tracks_end
v_sfx_psg1_track:	equ v_sfx_psg_tracks+TrackSz*0
v_sfx_psg2_track:	equ v_sfx_psg_tracks+TrackSz*1
v_sfx_psg3_track:	equ v_sfx_psg_tracks+TrackSz*2
v_sfx_psg_tracks_end:	equ v_sfx_psg_tracks+TrackSz*3
v_sfx_track_ram_end:	equ v_sfx_psg_tracks_end

v_spcsfx_track_ram:	equ v_sfx_track_ram_end	; Start of special SFX RAM, straight after the end of SFX RAM

v_spcsfx_fm4_track:	equ v_spcsfx_track_ram+TrackSz*0
v_spcsfx_psg3_track:	equ v_spcsfx_track_ram+TrackSz*1
v_spcsfx_track_ram_end:	equ v_spcsfx_track_ram+TrackSz*2

v_1up_ram_copy:		equ v_spcsfx_track_ram_end

; =================================================================================
; From here on, no longer relative to sound driver RAM
; =================================================================================

				rs.b	$2A40

	rsset	RAM_START+$FF008000

				rs.b	$2000
v_lvl_layout 			rs.b	$800
v_deform_buffer			rs.b	$200
deformbuffer equ v_deform_buffer
v_nem_dec_buffer		rs.b	$200
v_obj_draw_queue		rs.b	$400
				rs.b	$1800
v_sonic_art 			rs.b	$300
v_sonic_record_buf		rs.b	$100
v_hscroll 			rs.b	$400
hscroll equ v_hscroll
v_objects			rs.b	0
objects equ v_objects
v_player 			rs.b	$40
objplayerslot equ v_player
v_player2 			rs.b	$40
v_obj_hud_score			rs.b	$40
v_obj_hud_lives			rs.b	$40
v_obj_title_card		rs.b	$40
v_obj_hud_rings			rs.b	$40
v_obj_shield 			rs.b	$40
v_obj_bubbles 			rs.b	$40
v_obj_inv_star1			rs.b	$40
v_obj_inv_star2			rs.b	$40
v_obj_inv_star3			rs.b	$40
v_obj_inv_star4			rs.b	$40
v_obj_timewarp_star1		rs.b	$40
v_obj_timewarp_star2		rs.b	$40
v_obj_timewarp_star3		rs.b	$40
v_obj_timewarp_star4		rs.b	$40
v_obj_sonicarm				rs.b	$40
v_obj_banner				rs.b	$40
v_obj_titlemenu				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
				rs.b	$40
v_obj_hud_time_icon		rs.b	$40
v_dyn_objects 			rs.b	$1800
v_objects_end			rs.b	$A
v_snd_queue_1 			rs.b	1
v_snd_queue_2 			rs.b	1
v_snd_queue_3 			rs.b	1
				rs.b	$5F3
v_game_mode 			rs.b	1
				rs.b	1
v_player_held 			rs.b	1
v_player_pressed		rs.b	1
v_ctrl1_held 			rs.b	1
v_ctrl1_pressed			rs.b	1
Ctrl_1_Press equ v_ctrl1_pressed
v_ctrl2_held 			rs.b	1
v_ctrl2_pressed			rs.b	1
Ctrl_2_Press equ v_ctrl2_pressed
				rs.l	1
v_vdp_reg_1 			rs.w	1
				rs.b	6
v_vint_timer 			rs.w	1
v_vscroll 			rs.l	1
vscrollscreen equ v_vscroll
v_hscroll_full 			rs.l	1
				rs.b	6
v_hint_counter 			rs.w	1
v_pal_fade_start		rs.b	1
v_pal_fade_len 			rs.b	1
v_misc_variables		rs.b	0
v_vint_e_count 			rs.b	1
				rs.b	1
v_vint_routine 			rs.b	1
				rs.b	1
v_sprite_count 			rs.b	1
				rs.b	9
v_rng_seed 			rs.l	1
v_paused 			rs.w	1
				rs.l	1
v_dma_cmd_cache			rs.w	1
				rs.l	1
v_water_height 			rs.w	1
v_water_height2			rs.w	1
				rs.b	3
v_water_routine			rs.b	1
v_water_full 			rs.b	1
				rs.b	$17
v_ani_art_frames		rs.b	6
v_ani_art_timers		rs.b	6
				rs.b	$E
v_plc_buffer 			rs.b	$60
v_plc_nem_write 		rs.l	1
v_plc_repeat 			rs.l	1
v_plc_pixel 			rs.l	1
v_plc_row 			rs.l	1
v_plc_read 			rs.l	1
v_plc_shift 			rs.l	1
v_plc_tile_cnt 			rs.w	1
v_plc_proc_tile_cnt 		rs.w	1
v_hint_flag 			rs.w	1
				rs.w	1
v_cam_fg_x 			rs.l	1
camerax equ v_cam_fg_x
v_cam_fg_y 			rs.l	1
cameray equ v_cam_fg_y
v_cam_bg_x 			rs.l	1
camerabgx equ v_cam_bg_x
v_cam_bg_y 			rs.l	1
camerabgy equ v_cam_bg_y
v_cam_bg2_x 			rs.l	1
camerabg2x equ v_cam_bg2_x
v_cam_bg2_y 			rs.l	1
camerabg2y equ v_cam_bg2_y
v_cam_bg3_x 			rs.l	1
camerabg3x equ v_cam_bg3_x
v_cam_bg3_y 			rs.l	1
camerabg3y equ v_cam_bg3_y
v_dest_left_bound		rs.w	1
destleftbound equ v_dest_left_bound
v_dest_right_bound		rs.b	2
destrightbound equ v_dest_right_bound
v_dest_top_bound		rs.w	1
v_dest_btm_bound		rs.w	1
destbottombound equ v_dest_btm_bound
v_left_bound 			rs.w	1
leftbound equ v_left_bound
v_right_bound 			rs.w	1
rightbound equ v_right_bound
v_top_bound 			rs.w	1
v_bottom_bound 			rs.w	1
bottombound equ v_bottom_bound
v_unused_f730 			rs.w	1
v_left_bound3 			rs.w	1
				rs.b	6
v_scroll_diff_x			rs.w	1
scrollxdiff equ v_scroll_diff_x
v_scroll_diff_y			rs.w	1
scrollydiff equ v_scroll_diff_y
v_cam_y_center 			rs.w	1
camycenter equ v_cam_y_center
v_unused_f740 			rs.b	1
v_unused_f741 			rs.b	1
v_event_routine			rs.w	1
v_scroll_lock 			rs.w	1
scrolllock equ v_scroll_lock
v_unused_f746 			rs.w	1
v_unused_f748 			rs.w	1
v_horiz_blk_crossed_flag	rs.b	1
v_verti_blk_crossed_flag	rs.b	1
v_horiz_blk_cross_flag_bg	rs.b	1
v_verti_blk_cross_flag_bg	rs.b	1
v_horiz_blk_cross_flag_bg2	rs.b	2
v_horiz_blk_cross_flag_bg3	rs.b	1
				rs.b	1
				rs.b	1
				rs.b	1
v_scroll_flags 			rs.w	1
scrollflags equ v_scroll_flags
v_scroll_flags_bg		rs.w	1
scrollflagsbg equ v_scroll_flags_bg
v_scroll_flags_bg2		rs.w	1
scrollflagsbg2 equ v_scroll_flags_bg2
v_scroll_flags_bg3		rs.w	1
scrollflagsbg3 equ v_scroll_flags_bg3
v_btm_bound_shifting		rs.w	1
				rs.w	1
v_sonic_top_speed		rs.w	1
v_sonic_acceleration		rs.w	1
v_sonic_deceleration		rs.w	1
v_sonic_last_frame		rs.b	1
v_sonic_frame_changed		rs.b	1
v_primary_angle			rs.b	1
				rs.b	1
v_secondary_angle		rs.b	1
				rs.b	1
v_lvl_obj_man_rout		rs.b	1
				rs.b	1
v_obj_prev_cam_x		rs.w	1
v_obj_load_addr_right		rs.l	1
v_obj_load_addr_left		rs.l	1
v_obj_load_addr2_right		rs.l	1
v_obj_load_addr2_left		rs.l	1
v_bored_timer 			rs.w	1
v_p2_bored_timer 		rs.w	1
v_time_warp_dir			rs.b	1
				rs.b	1
v_time_warp_timer		rs.w	1
v_look_mode 			rs.b	1
				rs.b	1
v_demo_data_ptr 		rs.l	1
v_demo_timer 			rs.w	1
v_s1_demo_data_index 		rs.w	1
				rs.l	1
v_collision_ptr			rs.l	1
				rs.b	6
v_cam_x_center 			rs.w	1
				rs.b	5
v_boss_flags			rs.b	1
bossflags equ v_boss_flags
v_sonic_record_index		rs.w	1
v_boss_fight 			rs.b	1
bossfight equ v_boss_fight
				rs.b	1
v_loop_chunks 			rs.l	1
v_palcyc_steps 			rs.b	7
v_palcyc_timers			rs.b	7
				rs.b	9
v_wind_tunnel_on		rs.b	1
				rs.b	1
				rs.b	1
v_jump_only 			rs.b	1
				rs.b	1
v_ctrl_locked 			rs.b	1
				rs.b	3
v_chain_bonus_counter		rs.w	1
v_bonus_countdown_1		rs.w	1
v_bonus_countdown_2		rs.w	1
v_update_bonus_score		rs.b	1
				rs.b	3
v_saved_sr 			rs.w	1
				rs.b	$24
v_sprites 			rs.b	$200
v_water_fade_pal		rs.b	$80
v_water_palette			rs.b	$80
v_palette 			rs.b	$80
v_fade_palette 			rs.b	$80
; ----------------------------------------------------------------------------- ;
