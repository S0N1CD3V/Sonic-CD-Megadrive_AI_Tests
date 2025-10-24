; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus8E_EoA_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus8E_EoA_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus8E_EoA_Voices-Mus8E_EoA_Header				; Voice list address
		dc.b	(EoA_DACFM_End-EoA_DACFM)/4		; Number of DAC & FM channels
		dc.b	(EoA_PSG_End-EoA_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


EoA_DACFM:
		dc.w	Mus8E_EoA_NO_DAC-Mus8E_EoA_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8E_EoA_DAC-Mus8E_EoA_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8E_EoA_FM1-Mus8E_EoA_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus8E_EoA_FM2-Mus8E_EoA_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus8E_EoA_FM3-Mus8E_EoA_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus8E_EoA_FM4-Mus8E_EoA_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus8E_EoA_FM5-Mus8E_EoA_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
EoA_DACFM_End:

	; --- PSG channels ---

EoA_PSG:
       Halt
EoA_PSG_End:
Mus8E_EoA_NO_DAC: 
        dc.b    $F5,$20            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus8E_EoA_NO_DAC
	   smpsSetvoice	$1C

EoA_Scratch1:	

; FM1 Data
Mus8E_EoA_FM1:
            Halt

; FM2 Data
Mus8E_EoA_FM2:
            Halt

; FM3 Data
Mus8E_EoA_FM3:
            Halt

; FM4 Data
Mus8E_EoA_FM4:
            Halt

; FM5 Data
Mus8E_EoA_FM5:
            Halt

; PSG1 Data
Mus8E_EoA_PSG1:
            Halt

; PSG2 Data
Mus8E_EoA_PSG2:
            Halt

; PSG3 Data
Mus8E_EoA_PSG3:
            Halt

; DAC Data
Mus8E_EoA_DAC:
			Halt
            

Mus8E_EoA_Voices:
            Halt
