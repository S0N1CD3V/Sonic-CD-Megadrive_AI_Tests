; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus87_Inv_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus87_Inv_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus87_Inv_Voices-Mus87_Inv_Header				; Voice list address
		dc.b	(Inv_DACFM_End-Inv_DACFM)/4		; Number of DAC & FM channels
		dc.b	(Inv_PSG_End-Inv_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


Inv_DACFM:
		dc.w	Mus87_Inv_NO_DAC-Mus87_Inv_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus87_Inv_DAC-Mus87_Inv_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus87_Inv_FM1-Mus87_Inv_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus87_Inv_FM2-Mus87_Inv_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus87_Inv_FM3-Mus87_Inv_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus87_Inv_FM4-Mus87_Inv_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus87_Inv_FM5-Mus87_Inv_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
Inv_DACFM_End:

	; --- PSG channels ---

Inv_PSG:
       Halt
Inv_PSG_End:
Mus87_Inv_NO_DAC: 
        dc.b    $F5,$22            ; kick instrument
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus87_Inv_NO_DAC
	   smpsSetvoice	$1C

Inv_Scratch1:	

; FM1 Data
Mus87_Inv_FM1:
            Halt

; FM2 Data
Mus87_Inv_FM2:
            Halt

; FM3 Data
Mus87_Inv_FM3:
            Halt

; FM4 Data
Mus87_Inv_FM4:
            Halt

; FM5 Data
Mus87_Inv_FM5:
            Halt

; PSG1 Data
Mus87_Inv_PSG1:
            Halt

; PSG2 Data
Mus87_Inv_PSG2:
            Halt

; PSG3 Data
Mus87_Inv_PSG3:
            Halt

; DAC Data
Mus87_Inv_DAC:
			Halt
            

Mus87_Inv_Voices:
            Halt
