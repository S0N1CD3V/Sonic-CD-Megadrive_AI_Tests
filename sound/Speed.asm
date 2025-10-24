; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus8E_Speed_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus8E_Speed_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus8E_Speed_Voices-Mus8E_Speed_Header				; Voice list address
		dc.b	(Speed_DACFM_End-Speed_DACFM)/4		; Number of DAC & FM channels
		dc.b	(Speed_PSG_End-Speed_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


Speed_DACFM:
		dc.w	Mus8E_Speed_NO_DAC-Mus8E_Speed_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8E_Speed_DAC-Mus8E_Speed_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus8E_Speed_FM1-Mus8E_Speed_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus8E_Speed_FM2-Mus8E_Speed_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus8E_Speed_FM3-Mus8E_Speed_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus8E_Speed_FM4-Mus8E_Speed_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus8E_Speed_FM5-Mus8E_Speed_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
Speed_DACFM_End:

	; --- PSG channels ---

Speed_PSG:
       Halt
Speed_PSG_End:
Mus8E_Speed_NO_DAC: 
        dc.b    $F5,$23            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus8E_Speed_NO_DAC
	   smpsSetvoice	$1C

Speed_Scratch1:	

; FM1 Data
Mus8E_Speed_FM1:
            Halt

; FM2 Data
Mus8E_Speed_FM2:
            Halt

; FM3 Data
Mus8E_Speed_FM3:
            Halt

; FM4 Data
Mus8E_Speed_FM4:
            Halt

; FM5 Data
Mus8E_Speed_FM5:
            Halt

; PSG1 Data
Mus8E_Speed_PSG1:
            Halt

; PSG2 Data
Mus8E_Speed_PSG2:
            Halt

; PSG3 Data
Mus8E_Speed_PSG3:
            Halt

; DAC Data
Mus8E_Speed_DAC:
			Halt
            

Mus8E_Speed_Voices:
            Halt
