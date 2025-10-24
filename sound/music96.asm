; ===========================================================================
; ---------------------------------------------------------------------------
; Music 96
; ---------------------------------------------------------------------------
		include	"sound\Macros.asm"
; ---------------------------------------------------------------------------

M96:		dc.w	M96_VoiceFM-M96				; Voice list address
		dc.b	(M96_DACFM_End-M96_DACFM)/4		; Number of DAC & FM channels
		dc.b	(M96_PSG_End-M96_PSG)/6			; Number of PSG channels
		dc.b	$01, $08				; tempo (Multiply, Frame)

	; --- PCM & FM channels ---

M96_DACFM:
		dc.w	M96_PCM1-M96				; PCM 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	M96_PCM2-M96				; PCM 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	M96_FM1-M96				; FM 1 tracker address
		dc.b	$00, $0A				; '' (Pitch, Volume)
		dc.w	M96_FM2-M96				; FM 2 tracker address
		dc.b	$00, $0C				; '' (Pitch, Volume)
		dc.w	M96_FM3-M96				; FM 3 tracker address
		dc.b	$00, $0C				; '' (Pitch, Volume)
		dc.w	M96_FM4-M96				; FM 4 tracker address
		dc.b	$00, $0C				; '' (Pitch, Volume)
		dc.w	M96_FM5-M96				; FM 5 tracker address
		dc.b	$00, $0A				; '' (Pitch, Volume)
M96_DACFM_End:

	; --- PSG channels ---

M96_PSG:
		dc.w	M96_PSG1-M96				; PSG 1 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	$0000					; '' (Starting tone)
		dc.w	M96_PSG2-M96				; PSG 2 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	$0000					; '' (Starting tone)
		dc.w	M96_PSG3-M96				; PSG 3 tracker address
		dc.b	$00, $00				; '' (Pitch, Volume)
		dc.w	$0000					; '' (Starting tone)
M96_PSG_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; FM Voices
; ---------------------------------------------------------------------------

M96_VoiceFM:
		dc.b	$3A
		dc.b	$61,$3C,$14,$30, $9C,$DB,$9C,$DA, $04,$09,$04,$03
		dc.b	$03,$01,$03,$00, $1F,$0F,$0F,$AF, $21,$47,$31,$80

		dc.b	$05
		dc.b	$74,$32,$36,$74, $10,$10,$10,$10, $04,$04,$04,$04
		dc.b	$0D,$04,$0D,$04, $75,$5F,$45,$5F, $40,$84,$20,$8E

		dc.b	$02
		dc.b	$71,$31,$71,$30, $8A,$8A,$8A,$1F, $00,$00,$00,$00
		dc.b	$00,$00,$00,$00, $FF,$FF,$FF,$0F, $1C,$20,$14,$80

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 1
; ---------------------------------------------------------------------------

M96_PSG2:
		VoluPSG	$02
		dc.b	$80,$08

M96_PSG3:
		Detune	$FF

M96_PSG1:
		dc.b	$80,$40
		Loop	$00,$2D,M96_PSG1

		VoicPSG	$04
		VoluPSG	$08
		Pitch	$FA

M96_PSG1_MegaLoop:
		Call	M96_PSG1_Loop01

		dc.b	$80,$50,$40

M96_PSG1_PauseLoop:
		dc.b	$60
		Loop	$00,$0A*4,M96_PSG1_PauseLoop
		dc.b	$40,$40,$40,$40

		Call	M96_PSG1_Loop01

M96_PSG1_PauseLoop2:
		dc.b	$80,$40
		Loop	$00,$20,M96_PSG1_PauseLoop2

		Jump	M96_PSG1_MegaLoop

; ---------------------------------------------------------------------------
; PSG twinkling sounds
; ---------------------------------------------------------------------------

M96_PSG1_Loop01:
		VoluPSG	$FF
		dc.b	$AA,$04,$AD,$B1,$B6
		dc.b	$B1,$AD,$AA,$A8
		Loop	$00,$04,M96_PSG1_Loop01

