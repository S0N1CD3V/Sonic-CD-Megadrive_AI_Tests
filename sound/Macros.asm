; ===========================================================================
; ---------------------------------------------------------------------------
; Sound Driver Macros
; ---------------------------------------------------------------------------

	; --- Equates for the macros ---

NoSpeakers	=	%00000000
RightSpeaker	=	%01000000
LeftSpeaker	=	%10000000
BothSpeakers	=	LeftSpeaker|RightSpeaker

	;	dc.w	  C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B

REST		=	$80
N_S1Kick	=	$81
N_S1Snare	=	$82
N_S1Timpani	=	$83
N_S1TimpHigh	=	$88
N_S1TimpMid	=	$89
N_S1TimpLow	=	$8A
N_S1TimpLowest	=	$8B

C		=	$01
Cs		=	$02
D		=	$03
Eb		=	$04
E		=	$05
F		=	$06
Fs		=	$07
G		=	$08
Gs		=	$09
A		=	$0A
Bb		=	$0B
B		=	$0C

N_C0		=	$80+(0*$C)+C		; 81
N_Cs0		=	$80+(0*$C)+Cs		; 82
N_D0		=	$80+(0*$C)+D		; 83
N_Eb0		=	$80+(0*$C)+Eb		; 84
N_E0		=	$80+(0*$C)+E		; 85
N_F0		=	$80+(0*$C)+F		; 86
N_Fs0		=	$80+(0*$C)+Fs		; 87
N_G0		=	$80+(0*$C)+G		; 88
N_Gs0		=	$80+(0*$C)+Gs		; 89
N_A0		=	$80+(0*$C)+A		; 8A
N_Bb0		=	$80+(0*$C)+Bb		; 8B
N_B0		=	$80+(0*$C)+B		; 8C

N_C1		=	$80+(1*$C)+C		; 8D
N_Cs1		=	$80+(1*$C)+Cs		; 8E
N_D1		=	$80+(1*$C)+D		; 8F
N_Eb1		=	$80+(1*$C)+Eb		; 90
N_E1		=	$80+(1*$C)+E		; 91
N_F1		=	$80+(1*$C)+F		; 92
N_Fs1		=	$80+(1*$C)+Fs		; 93
N_G1		=	$80+(1*$C)+G		; 94
N_Gs1		=	$80+(1*$C)+Gs		; 95
N_A1		=	$80+(1*$C)+A		; 96
N_Bb1		=	$80+(1*$C)+Bb		; 97
N_B1		=	$80+(1*$C)+B		; 98

N_C2		=	$80+(2*$C)+C		; 99
N_Cs2		=	$80+(2*$C)+Cs		; 9A
N_D2		=	$80+(2*$C)+D		; 9B
N_Eb2		=	$80+(2*$C)+Eb		; 9C
N_E2		=	$80+(2*$C)+E		; 9D
N_F2		=	$80+(2*$C)+F		; 9E
N_Fs2		=	$80+(2*$C)+Fs		; 9F
N_G2		=	$80+(2*$C)+G		; A0
N_Gs2		=	$80+(2*$C)+Gs		; A1
N_A2		=	$80+(2*$C)+A		; A2
N_Bb2		=	$80+(2*$C)+Bb		; A3
N_B2		=	$80+(2*$C)+B		; A4

N_C3		=	$80+(3*$C)+C		; A5
N_Cs3		=	$80+(3*$C)+Cs		; A6
N_D3		=	$80+(3*$C)+D		; A7
N_Eb3		=	$80+(3*$C)+Eb		; A8
N_E3		=	$80+(3*$C)+E		; A9
N_F3		=	$80+(3*$C)+F		; AA
N_Fs3		=	$80+(3*$C)+Fs		; AB
N_G3		=	$80+(3*$C)+G		; AC
N_Gs3		=	$80+(3*$C)+Gs		; AD
N_A3		=	$80+(3*$C)+A		; AE
N_Bb3		=	$80+(3*$C)+Bb		; AF
N_B3		=	$80+(3*$C)+B		; B0

N_C4		=	$80+(4*$C)+C		; B1
N_Cs4		=	$80+(4*$C)+Cs		; B2
N_D4		=	$80+(4*$C)+D		; B3
N_Eb4		=	$80+(4*$C)+Eb		; B4
N_E4		=	$80+(4*$C)+E		; B5
N_F4		=	$80+(4*$C)+F		; B6
N_Fs4		=	$80+(4*$C)+Fs		; B7
N_G4		=	$80+(4*$C)+G		; B8
N_Gs4		=	$80+(4*$C)+Gs		; B9
N_A4		=	$80+(4*$C)+A		; BA
N_Bb4		=	$80+(4*$C)+Bb		; BB
N_B4		=	$80+(4*$C)+B		; BC

N_C5		=	$80+(5*$C)+C		; BD
N_Cs5		=	$80+(5*$C)+Cs		; BE
N_D5		=	$80+(5*$C)+D		; BF
N_Eb5		=	$80+(5*$C)+Eb		; C0
N_E5		=	$80+(5*$C)+E		; C1
N_F5		=	$80+(5*$C)+F		; C2
N_Fs5		=	$80+(5*$C)+Fs		; C3
N_G5		=	$80+(5*$C)+G		; C4
N_Gs5		=	$80+(5*$C)+Gs		; C5
N_A5		=	$80+(5*$C)+A		; C6
N_Bb5		=	$80+(5*$C)+Bb		; C7
N_B5		=	$80+(5*$C)+B		; C8

