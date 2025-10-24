; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus85_PPZ_GF_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus85_PPZ_GF_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus85_PPZ_GF_Voices-Mus85_PPZ_GF_Header				; Voice list address
		dc.b	(PPZ_GF_DACFM_End-PPZ_GF_DACFM)/4		; Number of DAC & FM channels
		dc.b	(PPZ_GF_PSG_End-PPZ_GF_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


PPZ_GF_DACFM:
		dc.w	Mus85_PPZ_GF_NO_DAC-Mus85_PPZ_GF_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus85_PPZ_GF_DAC-Mus85_PPZ_GF_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus85_PPZ_GF_FM1-Mus85_PPZ_GF_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus85_PPZ_GF_FM2-Mus85_PPZ_GF_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus85_PPZ_GF_FM3-Mus85_PPZ_GF_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus85_PPZ_GF_FM4-Mus85_PPZ_GF_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus85_PPZ_GF_FM5-Mus85_PPZ_GF_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
PPZ_GF_DACFM_End:

	; --- PSG channels ---

PPZ_GF_PSG:
       Halt
PPZ_GF_PSG_End:

Mus85_PPZ_GF_NO_DAC: 
        dc.b    $F5,$28            ;  play
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus85_PPZ_GF_NO_DAC

PPZ_GF_Scratch1:	

; FM1 Data
Mus85_PPZ_GF_FM1:
            Halt

; FM2 Data
Mus85_PPZ_GF_FM2:
            Halt

; FM3 Data
Mus85_PPZ_GF_FM3:
            Halt

; FM4 Data
Mus85_PPZ_GF_FM4:
            Halt

; FM5 Data
Mus85_PPZ_GF_FM5:
            Halt

; PSG1 Data
Mus85_PPZ_GF_PSG1:
            Halt

; PSG2 Data
Mus85_PPZ_GF_PSG2:
            Halt

; PSG3 Data
Mus85_PPZ_GF_PSG3:
            Halt

; DAC Data
Mus85_PPZ_GF_DAC:
            

Mus85_PPZ_GF_Voices:
            Halt
