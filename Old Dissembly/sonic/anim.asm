Ani_Sonic:
ptr_Walk:	dc.w	SonAni_Walk-Ani_Sonic ;0
ptr_Run:	dc.w	SonAni_Run-Ani_Sonic  ;1
ptr_Roll:	dc.w	SonAni_Roll-Ani_Sonic ;2
ptr_Roll2:	dc.w	SonAni_RollFast-Ani_Sonic ;3
ptr_Push:	dc.w	SonAni_Push-Ani_Sonic ;4
ptr_Wait:	dc.w	SonAni_Idle-Ani_Sonic ;5
ptr_Balance:	dc.w SonAni_Balance-Ani_Sonic ;6
ptr_LookUp:	dc.w	SonAni_LookUp-Ani_Sonic ;7
ptr_Duck:	dc.w	SonAni_Duck-Ani_Sonic ;8
ptr_Warp1:	dc.w	SonAni_Walk0-Ani_Sonic ;9
ptr_Warp2:	dc.w	SonAni_Walk1-Ani_Sonic ;A
ptr_Warp3:	dc.w	SonAni_Walk2-Ani_Sonic ;B
ptr_Warp4:	dc.w	SonAni_Walk3-Ani_Sonic ;C
ptr_Stop:	dc.w	SonAni_Skid-Ani_Sonic ;D
ptr_Float2:	dc.w	SonAni_Unk0E-Ani_Sonic ;E
ptr_Float1:	dc.w	SonAni_Float-Ani_Sonic ;F
ptr_Spring:	dc.w	SonAni_Spring-Ani_Sonic ;10
ptr_Hang:	dc.w	SonAni_Hang-Ani_Sonic ;11
ptr_Leap1:	dc.w	SonAni_Unk12-Ani_Sonic ;12
ptr_Leap2:	dc.w	SonAni_Unk13-Ani_Sonic ;13
ptr_Surf:	dc.w	SonAni_Unk14-Ani_Sonic ;14
ptr_GetAir:	dc.w	SonAni_Bubble-Ani_Sonic ;15
ptr_Burnt:	dc.w	SonAni_DeathBW-Ani_Sonic ;16
ptr_Drown:	dc.w	SonAni_Drown-Ani_Sonic ;17
ptr_Death:	dc.w	SonAni_Death-Ani_Sonic ;18
ptr_Shrink:	dc.w	SonAni_Unk19-Ani_Sonic ;19
ptr_Hurt:	dc.w	SonAni_Hurt-Ani_Sonic ;1A
ptr_WaterSlide:	dc.w SonAni_Slide-Ani_Sonic ;1B
ptr_Null:	dc.w	SonAni_Blank-Ani_Sonic ;1C
ptr_Float3:	dc.w	SonAni_Unk1D-Ani_Sonic ;1D
ptr_Float4:	dc.w	SonAni_Unk1E-Ani_Sonic ;1E
	dc.w	SonAni_IdleMini-Ani_Sonic ;1F
	dc.w	SonAni_DuckMini-Ani_Sonic ;20
	dc.w	SonAni_WalkMini-Ani_Sonic ;21
	dc.w	SonAni_RunMini-Ani_Sonic ;22
	dc.w	SonAni_RollMini-Ani_Sonic ;23
	dc.w	SonAni_SkidMini-Ani_Sonic ;24
	dc.w	SonAni_HurtMini-Ani_Sonic ;25
	dc.w	SonAni_BalanceMini-Ani_Sonic ;26
	dc.w	SonAni_PushMini-Ani_Sonic ;27
	dc.w	SonAni_StandMini-Ani_Sonic ;28
	dc.w	SonAni_LookBack-Ani_Sonic ;29
	dc.w	SonAni_Sneeze-Ani_Sonic ;2A
	dc.w	SonAni_GiveUp-Ani_Sonic ;2B
	dc.w	SonAni_Hang2-Ani_Sonic ;2C
	dc.w	SonAni_Balance3D-Ani_Sonic ;2D
	dc.w	SonAni_Wade-Ani_Sonic ;2E
	dc.w	SonAni_Float2-Ani_Sonic ;2F
	dc.w	SonAni_Unk30-Ani_Sonic ;30
	dc.w	SonAni_Peelout-Ani_Sonic ;31
	dc.w	SonAni_Balance2-Ani_Sonic ;32
	dc.w	SonAni_RotateBack-Ani_Sonic ;33
	dc.w	SonAni_RotateFront-Ani_Sonic ;34
	dc.w	SonAni_Run3D-Ani_Sonic ;35
	dc.w	SonAni_Roll3D-Ani_Sonic ;36
	dc.w	SonAni_FallAway-Ani_Sonic ;37
	dc.w	SonAni_Grow-Ani_Sonic ;38
	dc.w	SonAni_Shrink-Ani_Sonic ;39
	dc.w	SonAni_Roll3D-Ani_Sonic ;3A
	dc.w	SonAni_FallAway-Ani_Sonic ;3B
