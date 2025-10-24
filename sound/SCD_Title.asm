; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus81_SCD_Title_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus81_SCD_Title_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus81_SCD_Title_Voices-Mus81_SCD_Title_Header				; Voice list address
		dc.b	(SCD_Title_DACFM_End-SCD_Title_DACFM)/4		; Number of DAC & FM channels
		dc.b	(SCD_Title_PSG_End-SCD_Title_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


SCD_Title_DACFM:
		dc.w	Mus81_SCD_Title_NO_DAC-Mus81_SCD_Title_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus81_SCD_Title_DAC-Mus81_SCD_Title_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus81_SCD_Title_FM1-Mus81_SCD_Title_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus81_SCD_Title_FM2-Mus81_SCD_Title_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus81_SCD_Title_FM3-Mus81_SCD_Title_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus81_SCD_Title_FM4-Mus81_SCD_Title_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus81_SCD_Title_FM5-Mus81_SCD_Title_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
SCD_Title_DACFM_End:

	; --- PSG channels ---

SCD_Title_PSG:
       Halt
SCD_Title_PSG_End:
Mus81_SCD_Title_NO_DAC: 
        dc.b    $F5,$1E            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus81_SCD_Title_NO_DAC
	   smpsSetvoice	$1E

SCD_Title_Scratch1:	

; FM1 Data
Mus81_SCD_Title_FM1:
            Halt

; FM2 Data
Mus81_SCD_Title_FM2:
            Halt

; FM3 Data
Mus81_SCD_Title_FM3:
            Halt

; FM4 Data
Mus81_SCD_Title_FM4:
            Halt

; FM5 Data
Mus81_SCD_Title_FM5:
            Halt

; PSG1 Data
Mus81_SCD_Title_PSG1:
            Halt

; PSG2 Data
Mus81_SCD_Title_PSG2:
            Halt

; PSG3 Data
Mus81_SCD_Title_PSG3:
            Halt

; DAC Data
Mus81_SCD_Title_DAC:
			Halt
            

Mus81_SCD_Title_Voices:
            Halt
