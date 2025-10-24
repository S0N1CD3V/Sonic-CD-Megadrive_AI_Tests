; ===========================================================================
; ---------------------------------------------------------------------------
; Sample 68k PCM list
; ---------------------------------------------------------------------------

SampleList:

	; --- Sonic 1 Samples ---

		dc.l	Sonic1Kick				; 00
		dc.l	Sonic1Snare				; 01
		dc.l	Sonic1Timpani			; 02
		dc.l	StopSample	; Free slot	; 03
		dc.l	StopSample	; Free slot	; 04
		dc.l	StopSample	; Free slot	; 05
		dc.l	StopSample	; Free slot	; 06
		dc.l	StopSample	; Free slot	; 07

	; --- Sonic 3 Samples ---

		dc.l	Sonic3WHOOCRASH			; 08
		dc.l	Sonic3WHOO				; 09
		dc.l	Sonic3ComeOn			; 0A
		dc.l	Sonic3KickEh			; 0B
		dc.l	Sonic3HardSnare			; 0C
		dc.l	Sonic3Hit				; 0D
		dc.l	Sonic3Kick				; 0E
		dc.l	Sonic3Snare				; 0F

	; --- Sonic CD Samples ---

		dc.l	SonicCDYe				; 10
		dc.l	SonicCDheah				; 11
		dc.l	SonicCDTom				; 12
		dc.l	SonicCDKick				; 13
		dc.l	SonicCDSnare			; 14
		dc.l	SonicCDSax				; 15
		dc.l	SonicCDScQuick			; 16
		dc.l	SonicCDScSlow			; 17
		dc.l	SonicCDBoink			; 18
		dc.l	SonicCDPadLow			; 19
		dc.l	SonicCDPadHigh			; 1A
		dc.l	SonicCDPPZDrumsP		; Free slot	; 1B
		dc.l	SonicCDPPZBassP			; Free slot	; 1C
		dc.l	SonicCDPPZFluteP		; Free slot	; 1D
		dc.l	SCD_Title				; 1E
		dc.l	SCD_PPZ					; 1F
	
	; --- Jungle Samples ---

		dc.l	JungleAmenKick			; 20
		dc.l	JungleAmenKickLight		; 21
		dc.l	JungleAmenSnare			; 22
		dc.l	JungleAmenSnareLight	; 23
		dc.l	JungleAmenSnareLow		; 24
		dc.l	JungleAmenSnareSoft		; 25
		dc.l	JungleAmenHat			; 26
		dc.l	JungleAmenCrash			; 27
		dc.l	JungleSynthScience		; 28
		dc.l	JungleSynthShakatak		; 29
		dc.l	JungleSynthShakatakEnd	; 2A
		dc.l	JungleVocalDreadFull	; 2B
		dc.l	JungleVocalDread		; 2C
		dc.l	JungleVocalDreadEnd		; 2D
		dc.l	JungleVocalRespect		; 2E
		dc.l	JungleVocalRespectEnd	; 2F
		dc.l	JungleVocalBurning		; 30
		dc.l	JungleVocalFemale		; 31
		dc.l	JungleVocalFemaleEnd	; 32
		dc.l	StopSample	; Free slot	; 33
		dc.l	StopSample	; Free slot	; 34
		dc.l	StopSample	; Free slot	; 35
		dc.l	StopSample	; Free slot	; 36
		dc.l	StopSample	; Free slot	; 37

	; --- 2-Unlimited Samples ---

		dc.l	M2U_Scratch				; 38
		dc.l	M2U_Hat					; 39
		dc.l	M2U_YallReady			; 3A
		dc.l	M2U_YeahYeah			; 3B
		dc.l	StopSample	; Free slot	; 3C
		dc.l	StopSample	; Free slot	; 3D
		dc.l	StopSample	; Free slot	; 3E
		dc.l	StopSample	; Free slot	; 3F

    ; --- Other Sonic CD Samples ---
		dc.l	StopSample	; Free slot	; 40
		dc.l	StopSample  ; Free slot ; 41
		dc.l	StopSample  ; Free slot ; 42
		dc.l	StopSample  ; Free slot ; 43
		dc.l 	SCD_Life                ; 44
		dc.l	SCD_Future              ; 45
		dc.l	SCD_Past                ; 46
		dc.l	SCD_OuttaHere           ; 47
		dc.l	StopSample ; Free slot  ; 48
		dc.l	StopSample ; Free slot  ; 49
		dc.l	StopSample ; Free slot  ; 4A
		dc.l	StopSample ; Free slot  ; 4B
		dc.l	SCD_EoA					; 4C
		dc.l	SCD_Game 				; 4D
		dc.l	SCD_Inv 				; 4E
		dc.l	SCD_Speed 				; 4F 
		dc.l 	StopSample 				; 50
		dc.l	SCD_Future 				; 51
		dc.l	SCD_Past 				; 52
		dc.l	SCD_OuttaHere 			; 53
		dc.l	SCD_PPZ_GF				; 54
		dc.l	SCD_PPZ_BF 				; 55
		dc.l	SCD_Boss 				; 56
		;dc.l	SCD_YDA					; Unused Line