M96_PSG1_Loop02:
		VoluPSG	$01
		dc.b	$AA,$04,$AD,$B1,$B6
		dc.b	$B1,$AD,$AA,$A8
		Loop	$00,$04,M96_PSG1_Loop02
		Pitch	$FE
		Loop	$01,$02,M96_PSG1_Loop01
		Pitch	$04
		Loop	$02,$03,M96_PSG1_Loop01
		Return

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

M96_FM5:
		Detune	$FC

M96_FM1:
		dc.b	$80,$40
		Loop	$00,$09,M96_FM1
		VoiceFM	$00
		Modulat	$00,$01,$FC,$FF
		dc.b	$A0,$60
		dc.b	$80,$60,$40

	; --- Normal bass ---

M96_FM1_MegaLoop:

M96_FM1_Loop01:
		dc.b	$A0,$18
		dc.b	$A8,$18
		dc.b	$A4,$30
		ModuOff
		dc.b	$A0,$10
		dc.b	$9C,$50
		dc.b	$A8,$08
		dc.b	$A4,$08
		ModulOn
		dc.b	$A0,$30
		Loop	$00,$08,M96_FM1_Loop01
		Jump	M96_FM1_Loop02_Start

M96_FM1_Loop02:
		dc.b	$04

M96_FM1_Loop02_Start:
		dc.b	$80,$40,$40,$40,$40
		dc.b	$A0,$60
		dc.b	$80,$60,$40-$04
		Loop	$00,$03,M96_FM1_Loop02

	; --- Subwoofer bass section ---

		Call	M96_FM_Subwoofer

	; --- Bass crash ---

		dc.b	$80,$68
		VoiceFM	$00
		Modulat	$00,$01,$FC,$FF
		dc.b	$A0,$28

	; --- Normal bass again ---

M96_FM1_Loop04:
		dc.b	$A0,$18
		dc.b	$A8,$18
		dc.b	$A4,$30
		ModuOff
		dc.b	$A0,$10
		dc.b	$9C,$50
		dc.b	$A8,$08
		dc.b	$A4,$08
		ModulOn
		dc.b	$A0,$30
		Loop	$00,$06,M96_FM1_Loop04

		dc.b	$80,$60,$60,$60,$60,$60
		dc.b	$20-$04

	; --- Subwoofer bass section again ---

		Call	M96_FM_Subwoofer

		VoiceFM	$00
		Modulat	$00,$01,$FC,$FF

M96_FM1_Loop05:
		dc.b	$80,$40,$40,$40,$40
		dc.b	$A0,$60
		dc.b	$80,$60,$40
		Loop	$00,$03,M96_FM1_Loop05

		Jump	M96_FM1_MegaLoop

; ---------------------------------------------------------------------------
; Subwoofer bass section (ensure the tracker is -$04 on the timer before calling)
; ---------------------------------------------------------------------------

M96_FM_Subwoofer:
		ModuOff
		VolumFM	$08
		VoiceFM	$02
		Modulat	$00,$01,$FC,$60

M96_FM1_Loop03:
		dc.b	$A4,$18-1,$80,$01
		dc.b	$A0,$18-1,$80,$01
		ModulOn
		dc.b	$9C,$50-1,$80,$01
		ModuOff
		dc.b	$98,$18-1,$80,$01
		dc.b	$9C,$18-1,$80,$01
		ModulOn
		dc.b	$A0,$50-1,$80,$01
		ModuOff
		Pitch	$02
		dc.b	$A4,$18-1,$80,$01
		dc.b	$A0,$18-1,$80,$01
		ModulOn
		dc.b	$9C,$50-1,$80,$01
		ModuOff
		dc.b	$98,$18-1,$80,$01
		dc.b	$9C,$18-1,$80,$01
		ModulOn
		dc.b	$A0,$50-1,$80,$01
		ModuOff
		Pitch	$FE
		Loop	$00,$02,M96_FM1_Loop03
		dc.b	$80,$04
		VolumFM	$F8
		Return

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

M96_FM4:
		VolumFM	$06
		Pan	$80
		Detune	$08
		dc.b	$80,$08
		Jump	M96_FM2

