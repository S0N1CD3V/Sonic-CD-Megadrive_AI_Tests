; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus89_SCD_OuttaHere_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus89_SCD_OuttaHere_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus89_SCD_OuttaHere_Voices-Mus89_SCD_OuttaHere_Header				; Voice list address
		dc.b	(SCD_OuttaHere_DACFM_End-SCD_OuttaHere_DACFM)/4		; Number of DAC & FM channels
		dc.b	(SCD_OuttaHere_PSG_End-SCD_OuttaHere_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


SCD_OuttaHere_DACFM:
		dc.w	Mus89_SCD_OuttaHere_NO_DAC-Mus89_SCD_OuttaHere_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus89_SCD_OuttaHere_DAC-Mus89_SCD_OuttaHere_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus89_SCD_OuttaHere_FM1-Mus89_SCD_OuttaHere_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus89_SCD_OuttaHere_FM2-Mus89_SCD_OuttaHere_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus89_SCD_OuttaHere_FM3-Mus89_SCD_OuttaHere_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus89_SCD_OuttaHere_FM4-Mus89_SCD_OuttaHere_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus89_SCD_OuttaHere_FM5-Mus89_SCD_OuttaHere_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
SCD_OuttaHere_DACFM_End:

	; --- PSG channels ---

SCD_OuttaHere_PSG:
       Halt
SCD_OuttaHere_PSG_End:
Mus89_SCD_OuttaHere_NO_DAC: 
        dc.b    $F5,$27            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus89_SCD_OuttaHere_NO_DAC
	   smpsSetvoice	$1C

SCD_OuttaHere_Scratch1:	

; FM1 Data
Mus89_SCD_OuttaHere_FM1:
            Halt

; FM2 Data
Mus89_SCD_OuttaHere_FM2:
            Halt

; FM3 Data
Mus89_SCD_OuttaHere_FM3:
            Halt

; FM4 Data
Mus89_SCD_OuttaHere_FM4:
            Halt

; FM5 Data
Mus89_SCD_OuttaHere_FM5:
            Halt

; PSG1 Data
Mus89_SCD_OuttaHere_PSG1:
            Halt

; PSG2 Data
Mus89_SCD_OuttaHere_PSG2:
            Halt

; PSG3 Data
Mus89_SCD_OuttaHere_PSG3:
            Halt

; DAC Data
Mus89_SCD_OuttaHere_DAC:
			Halt
            

Mus89_SCD_OuttaHere_Voices:
            Halt