; ---------------------------------------------------------------------------
; Sample z80 pointers
; ---------------------------------------------------------------------------
Sec	=	14000	; Hz per second
Mil	=	1000	; centi-seconds per second

	; --- Stop Sample (used by note 80) ---

StopSample:		dcz80	SWF_StopSample,		SWF_StopSample_Rev,	SWF_StopSample,		SWF_StopSample_Rev

	; --- Sonic 1 Samples ---

Sonic1Kick:		dcz80	SWF_S1_Kick,		SWF_S1_Kick_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic1Snare:		dcz80	SWF_S1_Snare,		SWF_S1_Snare_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic1Timpani:		dcz80	SWF_S1_Timpani,		SWF_S1_Timpani,		SWF_StopSample,		SWF_StopSample_Rev

	; --- Sonic 3 Samples ---

Sonic3WHOOCRASH:	dcz80	SWF_S3_WHOOCRASH,	SWF_S3_WHOOCRASH_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic3WHOO:		dcz80	SWF_S3_WHOO,		SWF_S3_WHOO_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic3ComeOn:		dcz80	SWF_S3_ComeOn,		SWF_S3_ComeOn_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic3KickEh		dcz80	SWF_S3_KickEh,		SWF_S3_KickEh_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic3HardSnare:	dcz80	SWF_S3_HardSnare,	SWF_S3_HardSnare_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic3Hit:		dcz80	SWF_S3_Hit,		SWF_S3_Hit_Rev,		SWF_StopSample,		SWF_StopSample_Rev
Sonic3Kick:		dcz80	SWF_S3_Kick,		SWF_S3_Kick_Rev,	SWF_StopSample,		SWF_StopSample_Rev
Sonic3Snare:		dcz80	SWF_S3_Snare,		SWF_S3_Snare_Rev,	SWF_StopSample,		SWF_StopSample_Rev

	; --- Sonic CD Samples ---