M96_FM3:
		VolumFM	$03
		Pan	$40
		Detune	$04
		dc.b	$80,$04

M96_FM2:
		dc.b	$80,$40
		Loop	$00,$1D,M96_FM2

	; --- Computer bleeps section ---

		VoiceFM	$01

M96_FM2_MegaLoop:

M96_FM2_Loop02:
		Call	M96_FM_Computer
		Pitch	$FE
		Call	M96_FM_Computer
		Pitch	$02
		Loop	$01,$02,M96_FM2_Loop02

M96_FM2_Loop03:
		dc.b	$80,$40
		Loop	$00,$20,M96_FM2_Loop03

	; --- Computer bleeps distanced ---

		Pitch	$02

M96_FM2_Loop04:
		Call	M96_FM_Computer
		dc.b	$80,$40,$40
		Pitch	$02
		Call	M96_FM_Computer
		dc.b	$80,$40,$40
		Pitch	$FE
		Loop	$01,$02,M96_FM2_Loop04
		Pitch	$FE

	; --- Computer bleeps section again ---

		dc.b	$80,$80-1,$10+1

M96_FM2_PauseLoop:
		dc.b	$40
		Loop	$00,$08,M96_FM2_PauseLoop

M96_FM2_Loop05:
		Call	M96_FM_Computer
		Pitch	$FE
		Call	M96_FM_Computer
		Pitch	$02
		Call	M96_FM_Computer
		Pitch	$03
		Call	M96_FM_Computer
		Pitch	$FD
		Loop	$01,$02,M96_FM2_Loop05

		dc.b	$80,$60,$60,$60,$60,$60,$20

	; --- Computer bleeps distanced ---

		Pitch	$02

M96_FM2_Loop06:
		Call	M96_FM_Computer
		dc.b	$80,$40,$40
		Pitch	$02
		Call	M96_FM_Computer
		dc.b	$80,$40,$40
		Pitch	$FE
		Loop	$01,$02,M96_FM2_Loop06
		Pitch	$FE

M96_FM2_PauseLoop2:
		dc.b	$40
		Loop	$00,$28,M96_FM2_PauseLoop2

		Jump	M96_FM2_MegaLoop

; ---------------------------------------------------------------------------
; Computer sound loop
; ---------------------------------------------------------------------------

M96_FM_Computer:
		dc.b	$AA,$04,$AD,$B1,$B6
		VolumFM	$04
		dc.b	$AA,$04,$AD,$B1,$B6
		VolumFM	$04
		Loop	$00,$03,M96_FM_Computer
		dc.b	$AA,$04,$AD,$B1,$B6
		VolumFM	$04
		dc.b	$AA,$04,$AD,$B1,$80
		VolumFM	$E4
		Return

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM 1
; ---------------------------------------------------------------------------

M96_PCM1:

	; --- Intro Synth ---

		Detune	$01
		Call	M96_PCM_SynthIntro
		VoluPSG	$10
		SoftKey
		dc.b	$AB,$10
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$C0
		Detune	$00

	; --- Intro Vocals ---

		Call	M96_PCM_DreadEcho
		Call	M96_PCM_SnareEcho
		Call	M96_PCM_DreadControl

	; --- Small snares ---

M96_PCM1_MegaLoop:

M96_PCM1_Loop01:
		dc.b	$80,$40
		Loop	$00,$07,M96_PCM1_Loop01
		Call	M96_PCM_QuickSnares

	; --- Synth Backgrounds ---

		Modulat	$20,$02,$FF,$FF
		ModuOff