SonAni_Walk:	dc.b	$FF, $35, $36, $37, $38, $33, $34, $FF
SonAni_Run:	dc.b	$FF, $4B, $4C, $4D, $4E, $FF, $FF, $FF
SonAni_Roll:	dc.b	$FE, $2D, $2E, $2F, $30, $31, $FF, $FF
SonAni_RollFast:dc.b	$FE, $2D, $2E, $31, $2F, $30, $31, $FF
SonAni_Push:	dc.b	$FD, $64, $65, $66, $67, $FF, $FF, $FF
SonAni_Idle:	dc.b	$17, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 2, 2, 2, 3, 4, $FE, 2
		dc.b	0
SonAni_Balance:	dc.b	$F, $6D, $6E, $83, $84, $FF
SonAni_LookUp:	dc.b	$3F, 5, $FF
		dc.b	0
SonAni_Duck:	dc.b	$3F, $60, $FF
		dc.b	0
SonAni_Walk0:	dc.b	$3F, $33, $FF
		dc.b	0
SonAni_Walk1:	dc.b	$3F, $34, $FF
		dc.b	0
SonAni_Walk2:	dc.b	$3F, $35, $FF
		dc.b	0
SonAni_Walk3:	dc.b	$3F, $36, $FF
		dc.b	0
SonAni_Skid:	dc.b	7, $5B, $5C, $7F, $FF
		dc.b	0
SonAni_Unk0E:	dc.b	7, $3C, $3F, $FF
SonAni_Float:	dc.b	7, $61, $62, $B9, $63, $BA, $FF
		dc.b	0
SonAni_Spring:	dc.b	3, $32, $90, $91, $92, $93, $FF
		dc.b	0
SonAni_Hang:	dc.b	4, $6B, $6C, $FF
SonAni_Unk12:	dc.b	$F, $43, $43, $43, $FE, 1
SonAni_Unk13:	dc.b	$F, $43, $44, $FE, 1
		dc.b	0
SonAni_Unk14:	dc.b	$3F, $49, $FF
		dc.b	0
SonAni_Bubble:	dc.b	$B, $5F, $5F, $37, $38, $FD, 0
		dc.b	0
SonAni_DeathBW:	dc.b	$20, $68, $FF
		dc.b	0
SonAni_Drown:	dc.b	$2F, $69, $FF
		dc.b	0
SonAni_Death:	dc.b	3, $6A, $FF
		dc.b	0
SonAni_Unk19:	dc.b	3, $4E, $4F, $50, $51, $52, 0, $FE, 1
		dc.b	0
SonAni_Hurt:	dc.b	3, $5D, $FF
		dc.b	0
SonAni_Slide:	dc.b	7, $5D, $5E, $FF
SonAni_Blank:	dc.b	$77, 0, $FD, 0
SonAni_Unk1D:	dc.b	3, $3C, $3D, $53, $3E, $54, $FF
		dc.b	0
SonAni_Unk1E:	dc.b	3, $3C, $FD
		dc.b	0
SonAni_IdleMini:dc.b	$17, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $6F, $70, $70, $70, $71, $70, $71, $FE, 2
		dc.b	0
SonAni_DuckMini:dc.b	$3F, $72, $FF
		dc.b	0
SonAni_WalkMini:dc.b	$FF, $73, $74, $75, $74, $FF
SonAni_RunMini:	dc.b	$FF, $76, $77, $FF, $FF, $FF
SonAni_RollMini:dc.b	$FE, $7C, $7D, $7E, $FF, $FF
SonAni_SkidMini:dc.b	7, $78, $78, $FF
SonAni_HurtMini:dc.b	3, $79, $FF
		dc.b	0
SonAni_BalanceMini:dc.b	$1F, $7A, $7B, $FF
SonAni_PushMini:dc.b	$FD, $73, $74, $75, $FF, $FF, $FF
		dc.b	0
SonAni_StandMini:dc.b	$3F, $6F, $FF
		dc.b	0
SonAni_LookBack:dc.b	$3F, 6, $FF
		dc.b	0
SonAni_Sneeze:	dc.b	3, 7, 7, 7, 7, 7, 9, 9, 8, 8, 8, 1, $A, $A, $FD, 5
SonAni_GiveUp:	dc.b	4, $11, $12, $12, $13, $13, $12, $12, $13, $13, $12, $12, $13, $13, $11, $11
		dc.b	$11, $11, $14, $14, $14, $14, $15, $15, $16, $16, $16, $16, $16, $16, $17, $17
		dc.b	$17, $17, $17, $17, $A4, $A5, $FE, 2
