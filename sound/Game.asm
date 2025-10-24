; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus8F_Game_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus8F_Game_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus8F_Game_Voices-Mus8F_Game_Header				; Voice list address
		dc.b	(Game_DACFM_End-Game_DACFM)/4		; Number of DAC & FM channels
		dc.b	(Game_PSG_End-Game_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


Game_DACFM:
		dc.w	Mus8F_Game_NO_DAC-Mus8F_Game_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8F_Game_DAC-Mus8F_Game_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8F_Game_FM1-Mus8F_Game_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus8F_Game_FM2-Mus8F_Game_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus8F_Game_FM3-Mus8F_Game_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus8F_Game_FM4-Mus8F_Game_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus8F_Game_FM5-Mus8F_Game_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
Game_DACFM_End:

	; --- PSG channels ---

Game_PSG:
       Halt
Game_PSG_End:
Mus8F_Game_NO_DAC: 
        dc.b    $F5,$21            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus8F_Game_NO_DAC
	   smpsSetvoice	$1C

Game_Scratch1:	

; FM1 Data
Mus8F_Game_FM1:
            Halt

; FM2 Data
Mus8F_Game_FM2:
            Halt

; FM3 Data
Mus8F_Game_FM3:
            Halt

; FM4 Data
Mus8F_Game_FM4:
            Halt

; FM5 Data
Mus8F_Game_FM5:
            Halt

; PSG1 Data
Mus8F_Game_PSG1:
            Halt

; PSG2 Data
Mus8F_Game_PSG2:
            Halt

; PSG3 Data
Mus8F_Game_PSG3:
            Halt

; DAC Data
Mus8F_Game_DAC:
			Halt
            

Mus8F_Game_Voices:
            Halt