M96_PCM1_Loop02:
		VoicPSG	$29
		dc.b	$B1,$40
		ModulOn
		SoftKey
		dc.b	$40
		ModuOff
		SoftKey
		dc.b	$AF,$40
		SoftKey
		dc.b	$28
		VoicPSG	$2A
		dc.b	$18
		Loop	$00,$04,M96_PCM1_Loop02

	; --- Vocal section ---

		Call	M96_PCM_DreadEcho_Short
		dc.b	$80,$08
		VoicPSG	$2E
		dc.b	$B1,$4A
		VoicPSG	$2F
		VoluPSG	$10
		dc.b	$10
		VoluPSG	$14
		dc.b	$10
		VoluPSG	$18
		dc.b	$10
		VoluPSG	$1C
		dc.b	$06
		VoluPSG	$A8

		dc.b	$80,$40,$40,$40
		Call	M96_PCM_QuickSnares

	; --- Idle drums section ---

M96_PCM1_Loop03:
		dc.b	$80,$40
		Loop	$00,$07,M96_PCM1_Loop03
		Call	M96_PCM_QuickSnares

	; --- Soft Synth area ---

		VoicPSG	$28

M96_PCM1_Loop04:
		dc.b	$AC,$40
		SoftKey
		dc.b	$40
		SoftKey
		dc.b	$40
		SoftKey
		dc.b	$20
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$E0
		Pitch	$FE
		Loop	$00,$02,M96_PCM1_Loop04
		Pitch	$04
		Loop	$01,$02,M96_PCM1_Loop04

	; --- Echo drum section ---

M96_PCM1_Loop05:
		VoluPSG	$0C
		dc.b	$80,$04
		Call	M96_PCM_AmenLoop01_Crash
		Call	M96_PCM_AmenLoop03
		Call	M96_PCM_AmenLoop01
		Call	M96_PCM_AmenLoop02
		Call	M96_PCM_AmenLoop01
		Call	M96_PCM_AmenLoop03
		Call	M96_PCM_AmenLoop01
		VoicPSG	$20
		dc.b	$AF,$08,$B2
		VoicPSG	$22
		dc.b	$B4
		VoicPSG	$20
		dc.b	$AE,$04
		VoluPSG	$F4
		VoicPSG	$22
		dc.b	$B1,$04
		dc.b	$B1,$04
		dc.b	$B1,$04
		dc.b	$B2,$04
		dc.b	$B2,$02
		dc.b	$B2,$02
		dc.b	$B3,$02
		dc.b	$B3,$02
		dc.b	$B4,$02
		dc.b	$B4,$02
		dc.b	$B5,$02
		dc.b	$B6,$02
		Loop	$00,$02,M96_PCM1_Loop05

	; --- Crash break ---

		VoicPSG	$31
		dc.b	$AC,$80-1
		dc.b	$80,$10+1

	; --- Synth Backgrounds again ---


M96_PCM1_Loop06:
		Modulat	$20,$02,$FF,$FF
		ModuOff
		VoicPSG	$29
		dc.b	$B1,$40
		ModulOn
		SoftKey
		dc.b	$40
		ModuOff
		SoftKey
		dc.b	$AF,$40
		SoftKey
		dc.b	$28
		VoicPSG	$2A
		dc.b	$18

		Modulat	$20,$02,$02,$FF
		ModuOff
		VoicPSG	$29
		dc.b	$B1,$40
		ModulOn
		SoftKey
		dc.b	$40
		ModuOff
		SoftKey
		dc.b	$B4,$40
		SoftKey
		dc.b	$28
		VoicPSG	$2A
		dc.b	$18
		Loop	$00,$04,M96_PCM1_Loop06

	; --- Idle drum section ---

M96_PCM1_Loop06_2:
		dc.b	$80,$40
		Loop	$00,$07,M96_PCM1_Loop06_2
		Call	M96_PCM_QuickSnares

M96_PCM1_Loop06_3:
		dc.b	$80,$40
		Loop	$00,$07,M96_PCM1_Loop06_3
		dc.b	$20
		VoicPSG	$22
		dc.b	$B1,$04
		dc.b	$B1,$04
		dc.b	$B1,$04
		dc.b	$B2,$04
		dc.b	$B2,$02
		dc.b	$B2,$02
		dc.b	$B3,$02
		dc.b	$B3,$02
		dc.b	$B4,$02
		dc.b	$B4,$02
		dc.b	$B5,$02
		dc.b	$B6,$02

	; --- Soft Synth area ---

		VoicPSG	$28