N_C6		=	$80+(6*$C)+C		; C9
N_Cs6		=	$80+(6*$C)+Cs		; CA
N_D6		=	$80+(6*$C)+D		; CB
N_Eb6		=	$80+(6*$C)+Eb		; CC
N_E6		=	$80+(6*$C)+E		; CD
N_F6		=	$80+(6*$C)+F		; CE
N_Fs6		=	$80+(6*$C)+Fs		; CF
N_G6		=	$80+(6*$C)+G		; D0
N_Gs6		=	$80+(6*$C)+Gs		; D1
N_A6		=	$80+(6*$C)+A		; D2
N_Bb6		=	$80+(6*$C)+Bb		; D3
N_B6		=	$80+(6*$C)+B		; D4

N_C7		=	$80+(7*$C)+C		; D5
N_Cs7		=	$80+(7*$C)+Cs		; D6
N_D7		=	$80+(7*$C)+D		; D7
N_Eb7		=	$80+(7*$C)+Eb		; D8
N_E7		=	$80+(7*$C)+E		; D9
N_F7		=	$80+(7*$C)+F		; DA
N_Fs7		=	$80+(7*$C)+Fs		; DB
N_G7		=	$80+(7*$C)+G		; DC
N_Gs7		=	$80+(7*$C)+Gs		; DD
N_A7		=	$80+(7*$C)+A		; DE
N_Bb7		=	$80+(7*$C)+Bb		; DF
N_B7		=	$80+(7*$C)+B		; E0

; ---------------------------------------------------------------------------
; The actual macros
; ---------------------------------------------------------------------------

	; --- Flag E0 - Set panning ---

Pan		macro	PanValue
		dc.b	$E0,PanValue
		endm

	; --- Flag E1 - Set detune ---

Detune		macro	DetuneValue
		dc.b	$E1,DetuneValue
		endm

	; --- Flag E2 - Set unknown (unused in Sonic 1) ---

UnkFlag		macro	UnkValue
		dc.b	$E2,UnkValue
		endm

	; --- Flag E3 - Return ---

Return		macro
		dc.b	$E3
		endm

	; --- Flag E4 - Fade in (from 1-Up jingle) ---

FadeIn		macro
		dc.b	$E4
		endm

	; --- Flag E5 - Set tempo multiplier (for current channel only) ---

TempMul		macro	TempoMultValue
		dc.b	$E5,TempoMultValue
		endm

	; --- Flag E6 - Add volume (FM only) ---

VolumFM		macro	VolumeValue
		dc.b	$E6,VolumeValue
		endm

	; --- Flag E7 - Set soft key on (one turn only) ---

SoftKey		macro
		dc.b	$E7
		endm

	; --- Flag E8 - Set release key rate counter ---

KeyRate		macro	ReleaseValue
		dc.b	$E8,ReleaseValue
		endm

	; --- Flag E9 - Add pitch ---

Pitch		macro	PitchValue
		dc.b	$E9,PitchValue
		endm

	; --- Flag EA - Set tempo (for all channels) ---

TempSet		macro	TempoSetValue
		dc.b	$EA,TempoSetValue
		endm

	; --- Flag EB - Set tempo multiplier (for all channels) ---

TempAll		macro	TempoAllValue
		dc.b	$EB,TempoAllValue
		endm

	; --- Flag EC - Add volume (PSG only, though it can be used for FM with no update) ---

VoluPSG		macro	VolumeValue
		dc.b	$EC,VolumeValue
		endm

	; --- Flag ED - Clearing "Block Push SFX" wait flag ---

ClrBlck		macro
		dc.b	$ED
		endm

	; --- Flag EE - Stop Special SFX FM 4 channel from running ---

StopFM4		macro
		dc.b	$EE
		endm

	; --- Flag EF - FM Voice Select ---

VoiceFM		macro	VoiceID
		dc.b	$EF,VoiceID
		endm

	; --- Flag F0 - Set modulation (frequency LFO) and turn it on ---

Modulat		macro	Delay, Speed, Rate, Steps
		dc.b	$F0,Delay,Speed,Rate,Steps
		endm

	; --- Flag F1 - Turn modulation (frequency LFO) on ---

ModulOn		macro
		dc.b	$F1
		endm

	; --- Flag F2 - Halt channel ---

Halt		macro
		dc.b	$F2
		endm

	; --- Flag F3 - PSG 4 Control ---

SetPSG4		macro	PSG4Value
		dc.b	$F3,PSG4Value
		endm

	; --- Flag F4 - Turn modulation (frequency LFO) off ---

ModuOff		macro
		dc.b	$F4
		endm

	; --- Flag F5 - PSG Voice Select (FM can used this, but without updating the YM2612) ---

VoicPSG		macro	VoiceID
		dc.b	$F5,VoiceID
		endm

	; --- Flag F6 - Jump ---

Jump		macro	Location
		dc.b	$F6
		dc.b	(((Location-*)-$01)>>$08)&$FF
		dc.b	(Location-*)&$FF
		endm

	; --- Flag F7 - Loop ---

Loop		macro	Slot, Count, Location
		dc.b	$F7,Slot,Count
		dc.b	(((Location-*)-$01)>>$08)&$FF
		dc.b	(Location-*)&$FF
		endm

	; --- Flag F8 - Call ---

Call		macro	Location
		dc.b	$F8
		dc.b	(((Location-*)-$01)>>$08)&$FF
		dc.b	(Location-*)&$FF
		endm

	; --- Flag F9 - Force FM channel 1's operator 3 & 4 release rate to immediate (Used at the end of SYZ's first verse) ---

ForceRR		macro
		dc.b	$F9
		endm

	; --- Flag FA - Reverse PCM ---

Reverse		macro
		dc.b	$FA
		endm

; ===========================================================================