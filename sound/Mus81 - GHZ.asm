; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------
Mus81_GHZ_Header:

	smpsHeaderStartSong 1
;	smpsHeaderVoice     Mus81_GHZ_Voices
;	smpsHeaderChan      $06, $03
;	smpsHeaderTempo     $01, $03
		dc.w	Mus81_GHZ_Voices-Mus81_GHZ_Header				; Voice list address
		dc.b	(GHZ_DACFM_End-GHZ_DACFM)/4		; Number of DAC & FM channels
		dc.b	(GHZ_PSG_End-GHZ_PSG)/6			; Number of PSG channels
		dc.b	$01, $04				; tempo (Multiply, Frame)


GHZ_DACFM:
		dc.w	Mus81_GHZ_NO_DAC-Mus81_GHZ_Header				; 	PCM 1 tracker address
		dc.b	$00, $EF				; '' (Pitch, Volume)
		dc.w	Mus81_GHZ_NO_DAC-Mus81_GHZ_Header				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	Mus81_GHZ_NO_DAC-Mus81_GHZ_Header				; FM 1 tracker address
		dc.b	$F4, $12				; '' (Pitch, Volume)
		dc.w	Mus81_GHZ_FM2-Mus81_GHZ_Header				; FM 2 tracker address
		dc.b	$00, $0B				; '' (Pitch, Volume)
		dc.w	Mus81_GHZ_FM3-Mus81_GHZ_Header				; FM 3 tracker address
		dc.b	$F4, $14				; '' (Pitch, Volume)
		dc.w	Mus81_GHZ_FM4-Mus81_GHZ_Header				; FM 4 tracker address
		dc.b	$F4, $08				; '' (Pitch, Volume)
		dc.w	Mus81_GHZ_FM5-Mus81_GHZ_Header				; FM 5 tracker address
		dc.b	$F4, $20				; '' (Pitch, Volume)
GHZ_DACFM_End:

	; --- PSG channels ---

GHZ_PSG:
		dc.w	Mus81_GHZ_PSG1-Mus81_GHZ_Header				; PSG 1 tracker address
		dc.b	$D0, $01				; '' (Pitch, Volume)
		dc.w	fTone_03					; '' (Starting tone)
		dc.w	Mus81_GHZ_PSG2-Mus81_GHZ_Header				; PSG 2 tracker address
		dc.b	$D0, $03				; '' (Pitch, Volume)
		dc.w	fTone_06					; '' (Starting tone)
		dc.w	Mus81_GHZ_PSG3-Mus81_GHZ_Header				; PSG 3 tracker address
		dc.b	$03, $00				; '' (Pitch, Volume)
		dc.w	fTone_04					; '' (Starting tone)
GHZ_PSG_End:
Mus81_GHZ_NO_DAC: 
    smpsSetvoice	$21

PalmtreePanicPast_Loop1:
	dc.b	nD4, $12, nA4, nA3, nD4, nA4, $0C, nA3
	dc.b	nD4, $12, nA4, nA3, nD4, nA4, $0C, nA3
	dc.b	nC4, $12, nG4, nG3, nC4, nG4, $0C, nG3
	dc.b	nC4, $12, nG4, nG3, nC4, nG4, $0C, nG3
	smpsLoop	$00, $04, PalmtreePanicPast_Loop1
	dc.b	nF4, $18, nC4, nF4, $12, $06, nC4, $0C
	dc.b	nF4, nE4, $18, nB3, nE4, $12, nB3, $06
	dc.b	nE4, $0C, nEb4, nD4, $18, nA3, nD4, $12
	dc.b	nA3, $06, nD4, $0C, nEb4, nE4, $18, nB3
	dc.b	nE4, $12, nB3, $06, nE4, $18, nF4, nC4
	dc.b	nF4, nC4, $0C, nF4, nE4, $18, nB3, nE4
	dc.b	$12, nB3, $06, nE4, $0C, nEb4, nD4, $18
	dc.b	nA3, nD4, nA3, nD4, nA3, nD4, $12, $06
	dc.b	nA3, $0C, nAb3, nG3, $18, nD4, nG4, nD4
	dc.b	$0C, nG3, nG3, $12, $12, nD4, $0C, nG4
	dc.b	$12, nD4, nG3, $0C

PalmtreePanicPast_Loop2:
	dc.b	nC4, $12, nG4, $06, $0C, nG3, nC4, $12
	dc.b	nG4, $06, $06, nG3, nA3, nG3, nE4, $12
	dc.b	nB3, $06, $18, nE4, $12, nB3, $06, $0C
	dc.b	nEb4, nD4, $12, nA4, $06, $0C, nA3, nD4
	dc.b	$12, nA4, $06, $06, nA3, nD4, nA3, nG3
	dc.b	$12, $06, nD4, $12, $06, nG3, $12, nD4
	dc.b	$06, nG4, $0C, nD4, nE4, $12, nB3, $06
	dc.b	$0C, nE3, nE4, $12, nB3, $06, $0C, nBb3
	dc.b	nA3, $12, $06, nE4, $12, $06, nA3, $12
	dc.b	nE4, $06, nG4, nBb4, nCs5, nE5, nD4, $12
	dc.b	$06, nA3, $18, nD4, $12, $06, nA3, $0C
	dc.b	nAb3, nG3, $12, $06, nD4, $12, $06, nF4
	dc.b	nG4, nRst, nF4, nD4, nG3, nD4, nG3
	smpsLoop	$00, $02, PalmtreePanicPast_Loop2
	smpsJump	PalmtreePanicPast_Loop1
	

; FM1 Data
Mus81_GHZ_FM1:
            Halt

; FM2 Data
Mus81_GHZ_FM2:
            Halt

; FM3 Data
Mus81_GHZ_FM3:
            Halt

; FM4 Data
Mus81_GHZ_FM4:
            Halt

; FM5 Data
Mus81_GHZ_FM5:
            Halt

; PSG1 Data
Mus81_GHZ_PSG1:
            Halt

; PSG2 Data
Mus81_GHZ_PSG2:
            Halt

; PSG3 Data
Mus81_GHZ_PSG3:
            Halt

; DAC Data
Mus81_GHZ_DAC:
            
    Halt
	
Mus81_GHZ_Voices:
            Halt