SonicCDYe:		    dcz80	SWF_SCD_Ye,		SWF_SCD_Yeheah_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDheah:		dcz80	SWF_SCD_heah,		SWF_SCD_Yeheah_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDTom:		    dcz80	SWF_SCD_Tom,		SWF_SCD_Tom_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDKick:		dcz80	SWF_SCD_Kick,		SWF_SCD_Kick_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDSnare:		dcz80	SWF_SCD_Snare,		SWF_SCD_Snare_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDSax:		    dcz80	SWF_SCD_Sax,		SWF_SCD_Sax_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDScQuick:		dcz80	SWF_SCD_ScQuick,	SWF_SCD_ScQuick_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDScSlow:		dcz80	SWF_SCD_ScSlow,		SWF_SCD_ScSlow_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDBoink:		dcz80	SWF_SCD_Boink,		SWF_SCD_Boink_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDPadLow:		dcz80	SWF_SCD_PadLow,		SWF_SCD_PadLow_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDPadHigh:		dcz80	SWF_SCD_PadHigh,	SWF_SCD_PadHigh_Rev,	SWF_StopSample,		SWF_StopSample_Rev
SonicCDPPZDrumsP:   dcz80   SWF_SCD_PPZDrumP,   SWF_SCD_PPZDrumP_Rev, SWF_StopSample, SWF_StopSample
SonicCDPPZBassP:    dcz80   SWF_SCD_PPZBassP,   SWF_SCD_PPZBassP_Rev,  SWF_StopSample, SWF_StopSample
SonicCDPPZFluteP:   dcz80   SWF_SCD_PPZFluteP,  SWF_SCD_PPZFluteP_Rev,  SWF_StopSample, SWF_StopSample
;SCD_YDA:   dcz80   SWF_SCD_YDA,  SWF_SCD_YDA_Rev,  SWF_StopSample, SWF_StopSample
SCD_Title:   dcz80   SWF_SCD_Title,  SWF_SCD_Title_Rev,  SWF_StopSample, SWF_StopSample
SCD_PPZ:   		 dcz80   SWF_SCD_PPZ,  SWF_SCD_PPZ_Rev,  SWF_StopSample, SWF_StopSample
SCD_EoA:		 dcz80   SWF_SCD_EoA,  SWF_SCD_EoA_Rev,  SWF_StopSample, SWF_StopSample
SCD_Game:		 dcz80   SWF_SCD_Game,  SWF_SCD_Game_Rev,  SWF_StopSample, SWF_StopSample
SCD_Inv:		 dcz80   SWF_SCD_Inv,  SWF_SCD_Inv_Rev,  SWF_StopSample, SWF_StopSample
SCD_Speed:		 dcz80   SWF_SCD_Speed,  SWF_SCD_Speed_Rev,  SWF_StopSample, SWF_StopSample
SCD_Life:	 dcz80   SWF_SCD_Life,  SWF_SCD_Life_Rev,  SWF_StopSample, SWF_StopSample
SCD_Future:	 dcz80   SWF_SCD_Future,  SWF_SCD_Future_Rev,  SWF_StopSample, SWF_StopSample
SCD_Past:	 dcz80   SWF_SCD_Past,  SWF_SCD_Past_Rev,  SWF_StopSample, SWF_StopSample
SCD_OuttaHere:	 dcz80   SWF_SCD_OuttaHere,  SWF_SCD_OuttaHere_Rev,  SWF_StopSample, SWF_StopSample
SCD_PPZ_GF:		 dcz80   SWF_SCD_PPZ_GF,  SWF_SCD_PPZ_GF_Rev,  SWF_StopSample, SWF_StopSample
SCD_PPZ_BF:		 dcz80   SWF_SCD_PPZ_BF,  SWF_SCD_PPZ_BF_Rev,  SWF_StopSample, SWF_StopSample
SCD_Boss:	 dcz80   SWF_SCD_Boss,  SWF_SCD_Boss_Rev,  SWF_StopSample, SWF_StopSample

	; --- Jungle Samples ---

JungleAmenKick:		dcz80	SWF_JUN_AmenKick,	SWF_JUN_AmenKick_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleAmenKickLight:	dcz80	SWF_JUN_AmenKickLig,	SWF_JUN_AmenKickLig_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleAmenSnare:	dcz80	SWF_JUN_AmenSnare,	SWF_JUN_AmenSnare_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleAmenSnareLight:	dcz80	SWF_JUN_AmenSnareLi,	SWF_JUN_AmenSnareLi_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleAmenSnareLow:	dcz80	SWF_JUN_AmenSnareLo,	SWF_JUN_AmenSnareLo_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleAmenSnareSoft:	dcz80	SWF_JUN_AmenSnareSo,	SWF_JUN_AmenSnareSo_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleAmenHat:		dcz80	SWF_JUN_AmenHat,	SWF_JUN_AmenHat_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleAmenCrash:	dcz80	SWF_JUN_AmenCrash,	SWF_JUN_AmenCrash_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleSynthScience:	dcz80	SWF_JUN_SynthScienc,	SWF_JUN_SynthScienc_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleSynthShakatak:	dcz80	SWF_JUN_SynthShakat,	SWF_JUN_SynthShakat_Rev,SWF_JUN_SynthShakatLoop,SWF_JUN_SynthShakat_Rev
JungleSynthShakatakEnd:	dcz80	SWF_JUN_SynthShaEnd,	SWF_JUN_SynthShaEnd_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleVocalDreadFull:	dcz80	SWF_JUN_VocalDreadFull,	SWF_JUN_VocalDread_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleVocalDread:	dcz80	SWF_JUN_VocalDread,	SWF_JUN_VocalDread_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleVocalDreadEnd:	dcz80	SWF_JUN_VocalDreadEnd,	SWF_JUN_VocalDread_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleVocalRespect:	dcz80	SWF_JUN_VocalRespect,	SWF_JUN_VocalRespct_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleVocalRespectEnd:	dcz80	SWF_JUN_VocalRespectEnd,SWF_JUN_VocalRespct_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleVocalBurning:	dcz80	SWF_JUN_VocalBurn,	SWF_JUN_VocalBurn_Rev,	SWF_StopSample,		SWF_StopSample_Rev
JungleVocalFemale:	dcz80	SWF_JUN_VocalFemale,	SWF_JUN_VocalFemale_Rev,SWF_StopSample,		SWF_StopSample_Rev
JungleVocalFemaleEnd:	dcz80	SWF_JUN_VocalFemaleEnd,	SWF_JUN_VocalFemale_Rev,SWF_StopSample,		SWF_StopSample_Rev

	; --- 2-Unlimited Samples ---