M96_PCM1_Loop07:
		dc.b	$AC,$40
		SoftKey
		dc.b	$40
		SoftKey
		dc.b	$40
		SoftKey
		dc.b	$20
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$10
		SoftKey
		dc.b	$10
		VoluPSG	$E0
		Pitch	$FE
		Loop	$00,$02,M96_PCM1_Loop07
		Pitch	$04
		Loop	$01,$03,M96_PCM1_Loop07

		Jump	M96_PCM1_MegaLoop

; ===========================================================================
; ---------------------------------------------------------------------------
; Quick snares at the end of a bar
; ---------------------------------------------------------------------------

M96_PCM_QuickSnares:
		VoicPSG	$22
		dc.b	$80,$20
		dc.b	$B1,$08
		dc.b	$B2,$08
		dc.b	$B5,$04
		dc.b	$B6,$04
		dc.b	$B8,$04
		dc.b	$B9,$04
		Return

; ===========================================================================
; ---------------------------------------------------------------------------
; PCM 2
; ---------------------------------------------------------------------------

M96_PCM2:

	; --- Intro Synth ---

		Call	M96_PCM_SynthIntro

M96_PCM2_Loop01:
		SoftKey
		dc.b	$AB,$40
		Loop	$00,$05,M96_PCM2_Loop01

M96_PCM2_Loop02:
		SoftKey
		VoluPSG	$08
		dc.b	$AB,$10
		Loop	$00,$08,M96_PCM2_Loop02
		VoluPSG	$C0

	; --- Drums ---

		Call	M96_PCM_SnareIntro

M96_PCM2_MegaLoop:
		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoops

		Call	M96_PCM_RespectFade
		dc.b	$80,$40,$40
		Call	M96_PCM_RespectFade
		Call	M96_PCM_SnareIn

		Call	M96_PCM_AmenLoopsCrash
		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoopsCrash

		Call	M96_PCM_BurnSection


		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoops

		VoicPSG	$27
		dc.b	$B5,$10

		VoicPSG	$22
		dc.b	$80,$0F+$08
		VoluPSG	$2C
		Call	M96_PCM_SIT_Loop01

		VoicPSG	$27
		dc.b	$B5,$10

		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoops

		Call	M96_PCM_DreadEcho
		dc.b	$80,$40
		Call	M96_PCM_DreadEcho
		dc.b	$80,$40
		Call	M96_PCM_DreadControl
		dc.b	$80,$40,$40,$40
		Call	M96_PCM_SnareIn
		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoops
		Call	M96_PCM_AmenLoops

		Call	M96_PCM_BurnSection

		Jump	M96_PCM2_MegaLoop

; ===========================================================================
; ---------------------------------------------------------------------------
; Burning vocal section
; ---------------------------------------------------------------------------

M96_PCM_BurnSection:			; done
		dc.b	$80,$38
		Jump	M96_PCM2_BurnStart

M96_PCM2_BurnLoop:
		dc.b	$80,$40,$40

M96_PCM2_BurnStart:
		VoicPSG	$30
		dc.b	$80,$20
		VoluPSG	$40
		dc.b	$B1,$08
		VoluPSG	$F0
		dc.b	$B1,$08
		VoluPSG	$F0
		dc.b	$B1,$08
		VoluPSG	$F0
		dc.b	$B1,$08
		VoluPSG	$F0
		dc.b	$B1,$40
		Loop	$00,$02,M96_PCM2_BurnLoop
		Reverse
		dc.b	$B1,$28
		Reverse
		VoicPSG	$22
		dc.b	$B1,$08
		dc.b	$B2,$08
		dc.b	$B5,$04
		dc.b	$B6,$04
		dc.b	$B8,$04
		dc.b	$B9,$04
		Return

; ---------------------------------------------------------------------------
; Amen loop series
; ---------------------------------------------------------------------------

