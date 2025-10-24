; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus8C_SCD_Boss_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus8C_SCD_Boss_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus8C_SCD_Boss_Voices-Mus8C_SCD_Boss_Header				; Voice list address
		dc.b	(SCD_Boss_DACFM_End-SCD_Boss_DACFM)/4		; Number of DAC & FM channels
		dc.b	(SCD_Boss_PSG_End-SCD_Boss_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


SCD_Boss_DACFM:
		dc.w	Mus8C_SCD_Boss_NO_DAC-Mus8C_SCD_Boss_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8C_SCD_Boss_DAC-Mus8C_SCD_Boss_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8C_SCD_Boss_FM1-Mus8C_SCD_Boss_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus8C_SCD_Boss_FM2-Mus8C_SCD_Boss_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus8C_SCD_Boss_FM3-Mus8C_SCD_Boss_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus8C_SCD_Boss_FM4-Mus8C_SCD_Boss_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus8C_SCD_Boss_FM5-Mus8C_SCD_Boss_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
SCD_Boss_DACFM_End:

	; --- PSG channels ---

SCD_Boss_PSG:
       Halt
SCD_Boss_PSG_End:
Mus8C_SCD_Boss_NO_DAC: 
        dc.b    $F5,$2A            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus8C_SCD_Boss_NO_DAC
	   smpsSetvoice	$1C

SCD_Boss_Scratch1:	

; FM1 Data
Mus8C_SCD_Boss_FM1:
            Halt

; FM2 Data
Mus8C_SCD_Boss_FM2:
            Halt

; FM3 Data
Mus8C_SCD_Boss_FM3:
            Halt

; FM4 Data
Mus8C_SCD_Boss_FM4:
            Halt

; FM5 Data
Mus8C_SCD_Boss_FM5:
            Halt

; PSG1 Data
Mus8C_SCD_Boss_PSG1:
            Halt

; PSG2 Data
Mus8C_SCD_Boss_PSG2:
            Halt

; PSG3 Data
Mus8C_SCD_Boss_PSG3:
            Halt

; DAC Data
Mus8C_SCD_Boss_DAC:
			Halt
            

Mus8C_SCD_Boss_Voices:
            Halt