M2U_Scratch:		dcz80	SWF_2U_Scratch,		SWF_2U_Scratch_Rev,	SWF_StopSample,		SWF_StopSample_Rev
M2U_Hat:		dcz80	SWF_2U_Hat,		SWF_2U_Hat_Rev,		SWF_StopSample,		SWF_StopSample_Rev
M2U_YallReady:		dcz80	SWF_2U_YallReady,	SWF_2U_YallReady_Rev,	SWF_StopSample,		SWF_StopSample_Rev
M2U_YeahYeah:		dcz80	SWF_2U_YeahYeah,	SWF_2U_YeahYeah_Rev,	SWF_StopSample,		SWF_StopSample_Rev

; ---------------------------------------------------------------------------
; Sample file includes
; ---------------------------------------------------------------------------
			align	$8000,$FF
; ---------------------------------------------------------------------------

	; --- Volume tables ---

PCM_Volumes:		incbin	"Volume Maker\Volumes.bin"

	; --- Stop Sample (used by note 80) ---

			EndMarker
SWF_StopSample:		dcb.b	$8000-((Z80E_Read*(($1000+$100)/$100))*2),$80
SWF_StopSample_Rev:	EndMarker

	; --- Sonic 1 Samples ---

SWF_S1_Kick:		incbin	"Dual PCM\Samples\incswf\Sonic 1 Kick.swf"
SWF_S1_Kick_Rev:	EndMarker
SWF_S1_Snare:		incbin	"Dual PCM\Samples\incswf\Sonic 1 Snare.swf"
SWF_S1_Snare_Rev:	EndMarker
SWF_S1_Timpani:		incbin	"Dual PCM\Samples\incswf\Sonic 1 Timpani.swf"
SWF_S1_Timpani_Rev:	EndMarker

	; --- Sonic 3 Samples ---

SWF_S3_WHOOCRASH:	incbin	"Dual PCM\Samples\incswf\Sonic 3 WHOO! (With Crash).swf"
SWF_S3_WHOOCRASH_Rev:	EndMarker
SWF_S3_WHOO:		incbin	"Dual PCM\Samples\incswf\Sonic 3 WHOO!.swf"
SWF_S3_WHOO_Rev:	EndMarker
SWF_S3_ComeOn:		incbin	"Dual PCM\Samples\incswf\Sonic 3 Come On!.swf"
SWF_S3_ComeOn_Rev:	EndMarker
SWF_S3_KickEh:		incbin	"Dual PCM\Samples\incswf\Sonic 3 Kick Eh!.swf"
SWF_S3_KickEh_Rev:	EndMarker
SWF_S3_HardSnare:	incbin	"Dual PCM\Samples\incswf\Sonic 3 Hard Snare.swf"
SWF_S3_HardSnare_Rev:	EndMarker
SWF_S3_Hit:		incbin	"Dual PCM\Samples\incswf\Sonic 3 Hit.swf"
SWF_S3_Hit_Rev:		EndMarker
SWF_S3_Kick:		incbin	"Dual PCM\Samples\incswf\Sonic 3 Kick.swf"
SWF_S3_Kick_Rev:	EndMarker
SWF_S3_Snare:		incbin	"Dual PCM\Samples\incswf\Sonic 3 Snare.swf"
SWF_S3_Snare_Rev:	EndMarker

	; --- Sonic CD Samples ---