M96_PCM_AmenLoops:
		Call	M96_PCM_AmenLoop01_Crash
		Call	M96_PCM_AmenLoop03
		Call	M96_PCM_AmenLoop01
		Call	M96_PCM_AmenLoop02
		Call	M96_PCM_AmenLoop01
		Call	M96_PCM_AmenLoop03
		Call	M96_PCM_AmenLoop01
		Jump	M96_PCM_AmenLoop02


M96_PCM_AmenLoopsCrash:
		Call	M96_PCM_AmenLoop01_Crash
		Call	M96_PCM_AmenLoop03
		Call	M96_PCM_AmenLoop01
		Call	M96_PCM_AmenLoop02
		Call	M96_PCM_AmenLoop01
		Call	M96_PCM_AmenLoop03
		Jump	M96_PCM_AmenCrashEnd

; ---------------------------------------------------------------------------
; Crashing end segment
; ---------------------------------------------------------------------------

M96_PCM_AmenCrashEnd:
		VoicPSG	$27
		dc.b	$B1,$10
		VoicPSG	$22
		dc.b	$B4,$08
		VoicPSG	$27
		dc.b	$AD,$10
		VoicPSG	$22
		dc.b	$B2,$08
		VoicPSG	$27
		dc.b	$A4,$20
		dc.b	$80,$30
		Return

; ===========================================================================
; ---------------------------------------------------------------------------
; Respect vocal fading
; ---------------------------------------------------------------------------

M96_PCM_RespectFade:			; DONE
		VoicPSG	$2E
		dc.b	$B1,$10
		VoluPSG	$08
		dc.b	$B0,$10
		VoluPSG	$08
		dc.b	$AF,$10
		VoluPSG	$08
		dc.b	$AE,$10
		VoluPSG	$08
		dc.b	$AD,$10
		VoluPSG	$08
		dc.b	$AC,$10
		VoluPSG	$08
		dc.b	$AB,$10
		VoluPSG	$08
		dc.b	$AA,$10
		VoluPSG	$C8
		Return

; ---------------------------------------------------------------------------
; Synth intro
; ---------------------------------------------------------------------------

M96_PCM_SynthIntro:
		VoicPSG	$28
		dc.b	$B1,$40
		SoftKey
		dc.b	$40
		SoftKey
		dc.b	$40
		Modulat	$00,$01,$FF,$FF
		SoftKey
		dc.b	$40
		ModuOff
		Return

; ---------------------------------------------------------------------------
; Amen Snare Echo
; ---------------------------------------------------------------------------

M96_PCM_SnareEcho:		; done
		VoicPSG	$22
		dc.b	$B5,$08,$08		; 00
		VoluPSG	$20
		dc.b	$08,$08			; 60
		VoluPSG	$F0
		dc.b	$08,$08			; 40
		VoluPSG	$20
		dc.b	$08,$08			; 70
		VoluPSG	$F0
		dc.b	$08,$08			; 60
		VoluPSG	$20
		dc.b	$08,$08			; 78
		VoluPSG	$F0
		dc.b	$08,$08			; 70
		VoluPSG	$20
		dc.b	$08,$08			; 7C
		VoluPSG	$B0
		Return

; ---------------------------------------------------------------------------
; Amen Snare Intro
; ---------------------------------------------------------------------------

M96_PCM_SnareIn:			; done
		VoicPSG	$22
		dc.b	$B5,$03
		VoluPSG	$10
		dc.b	$03,$03
		VoluPSG	$10
		dc.b	$03,$03
		VoluPSG	$1C

M96_PCM_SI_Loop01:
		dc.b	$B5
		dc.b	$03
		dc.b	$03
		VoluPSG	$FC
		dc.b	$03
		dc.b	$03
		VoluPSG	$FC
		Loop	$00,$08,M96_PCM_SI_Loop01
		VoluPSG	$04

M96_PCM_SI_Loop02:
		dc.b	$03
		Loop	$00,$05,M96_PCM_SI_Loop02
		dc.b	$02
		Return

; ---------------------------------------------------------------------------
; Amen Snare Intro (Cut off to prevent vocal roughness)
; ---------------------------------------------------------------------------

M96_PCM_SnareIntro:		; done
		VoicPSG	$22
		dc.b	$80,$0F+$18
		VoluPSG	$2C