SonAni_Hang2:	dc.b	$FC, $18, $19, $A6, $19, $FF
SonAni_Balance3D:dc.b	$FC, $1A, $1B, $1C, $1F, $1D, $1E, $FF
SonAni_Wade:	dc.b	$FF, $D, $E, $F, $10, $B, $C, $FF
SonAni_Float2:	dc.b	$FF, $61, $62, $63, $FF
		dc.b	0
SonAni_Unk30:	dc.b	$13, $70, $6F, $70, $79, $FE, 1
		dc.b	0
SonAni_Peelout:	dc.b	$FF, $94, $95, $96, $97, $FF, $FF, $FF
SonAni_Balance2:dc.b	$F, $85, $86, $87, $88, $FF
SonAni_RotateBack:dc.b	3, 1, $B5, $B5, $B6, $B6, $B7, $B7, $BB, $FD, 5
		dc.b	0
SonAni_RotateFront:dc.b	3, 1, $B5, $B5, 1, 1, $B8, $B8, $BB, $FD, 5
		dc.b	0
SonAni_Run3D:	dc.b	$FF, $A6, $A7, $A8, $A9, $FF, $FF, $FF
SonAni_Roll3D:	dc.b	$FE, $20, $21, $23, $24, $25, $31, $FF
SonAni_FallAway:dc.b	1, $A4, $A5, $FF
SonAni_Grow:	dc.b	1, $79, $AB, $AC, $AB, $AC, $AB, $AC, $A9, $AA, $A9, $AA, $A9, $AA, $A7, $A8, $A7, $A8, $A7, $A8, $FD, $1A
SonAni_Shrink:	dc.b	1, $5D, $A7, $A8, $A7, $A8, $A7, $A8, $A9, $AA, $A9, $AA, $A9, $AA, $AB, $AC, $AB, $AC, $AB, $AC, $FD, $1A

id_Walk:	equ (ptr_Walk-Ani_Sonic)/2	; 0
id_Run:		equ (ptr_Run-Ani_Sonic)/2	; 1
id_Roll:	equ (ptr_Roll-Ani_Sonic)/2	; 2
id_Roll2:	equ (ptr_Roll2-Ani_Sonic)/2	; 3
id_Push:	equ (ptr_Push-Ani_Sonic)/2	; 4
id_Wait:	equ (ptr_Wait-Ani_Sonic)/2	; 5
id_Balance:	equ (ptr_Balance-Ani_Sonic)/2	; 6
id_LookUp:	equ (ptr_LookUp-Ani_Sonic)/2	; 7
id_Duck:	equ (ptr_Duck-Ani_Sonic)/2	; 8
id_Warp1:	equ (ptr_Warp1-Ani_Sonic)/2	; 9
id_Warp2:	equ (ptr_Warp2-Ani_Sonic)/2	; $A
id_Warp3:	equ (ptr_Warp3-Ani_Sonic)/2	; $B
id_Warp4:	equ (ptr_Warp4-Ani_Sonic)/2	; $C
id_Stop:	equ (ptr_Stop-Ani_Sonic)/2	; $D
id_Float1:	equ (ptr_Float1-Ani_Sonic)/2	; $E
id_Float2:	equ (ptr_Float2-Ani_Sonic)/2	; $F
id_Spring:	equ (ptr_Spring-Ani_Sonic)/2	; $10
id_Hang:	equ (ptr_Hang-Ani_Sonic)/2	; $11
id_Leap1:	equ (ptr_Leap1-Ani_Sonic)/2	; $12
id_Leap2:	equ (ptr_Leap2-Ani_Sonic)/2	; $13
id_Surf:	equ (ptr_Surf-Ani_Sonic)/2	; $14
id_GetAir:	equ (ptr_GetAir-Ani_Sonic)/2	; $15
id_Burnt:	equ (ptr_Burnt-Ani_Sonic)/2	; $16
id_Drown:	equ (ptr_Drown-Ani_Sonic)/2	; $17
id_Death:	equ (ptr_Death-Ani_Sonic)/2	; $18
id_Shrink:	equ (ptr_Shrink-Ani_Sonic)/2	; $19
id_Hurt:	equ (ptr_Hurt-Ani_Sonic)/2	; $1A
id_WaterSlide:	equ (ptr_WaterSlide-Ani_Sonic)/2 ; $1B
id_Null:	equ (ptr_Null-Ani_Sonic)/2	; $1C
id_Float3:	equ (ptr_Float3-Ani_Sonic)/2	; $1D
id_Float4:	equ (ptr_Float4-Ani_Sonic)/2	; $1E