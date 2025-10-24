; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus81_YDA_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus81_YDA_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus81_YDA_Voices-Mus81_YDA_Header				; Voice list address
		dc.b	(YDA_DACFM_End-YDA_DACFM)/4		; Number of DAC & FM channels
		dc.b	(YDA_PSG_End-YDA_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


YDA_DACFM:
		dc.w	Mus81_YDA_NO_DAC-Mus81_YDA_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus81_YDA_DAC-Mus81_YDA_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus81_YDA_FM1-Mus81_YDA_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus81_YDA_FM2-Mus81_YDA_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus81_YDA_FM3-Mus81_YDA_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus81_YDA_FM4-Mus81_YDA_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus81_YDA_FM5-Mus81_YDA_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
YDA_DACFM_End:

	; --- PSG channels ---

YDA_PSG:
       Halt
YDA_PSG_End:
Mus81_YDA_NO_DAC: 
        dc.b    $F5,$1E            ;  play
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus81_YDA_NO_DAC

YDA_Scratch1:	

; FM1 Data
Mus81_YDA_FM1:
            Halt

; FM2 Data
Mus81_YDA_FM2:
            Halt

; FM3 Data
Mus81_YDA_FM3:
            Halt

; FM4 Data
Mus81_YDA_FM4:
            Halt

; FM5 Data
Mus81_YDA_FM5:
            Halt

; PSG1 Data
Mus81_YDA_PSG1:
            Halt

; PSG2 Data
Mus81_YDA_PSG2:
            Halt

; PSG3 Data
Mus81_YDA_PSG3:
            Halt

; DAC Data
Mus81_YDA_DAC:
            

Mus81_YDA_Voices:
            Halt
