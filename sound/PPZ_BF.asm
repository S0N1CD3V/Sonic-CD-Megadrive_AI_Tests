; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus86_PPZ_BF_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus86_PPZ_BF_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus86_PPZ_BF_Voices-Mus86_PPZ_BF_Header				; Voice list address
		dc.b	(PPZ_BF_DACFM_End-PPZ_BF_DACFM)/4		; Number of DAC & FM channels
		dc.b	(PPZ_BF_PSG_End-PPZ_BF_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


PPZ_BF_DACFM:
		dc.w	Mus86_PPZ_BF_NO_DAC-Mus86_PPZ_BF_Header				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus86_PPZ_BF_DAC-Mus86_PPZ_BF_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus86_PPZ_BF_FM1-Mus86_PPZ_BF_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus86_PPZ_BF_FM2-Mus86_PPZ_BF_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus86_PPZ_BF_FM3-Mus86_PPZ_BF_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus86_PPZ_BF_FM4-Mus86_PPZ_BF_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus86_PPZ_BF_FM5-Mus86_PPZ_BF_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
PPZ_BF_DACFM_End:

	; --- PSG channels ---

PPZ_BF_PSG:
       Halt
PPZ_BF_PSG_End:

Mus86_PPZ_BF_NO_DAC: 
        dc.b    $F5,$29            ;  play
        dc.b    $B1,$E7            ; play kick for 8 ticks
       smpsJump    Mus86_PPZ_BF_NO_DAC

PPZ_BF_Scratch1:	

; FM1 Data
Mus86_PPZ_BF_FM1:
            Halt

; FM2 Data
Mus86_PPZ_BF_FM2:
            Halt

; FM3 Data
Mus86_PPZ_BF_FM3:
            Halt

; FM4 Data
Mus86_PPZ_BF_FM4:
            Halt

; FM5 Data
Mus86_PPZ_BF_FM5:
            Halt

; PSG1 Data
Mus86_PPZ_BF_PSG1:
            Halt

; PSG2 Data
Mus86_PPZ_BF_PSG2:
            Halt

; PSG3 Data
Mus86_PPZ_BF_PSG3:
            Halt

; DAC Data
Mus86_PPZ_BF_DAC:
            

Mus86_PPZ_BF_Voices:
            Halt