SWF_SCD_Ye:		incbin	"Dual PCM\Samples\incswf\Sonic CD Ye-.swf"
SWF_SCD_Heah:		incbin	"Dual PCM\Samples\incswf\Sonic CD -heah.swf"
SWF_SCD_Yeheah_Rev:	EndMarker
SWF_SCD_Tom:		incbin	"Dual PCM\Samples\incswf\Sonic CD Tom.swf"
SWF_SCD_Tom_Rev:	EndMarker
SWF_SCD_Kick:		incbin	"Dual PCM\Samples\incswf\Sonic CD Kick.swf"
SWF_SCD_Kick_Rev:	EndMarker
SWF_SCD_Snare:		incbin	"Dual PCM\Samples\incswf\Sonic CD Snare.swf"
SWF_SCD_Snare_Rev:	EndMarker
SWF_SCD_Sax:		incbin	"Dual PCM\Samples\incswf\Sonic CD Sax.swf"
SWF_SCD_Sax_Rev:	EndMarker
SWF_SCD_ScQuick:	incbin	"Dual PCM\Samples\incswf\Sonic CD Scratch Quick.swf"
SWF_SCD_ScQuick_Rev:	EndMarker
SWF_SCD_ScSlow:		incbin	"Dual PCM\Samples\incswf\Sonic CD Scratch Slow.swf"
SWF_SCD_ScSlow_Rev:	EndMarker
SWF_SCD_Boink:		incbin	"Dual PCM\Samples\incswf\Sonic CD Boink.swf"
SWF_SCD_Boink_Rev:	EndMarker
SWF_SCD_PadLow:		incbin	"Dual PCM\Samples\incswf\Sonic CD Pad Low.swf"
SWF_SCD_PadLow_Rev:	EndMarker
SWF_SCD_PadHigh:	incbin	"Dual PCM\Samples\incswf\Sonic CD Pad High.swf"
SWF_SCD_PadHigh_Rev:	EndMarker
SWF_SCD_PPZDrumP:	incbin	"Dual PCM\Samples\incswf\Drum Loop.bin"
SWF_SCD_PPZDrumP_Rev:	EndMarker
SWF_SCD_PPZBassP:	incbin	"Dual PCM\Samples\incswf\Sonic CD Bass PPZ Past.swf"
SWF_SCD_PPZBassP_Rev:	EndMarker
SWF_SCD_PPZFluteP:	incbin	"Dual PCM\Samples\incswf\Sonic CD Flute PPZ Past.swf"
SWF_SCD_PPZFluteP_Rev:	EndMarker

SWF_SCD_Life: incbin "Dual PCM\Samples\incswf\SCD_Life_1.swf"
SWF_SCD_Life_Rev: EndMarker

SWF_SCD_Future: incbin "Dual PCM\Samples\incswf\SCD_Future!.swf"
SWF_SCD_Future_Rev: EndMarker
SWF_SCD_Past: incbin "Dual PCM\Samples\incswf\SCD Past!.swf"
SWF_SCD_Past_Rev: EndMarker
SWF_SCD_OuttaHere: incbin "Dual PCM\Samples\incswf\SCD_OuttaHere!.swf"
SWF_SCD_OuttaHere_Rev: EndMarker
SWF_SCD_Title: ;incbin "Dual PCM\Samples\incswf\26 Title Screen.swf"
SWF_SCD_Title_Rev: EndMarker
SWF_SCD_PPZ: ;incbin "Dual PCM\Samples\incswf\PPZ Present.swf"
SWF_SCD_PPZ_Rev: EndMarker
SWF_SCD_EoA: ;incbin "Dual PCM\Samples\incswf\28 Act Clear.swf"
SWF_SCD_EoA_Rev: EndMarker
SWF_SCD_Game: ;incbin "Dual PCM\Samples\incswf\31 Game Over.swf"
SWF_SCD_Game_Rev: EndMarker
SWF_SCD_Inv: ;incbin "Dual PCM\Samples\incswf\30 Invincble.swf"
SWF_SCD_Inv_Rev: EndMarker
SWF_SCD_Speed: ;incbin "Dual PCM\Samples\incswf\29 Speed Up.swf"
SWF_SCD_Speed_Rev: EndMarker
SWF_SCD_PPZ_GF: ;incbin "Dual PCM\Samples\incswf\04 Palmtree Panic Good Future.swf"
SWF_SCD_PPZ_GF_Rev: EndMarker
SWF_SCD_PPZ_BF: ;incbin "Dual PCM\Samples\incswf\05 Palmtree Panic Bad Future.swf"
SWF_SCD_PPZ_BF_Rev: EndMarker
SWF_SCD_Boss: ;incbin "Dual PCM\Samples\incswf\24 Boss.swf"
SWF_SCD_Boss_Rev: EndMarker


	; --- Jungle Samples ---

