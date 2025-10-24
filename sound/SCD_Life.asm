; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus88_SCD_Life_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus88_SCD_Life_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus88_SCD_Life_Voices-Mus88_SCD_Life_Header				; Voice list address
		dc.b	(SCD_Life_DACFM_End-SCD_Life_DACFM)/4		; Number of DAC & FM channels
		dc.b	(SCD_Life_PSG_End-SCD_Life_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


SCD_Life_DACFM:
		dc.w	Mus88_SCD_Life_NO_DAC-Mus88_SCD_Life_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus88_SCD_Life_DAC-Mus88_SCD_Life_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus88_SCD_Life_FM1-Mus88_SCD_Life_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus88_SCD_Life_FM2-Mus88_SCD_Life_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus88_SCD_Life_FM3-Mus88_SCD_Life_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus88_SCD_Life_FM4-Mus88_SCD_Life_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus88_SCD_Life_FM5-Mus88_SCD_Life_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
SCD_Life_DACFM_End:

	; --- PSG channels ---

SCD_Life_PSG:
       Halt
SCD_Life_PSG_End:
Mus88_SCD_Life_NO_DAC: 
        dc.b    $F5,$44            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus88_SCD_Life_NO_DAC

; FM1 Data
Mus88_SCD_Life_FM1:
            Halt

; FM2 Data
Mus88_SCD_Life_FM2:
            Halt

; FM3 Data
Mus88_SCD_Life_FM3:
            Halt

; FM4 Data
Mus88_SCD_Life_FM4:
            Halt

; FM5 Data
Mus88_SCD_Life_FM5:
            Halt

; PSG1 Data
Mus88_SCD_Life_PSG1:
            Halt

; PSG2 Data
Mus88_SCD_Life_PSG2:
            Halt

; PSG3 Data
Mus88_SCD_Life_PSG3:
            Halt

; DAC Data
Mus88_SCD_Life_DAC:
			Halt
            

Mus88_SCD_Life_Voices:
            Halt