M96_PCM_SIT_Loop01:
		dc.b	$B5
		dc.b	$03
		dc.b	$03
		VoluPSG	$FC
		dc.b	$03
		dc.b	$03
		VoluPSG	$FC
		Loop	$00,$06,M96_PCM_SIT_Loop01
		VoluPSG	$04

M96_PCM_SIT_Loop02:
		dc.b	$03
		Loop	$00,$05,M96_PCM_SIT_Loop02
		dc.b	$02
		Return

; ---------------------------------------------------------------------------
; Amen Loop 1
; ---------------------------------------------------------------------------

M96_PCM_AmenLoop01_Crash:
		VoicPSG	$27
		dc.b	$B1,$10
		Jump	M96_PCM_AmenLoop

M96_PCM_AmenLoop01:
		VoicPSG	$20
		dc.b	$AF,$08,$B2

M96_PCM_AmenLoop:
		VoicPSG	$22
		dc.b	$B4,$08
		VoicPSG	$20
		dc.b	$AE,$08,$B2
		VoicPSG	$22
		dc.b	$B3
		VoicPSG	$26
		dc.b	$B4,$04
		VoicPSG	$23
		dc.b	$04
		VoicPSG	$26
		dc.b	$04
		VoicPSG	$23
		dc.b	$04
		Return

; ---------------------------------------------------------------------------
; Amen Loop 2
; ---------------------------------------------------------------------------

M96_PCM_AmenLoop02:
		VoicPSG	$20
		dc.b	$AF,$08,$B2
		VoicPSG	$22
		dc.b	$B4
		VoicPSG	$20
		dc.b	$AE
		VoicPSG	$22
		dc.b	$B3
		VoicPSG	$21
		dc.b	$B1
		VoicPSG	$27
		dc.b	$AF,$0C
		VoicPSG	$23
		dc.b	$04
		Return

; ---------------------------------------------------------------------------
; Amen Loop 3
; ---------------------------------------------------------------------------

M96_PCM_AmenLoop03:
		VoicPSG	$20
		dc.b	$AF,$08,$B2
		VoicPSG	$22
		dc.b	$B2
		VoicPSG	$20
		dc.b	$AE
		VoicPSG	$22
		dc.b	$B3,$08,$B4
		VoicPSG	$20
		dc.b	$AE,$08
		VoicPSG	$26
		dc.b	$B4,$04
		VoicPSG	$23
		dc.b	$04
		Return

; ---------------------------------------------------------------------------
; "Dread Control"
; ---------------------------------------------------------------------------

M96_PCM_DreadControl:	; DONE
		VoicPSG	$2B
		dc.b	$B1,$68
		VoicPSG	$2D
		VoluPSG	$10
		dc.b	$10
		VoluPSG	$10
		dc.b	$10
		VoluPSG	$14
		dc.b	$10
		dc.b	$80,$28
		VoluPSG	$CC
		Return

; ---------------------------------------------------------------------------
; "Dread" Echo
; ---------------------------------------------------------------------------

M96_PCM_DreadEcho:			; done
		VoicPSG	$2C
		dc.b	$B1,$14,$80,$04
		VoluPSG	$10
		dc.b	$B1,$14,$80,$04
		VoluPSG	$10
		dc.b	$B1,$14,$80,$04
		VoluPSG	$14
		dc.b	$B1,$14,$80,$04
		VoluPSG	$18
		dc.b	$B1,$14,$80,$04
		dc.b	$80,$48
		VoluPSG	$B4
		Return

M96_PCM_DreadEcho_Short:		; done
		VoicPSG	$2C
		dc.b	$B1,$14,$80,$04
		VoluPSG	$10
		dc.b	$B1,$14,$80,$04
		VoluPSG	$10
		dc.b	$B1,$14,$80,$04
		VoluPSG	$14
		dc.b	$B1,$14,$80,$04
		VoluPSG	$18
		dc.b	$B1,$14,$80,$04
		VoluPSG	$B4
		Return

; ===========================================================================