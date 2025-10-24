; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus8A_SCD_Future_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus8A_SCD_Future_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus8A_SCD_Future_Voices-Mus8A_SCD_Future_Header				; Voice list address
		dc.b	(SCD_Future_DACFM_End-SCD_Future_DACFM)/4		; Number of DAC & FM channels
		dc.b	(SCD_Future_PSG_End-SCD_Future_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


SCD_Future_DACFM:
		dc.w	Mus8A_SCD_Future_NO_DAC-Mus8A_SCD_Future_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8A_SCD_Future_DAC-Mus8A_SCD_Future_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8A_SCD_Future_FM1-Mus8A_SCD_Future_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus8A_SCD_Future_FM2-Mus8A_SCD_Future_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus8A_SCD_Future_FM3-Mus8A_SCD_Future_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus8A_SCD_Future_FM4-Mus8A_SCD_Future_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus8A_SCD_Future_FM5-Mus8A_SCD_Future_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
SCD_Future_DACFM_End:

	; --- PSG channels ---

SCD_Future_PSG:
       Halt
SCD_Future_PSG_End:
Mus8A_SCD_Future_NO_DAC: 
        dc.b    $F5,$25            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus8A_SCD_Future_NO_DAC
	   smpsSetvoice	$1C

SCD_Future_Scratch1:	

; FM1 Data
Mus8A_SCD_Future_FM1:
            Halt

; FM2 Data
Mus8A_SCD_Future_FM2:
            Halt

; FM3 Data
Mus8A_SCD_Future_FM3:
            Halt

; FM4 Data
Mus8A_SCD_Future_FM4:
            Halt

; FM5 Data
Mus8A_SCD_Future_FM5:
            Halt

; PSG1 Data
Mus8A_SCD_Future_PSG1:
            Halt

; PSG2 Data
Mus8A_SCD_Future_PSG2:
            Halt

; PSG3 Data
Mus8A_SCD_Future_PSG3:
            Halt

; DAC Data
Mus8A_SCD_Future_DAC:
			Halt
            

Mus8A_SCD_Future_Voices:
            Halt