SWF_JUN_AmenKick:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Kick.swf"
SWF_JUN_AmenKick_Rev:	EndMarker
SWF_JUN_AmenKickLig:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Kick Light.swf"
SWF_JUN_AmenKickLig_Rev:EndMarker
SWF_JUN_AmenSnare:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Snare.swf"
SWF_JUN_AmenSnare_Rev:	EndMarker
SWF_JUN_AmenSnareLi:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Snare Light.swf"
SWF_JUN_AmenSnareLi_Rev:EndMarker
SWF_JUN_AmenSnareLo:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Snare Low.swf"
SWF_JUN_AmenSnareLo_Rev:EndMarker
SWF_JUN_AmenSnareSo:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Snare Soft.swf"
SWF_JUN_AmenSnareSo_Rev:EndMarker
SWF_JUN_AmenHat:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Hat.swf"
SWF_JUN_AmenHat_Rev:	EndMarker
SWF_JUN_AmenCrash:	incbin	"Dual PCM\Samples\incswf\Jungle Amen Crash.swf"
SWF_JUN_AmenCrash_Rev:	EndMarker
SWF_JUN_SynthScienc:	incbin	"Dual PCM\Samples\incswf\Jungle Synth Science.swf"
SWF_JUN_SynthScienc_Rev:EndMarker
SWF_JUN_SynthShakat:	incbin	"Dual PCM\Samples\incswf\Jungle Synth Shakatak 01.swf"
SWF_JUN_SynthShakatLoop:incbin	"Dual PCM\Samples\incswf\Jungle Synth Shakatak 02.swf"
SWF_JUN_SynthShakat_Rev:EndMarker
SWF_JUN_SynthShaEnd:	incbin	"Dual PCM\Samples\incswf\Jungle Synth Shakatak 03.swf"
SWF_JUN_SynthShaEnd_Rev:EndMarker
SWF_JUN_VocalDreadFull:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Dread Control 01.swf"
SWF_JUN_VocalDread:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Dread Control 02.swf"
SWF_JUN_VocalDreadEnd:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Dread Control 03.swf"
SWF_JUN_VocalDread_Rev:	EndMarker
SWF_JUN_VocalRespect:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Respect 01.swf"
SWF_JUN_VocalRespectEnd:incbin	"Dual PCM\Samples\incswf\Jungle Vocal Respect 02.swf"
SWF_JUN_VocalRespct_Rev:EndMarker
SWF_JUN_VocalBurn:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Burning.swf"
SWF_JUN_VocalBurn_Rev:	EndMarker
SWF_JUN_VocalFemale:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Female 01.swf"
SWF_JUN_VocalFemaleEnd:	incbin	"Dual PCM\Samples\incswf\Jungle Vocal Female 02.swf"
SWF_JUN_VocalFemale_Rev:EndMarker

	; --- 2-Unlimited Samples ---

SWF_2U_Scratch:		incbin	"Dual PCM\Samples\incswf\2U Scratch.swf"
SWF_2U_Scratch_Rev:	EndMarker
SWF_2U_Hat:		incbin	"Dual PCM\Samples\incswf\2U Hat.swf"
SWF_2U_Hat_Rev:		EndMarker
SWF_2U_YallReady:	incbin	"Dual PCM\Samples\incswf\2U Yall Ready.swf"
SWF_2U_YallReady_Rev:	EndMarker
SWF_2U_YeahYeah:	incbin	"Dual PCM\Samples\incswf\2U YeahYeah.swf"
SWF_2U_YeahYeah_Rev:	EndMarker

; ===========================================================================