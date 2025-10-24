Go_SoundTypes:	dc.l SoundTypes		; XREF: Sound_Play
Go_SoundD0:	dc.l SoundD0Index	; XREF: Sound_D0toDF
Go_MusicIndex:	dc.l MusicIndex		; XREF: Sound_81to9F
Go_SoundIndex:	dc.l SoundIndex		; XREF: Sound_A0toCF
off_719A0:	dc.l byte_71A94		; XREF: Sound_81to9F
Go_PSGIndex:	dc.l PSG_Index		; XREF: sub_72926
; ---------------------------------------------------------------------------
; PSG instruments used in music
; ---------------------------------------------------------------------------
PSG_Index:	dc.l PSG1, PSG2, PSG3
		dc.l PSG4, PSG5, PSG6
		dc.l PSG7, PSG8, PSG9
PSG1:		incbin	sound\psg1.bin
PSG2:		incbin	sound\psg2.bin
PSG3:		incbin	sound\psg3.bin
PSG4:		incbin	sound\psg4.bin
PSG6:		incbin	sound\psg6.bin
PSG5:		incbin	sound\psg5.bin
PSG7:		incbin	sound\psg7.bin
PSG8:		incbin	sound\psg8.bin
PSG9:		incbin	sound\psg9.bin

byte_71A94:	dc.b 7,	$72, $73, $26, $15, 8, $FF, 5
; ---------------------------------------------------------------------------
; Music	Pointers
; ---------------------------------------------------------------------------
MusicIndex:
ptr_mus81:	dc.l Music81
ptr_mus82:	dc.l Music82
ptr_mus83:	dc.l Music83
ptr_mus84:	dc.l Music84
ptr_mus85:	dc.l Music85
ptr_mus86:	dc.l Music86
ptr_mus87:	dc.l Music87
ptr_mus88:	dc.l Music88
ptr_mus89:	dc.l Music89
ptr_mus8A:	dc.l Music8A
ptr_mus8B:	dc.l Music8B
ptr_mus8C:	dc.l Music8C
ptr_mus8D:	dc.l Music8D
ptr_mus8E:	dc.l Music8E
ptr_mus8F:	dc.l Music8F
ptr_mus90:	dc.l Music90
ptr_mus91:	dc.l Music91
ptr_mus92:	dc.l Music92
ptr_mus93:	dc.l Music93
ptr_musend
; ---------------------------------------------------------------------------
; Type of sound	being played ($90 = music; $70 = normal	sound effect)
; ---------------------------------------------------------------------------
SoundTypes:	dc.b $90, $90, $90, $90, $90, $90, $90,	$90, $90, $90, $90, $90, $90, $90, $90,	$90
		dc.b $90, $90, $90, $90, $90, $90, $90,	$90, $90, $90, $90, $90, $90, $90, $90,	$80
		dc.b $70, $70, $70, $70, $70, $70, $70,	$70, $70, $68, $70, $70, $70, $60, $70,	$70
		dc.b $60, $70, $60, $70, $70, $70, $70,	$70, $70, $70, $70, $70, $70, $70, $7F,	$60
		dc.b $70, $70, $70, $70, $70, $70, $70,	$70, $70, $70, $70, $70, $70, $70, $70,	$80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80, $80, $80, $80, $80, $80,	$90
		dc.b $90, $90, $90, $90

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

YM_Access_WaitRead:
		StartZ80					; EXT: request Z80 stop off (allow it to continue)
		rept	$10					; EXT: delay for a long enough time to allow the...
		nop						; EXT: '' ...68k pointer to be saved correctly.
		endr						; EXT: ''
UpdateMusic:
sub_71B4C:	
		lea	($FFF000).l,a6

		lea	($A00000+YM_Access).l,a0		; EXT: load access address in Z80
		move.l	#$A00000,d0				; EXT: prepare Z80 RAM address in d0 (i.e. start of Cue list address)
		StopZ80						; EXT: request Z80 stop on
		tst.b	(a0)+					; EXT: is the Z80 accessing the 68k pointer?
		bne.s	YM_Access_WaitRead			; EXT: if so, branch and wait for it to finish...
		move.b	(a0)+,d1				; EXT: load lower byte of pointer
		move.b	(a0)+,d0				; EXT: load upper byte of pointer
		StartZ80					; EXT: request Z80 stop off
		lsl.w	#$08,d0					; EXT: shift upper byte up
		move.b	d1,d0					; EXT: put lower byte with it
		move.l	d0,$10(a6)				; EXT: store the cue address

		clr.b	$E(a6)
		tst.b	3(a6)		; is music paused?
		bne.w	loc_71E50	; if yes, branch
		subq.b	#1,1(a6)
		bne.s	loc_71B9E
		jsr	sub_7260C(pc)

loc_71B9E:
		move.b	4(a6),d0
		beq.s	loc_71BA8
		jsr	sub_72504(pc)

loc_71BA8:
		tst.b	$24(a6)
		beq.s	loc_71BB2
		jsr	sub_7267C(pc)

loc_71BB2:
		tst.w	$A(a6)		; is music or sound being played?
		beq.s	loc_71BBC	; if not, branch
		jsr	Sound_Play(pc)

loc_71BBC:
		cmpi.b	#$80,9(a6)
		beq.s	loc_71BC8
		jsr	Sound_ChkValue(pc)

loc_71BC8:
		lea	$40-$30(a6),a5			; MJ: making correction for flow below
		moveq	#2-1,d7				; MJ: set number of PCM channels to run
		move.b	#$80-1,$08(a6)			; MJ: reset as PCM channel

SD_NextPCM:
		addq.b	#$01,$08(a6)			; MJ: advance PCM channel ID
		lea	$30(a5),a5			; MJ: advance to next channel
		tst.b	(a5)
		bpl.s	loc_71BD4
		jsr	sub_71C4E(pc)

loc_71BD4:
		dbf	d7,SD_NextPCM			; MJ: repeat for number of PCM channels available
		clr.b	8(a6)
		moveq	#5,d7

loc_71BDA:
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_71BE6
		jsr	sub_71CCA(pc)

loc_71BE6:
		dbf	d7,loc_71BDA

		moveq	#2,d7

loc_71BEC:
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_71BF8
		jsr	sub_72850(pc)

loc_71BF8:
		dbf	d7,loc_71BEC

		move.b	#$80,$E(a6)
		moveq	#2,d7

loc_71C04:
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_71C10
		jsr	sub_71CCA(pc)

loc_71C10:
		dbf	d7,loc_71C04

		moveq	#2,d7

loc_71C16:
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_71C22
		jsr	sub_72850(pc)

loc_71C22:
		dbf	d7,loc_71C16
		move.b	#$40,$E(a6)
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_71C38
		jsr	sub_71CCA(pc)

loc_71C38:
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_71C44
		jsr	sub_72850(pc)

loc_71C44:
		bra.s	YM_Access_TestWrite			; EXT: jump into the access loop

YM_Access_WaitWrite:
		StartZ80					; EXT: request Z80 stop off (allow it to continue)
		rept	$10					; EXT: delay for a long enough time to let the Z80...
		nop						; EXT: '' ...finish writing the 68k pointer, so it doesn't...
		endr						; EXT: '' ...clash with 68k's pointer writing.

YM_Access_TestWrite:
		lea	($A00000+YM_Access).l,a0		; EXT: load access address in Z80
		lea	$13(a6),a1				; EXT: load the 68k's pointer finish location
		StopZ80						; EXT: request Z80 stop on
		tst.b	(a0)+					; EXT: is the Z80 accessing the 68k pointer?
		bne.s	YM_Access_WaitWrite			; EXT: if so, branch and wait for it to finish...
		move.b	(a1),(a0)+				; EXT: save lower byte of pointer
		move.b	-(a1),(a0)				; EXT: save upper byte of pointer
		StartZ80					; EXT: request Z80 stop off

		rts	

; End of function sub_71B4C


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71C4E:				; XREF: sub_71B4C
		subq.b	#1,$E(a5)
		bne.w	locret_71CAA
		movea.l	4(a5),a4

loc_71C5E:
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#-$20,d5
		bcs.s	loc_71C6E
		jsr	sub_72A5A(pc)
		bra.s	loc_71C5E
; ===========================================================================

loc_71C6E:
		tst.b	d5
		bpl.s	loc_71C84
		move.b	d5,$10(a5)
		move.b	(a4)+,d5
		bpl.s	loc_71C84
		subq.w	#1,a4
		move.b	$F(a5),$E(a5)
		bra.s	loc_71C88
; ===========================================================================

loc_71C84:
		jsr	sub_71D40(pc)

loc_71C88:
		move.l	a4,4(a5)
		btst	#2,(a5)
		bne.s	locret_71CAA
		moveq	#0,d0
		move.b	$10(a5),d0
		subi.b	#$80,d0					; MJ: minus 80
		add.w	d0,d0					; MJ: multiply by 4 (long-word size)
		add.w	d0,d0					; MJ: ''
		movem.l	a0/a1,-(sp)				; MJ: store register data
		lea	(SampleList).l,a0			; MJ: load sample list
		move.l	(a0,d0.w),a0				; MJ: load correct sample z80 pointer address

		cmpi.b	#$80,$08(a6)				; MJ: is this PCM 1?
		bne.s	WritePCM2				; MJ: if not, branch for PCM 2 writing

	; --- Writing to PCM 1 ---

		StopZ80
		lea	($A00000+PCM1_Sample).l,a1			; MJ: load PCM 1 slot address
		move.b	(a0)+,(a1)+					; MJ: set address of sample
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	#(CUPCM1_NewSample&$FF),($A00000+CU_Stack).l	; MJ: set routine to run
		move.b	#(CUPCM1_NewSample>>$08),($A00000+CU_Stack+1).l	; MJ: ''
		move.b	#%11001001,($A00000+CUPCM1_RET).l		; MJ: change "NOP" to "RET"
		StartZ80

		movem.l	(sp)+,a0/a1				; MJ: restore register data

locret_71CAA:
		rts						; MJ: return

	; --- Writing to PCM 2 ---

WritePCM2:
		StopZ80
		lea	($A00000+PCM2_Sample).l,a1			; MJ: load PCM 2 slot address
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	#%00101000,($A00000+CUPCM2_RET).l		; change "JR NZ" to "JR Z"
		StartZ80

		movem.l	(sp)+,a0/a1				; MJ: restore register data
		rts						; MJ: return

; ===========================================================================

sub_71CCA:				; XREF: sub_71B4C
		subq.b	#1,$E(a5)
		bne.s	loc_71CE0
		bclr	#4,(a5)
		jsr	sub_71CEC(pc)
		jsr	sub_71E18(pc)
		bra.w	loc_726E2
; ===========================================================================

loc_71CE0:
		jsr	sub_71D9E(pc)
		jsr	sub_71DC6(pc)
		bra.w	loc_71E24
; End of function sub_71CCA


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71CEC:				; XREF: sub_71CCA
		movea.l	4(a5),a4
		bclr	#1,(a5)

loc_71CF4:
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#-$20,d5
		bcs.s	loc_71D04
		jsr	sub_72A5A(pc)
		bra.s	loc_71CF4
; ===========================================================================

loc_71D04:
		jsr	sub_726FE(pc)
		tst.b	d5
		bpl.s	loc_71D1A
		jsr	sub_71D22(pc)
		move.b	(a4)+,d5
		bpl.s	loc_71D1A
		subq.w	#1,a4
		bra.w	sub_71D60
; ===========================================================================

loc_71D1A:
		jsr	sub_71D40(pc)
		bra.w	sub_71D60
; End of function sub_71CEC


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71D22:				; XREF: sub_71CEC
		subi.b	#$80,d5
		beq.s	loc_71D58
		add.b	8(a5),d5
		andi.w	#$7F,d5
		lsl.w	#1,d5
		lea	word_72790(pc),a0
		move.w	(a0,d5.w),d6
		move.w	d6,$10(a5)
		rts	
; End of function sub_71D22


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71D40:				; XREF: sub_71C4E; sub_71CEC; sub_72878
		move.b	d5,d0
		move.b	2(a5),d1

loc_71D46:
		subq.b	#1,d1
		beq.s	loc_71D4E
		add.b	d5,d0
		bra.s	loc_71D46
; ===========================================================================

loc_71D4E:
		move.b	d0,$F(a5)
		move.b	d0,$E(a5)
		rts	
; End of function sub_71D40

; ===========================================================================

loc_71D58:				; XREF: sub_71D22
		bset	#1,(a5)
		clr.w	$10(a5)

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71D60:				; XREF: sub_71CEC; sub_72878; sub_728AC
		move.l	a4,4(a5)
		move.b	$F(a5),$E(a5)
		btst	#4,(a5)
		bne.s	locret_71D9C
		move.b	$13(a5),$12(a5)
		clr.b	$C(a5)
		btst	#3,(a5)
		beq.s	locret_71D9C
		movea.l	$14(a5),a0
		move.b	(a0)+,$18(a5)
		move.b	(a0)+,$19(a5)
		move.b	(a0)+,$1A(a5)
		move.b	(a0)+,d0
		lsr.b	#1,d0
		move.b	d0,$1B(a5)
		clr.w	$1C(a5)

locret_71D9C:
		rts	
; End of function sub_71D60


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71D9E:				; XREF: sub_71CCA; sub_72850
		tst.b	$12(a5)
		beq.s	locret_71DC4
		subq.b	#1,$12(a5)
		bne.s	locret_71DC4
		bset	#1,(a5)
		tst.b	1(a5)
		bmi.w	loc_71DBE
		jsr	sub_726FE(pc)
		addq.w	#4,sp
		rts	
; ===========================================================================

loc_71DBE:
		jsr	sub_729A0(pc)
		addq.w	#4,sp

locret_71DC4:
		rts	
; End of function sub_71D9E


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71DC6:				; XREF: sub_71CCA; sub_72850
		addq.w	#4,sp
		btst	#3,(a5)
		beq.s	locret_71E16
		tst.b	$18(a5)
		beq.s	loc_71DDA
		subq.b	#1,$18(a5)
		rts	
; ===========================================================================

loc_71DDA:
		subq.b	#1,$19(a5)
		beq.s	loc_71DE2
		rts	
; ===========================================================================

loc_71DE2:
		movea.l	$14(a5),a0
		move.b	1(a0),$19(a5)
		tst.b	$1B(a5)
		bne.s	loc_71DFE
		move.b	3(a0),$1B(a5)
		neg.b	$1A(a5)
		rts	
; ===========================================================================

loc_71DFE:
		subq.b	#1,$1B(a5)
		move.b	$1A(a5),d6
		ext.w	d6
		add.w	$1C(a5),d6
		move.w	d6,$1C(a5)
		add.w	$10(a5),d6
		subq.w	#4,sp

locret_71E16:
		rts	
; End of function sub_71DC6


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_71E18:				; XREF: sub_71CCA
		btst	#1,(a5)
		bne.s	locret_71E48
		move.w	$10(a5),d6
		beq.s	loc_71E4A

loc_71E24:				; XREF: sub_71CCA
		move.b	$1E(a5),d0
		ext.w	d0
		add.w	d0,d6
		btst	#2,(a5)
		bne.s	locret_71E48
		move.w	d6,d1
		lsr.w	#8,d1
		move.b	#-$5C,d0
		jsr	sub_72722(pc)
		move.b	d6,d1
		move.b	#-$60,d0
		jsr	sub_72722(pc)

locret_71E48:
		rts	
; ===========================================================================

loc_71E4A:
		bset	#1,(a5)
		rts	
; End of function sub_71E18

; ===========================================================================

loc_71E50:				; XREF: sub_71B4C
		bmi.s	loc_71E94
		cmpi.b	#2,3(a6)
		beq.w	loc_71EFE
		move.b	#2,3(a6)
		moveq	#2,d3
		move.b	#-$4C,d0
		moveq	#0,d1

loc_71E6A:
		jsr	sub_7272E(pc)
		jsr	sub_72764(pc)
		addq.b	#1,d0
		dbf	d3,loc_71E6A

		moveq	#2,d3
		moveq	#$28,d0

loc_71E7C:
		move.b	d3,d1
		jsr	sub_7272E(pc)
		addq.b	#4,d1
		jsr	sub_7272E(pc)
		dbf	d3,loc_71E7C

		jsr	sub_729B6(pc)
		bra.w	loc_71C44
; ===========================================================================

loc_71E94:				; XREF: loc_71E50
		clr.b	3(a6)
		moveq	#$30,d3
		lea	$40(a6),a5
		moveq	#7,d4					; MJ: number of YM2612 based channels

loc_71EA0:
		btst	#7,(a5)
		beq.s	loc_71EB8
		btst	#2,(a5)
		bne.s	loc_71EB8
		move.b	#-$4C,d0
		move.b	$A(a5),d1
		jsr	sub_72722(pc)

loc_71EB8:
		adda.w	d3,a5
		dbf	d4,loc_71EA0

		lea	$250(a6),a5				; MJ: new SFX location
		moveq	#2,d4

loc_71EC4:
		btst	#7,(a5)
		beq.s	loc_71EDC
		btst	#2,(a5)
		bne.s	loc_71EDC
		move.b	#-$4C,d0
		move.b	$A(a5),d1
		jsr	sub_72722(pc)

loc_71EDC:
		adda.w	d3,a5
		dbf	d4,loc_71EC4

		lea	$370(a6),a5				; MJ: new SFX location
		btst	#7,(a5)
		beq.s	loc_71EFE
		btst	#2,(a5)
		bne.s	loc_71EFE
		move.b	#-$4C,d0
		move.b	$A(a5),d1
		jsr	sub_72722(pc)

loc_71EFE:
		bra.w	loc_71C44

; ---------------------------------------------------------------------------
; Subroutine to	play a sound or	music track
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sound_Play:				; XREF: sub_71B4C
		movea.l	(Go_SoundTypes).l,a0
		lea	$A(a6),a1	; load music track number
		move.b	0(a6),d3
		moveq	#2,d4

loc_71F12:
		move.b	(a1),d0		; move track number to d0
		move.b	d0,d1
		clr.b	(a1)+
		subi.b	#$81,d0
		bcs.s	loc_71F3E
		cmpi.b	#$80,9(a6)
		beq.s	loc_71F2C
		move.b	d1,$A(a6)
		bra.s	loc_71F3E
; ===========================================================================

loc_71F2C:
		andi.w	#$7F,d0
		move.b	(a0,d0.w),d2
		cmp.b	d3,d2
		bcs.s	loc_71F3E
		move.b	d2,d3
		move.b	d1,9(a6)	; set music flag

loc_71F3E:
		dbf	d4,loc_71F12

		tst.b	d3
		bmi.s	locret_71F4A
		move.b	d3,0(a6)

locret_71F4A:
		rts	
; End of function Sound_Play


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sound_ChkValue:				; XREF: sub_71B4C
		moveq	#0,d7
		move.b	9(a6),d7
		beq.w	Sound_E4
		bpl.s	locret_71F8C
		move.b	#$80,9(a6)	; reset	music flag
		cmpi.b	#$9F,d7
		bls.w	Sound_81to9F	; music	$81-$9F
		cmpi.b	#$A0,d7
		bcs.w	locret_71F8C
		cmpi.b	#$CF,d7
		bls.w	Sound_A0toCF	; sound	$A0-$CF
		cmpi.b	#$D0,d7
		bcs.w	locret_71F8C
		cmpi.b	#$E0,d7
		bcs.w	Sound_D0toDF	; sound	$D0-$DF
		cmpi.b	#$E4,d7
		bls.s	Sound_E0toE4	; sound	$E0-$E4

locret_71F8C:
		rts	
; ===========================================================================

Sound_E0toE4:				; XREF: Sound_ChkValue
		subi.b	#$E0,d7
		lsl.w	#2,d7
		jmp	Sound_ExIndex(pc,d7.w)
; ===========================================================================

Sound_ExIndex:
ptr_flgE0:		bra.w	Sound_E0
; ===========================================================================
ptr_flgE1:		bra.w	Sound_E1
; ===========================================================================
ptr_flgE2:		bra.w	Sound_E2
; ===========================================================================
ptr_flgE3:		bra.w	Sound_E3
; ===========================================================================
ptr_flgE4:		bra.w	Sound_E4
; ===========================================================================
ptr_flgend
; ---------------------------------------------------------------------------
; Play "Say-gaa" PCM sound
; ---------------------------------------------------------------------------

Sound_E1:
		StopZ80						; MJ: request Z80 stop "ON"
		lea	(SegaPCM).l,a2				; MJ: load sample address
		lea	($A04000).l,a3				; MJ: load YM2612 port
		move.b	#$2A,(a3)+				; MJ: set YM2612 address to the PCM data port
		move.l	#(SegaPCM_End-SegaPCM)-$01,d4		; MJ: prepare size
		move.w	d4,d3					; MJ: get lower word size
		swap	d4					; MJ: get upper word size

PlayPCM_Loop:
		move.b	(a2)+,(a3)				; MJ: save sample data to port
		moveq	#$2B,d0					; MJ: set delay time
		dbf	d0,*					; MJ: delay...
		dbf	d3,PlayPCM_Loop				; MJ: repeat til done
		dbf	d4,PlayPCM_Loop				; MJ: ''
		move.b	#$80,(a3)				; MJ: save mute data to port
		addq.w	#$04,sp					; MJ: skip return address
		subq.w	#$01,a3					; MJ: move back to address port
		tst.b	(a3)					; MJ: is the YM2612 busy?
		bmi.s	*-$02					; MJ: if so, branch and recheck
		move.b	#$2A,(a3)				; MJ: write address (set it back to DAC port for the Z80)
		StartZ80					; MJ: request Z80 stop "OFF"
		rts						; MJ: return

; ===========================================================================
; ---------------------------------------------------------------------------
; Play music track $81-$9F
; ---------------------------------------------------------------------------

Sound_81to9F:				; XREF: Sound_ChkValue


		StopZ80
		lea	(StopSample).l,a0				; MJ: load stop sample address
		lea	($A00000+PCM1_Sample).l,a1			; MJ: load PCM 1 slot address
		move.b	(a0)+,(a1)+					; MJ: set address of sample
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	#(CUPCM1_NewSample&$FF),($A00000+CU_Stack).l	; MJ: set routine to run
		move.b	#(CUPCM1_NewSample>>$08),($A00000+CU_Stack+1).l	; MJ: ''
		move.b	#%11001001,($A00000+CUPCM1_RET).l		; MJ: change "NOP" to "RET"
		lea	(StopSample).l,a0				; MJ: load stop sample address
		lea	($A00000+PCM2_Sample).l,a1			; MJ: load PCM 2 slot address
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	(a0)+,(a1)+					; MJ: ''
		move.b	#%00101000,($A00000+CUPCM2_RET).l		; MJ: change "JR NZ" to "JR Z"
		StartZ80



		cmpi.b	#$88,d7		; is "extra life" music	played?
		bne.s	loc_72024	; if not, branch
		tst.b	$27(a6)
		bne.w	loc_721B6
		lea	$40(a6),a5
		moveq	#10,d0					; MJ: number of channels in total

loc_71FE6:
		bclr	#2,(a5)
		adda.w	#$30,a5
		dbf	d0,loc_71FE6

		lea	$250(a6),a5				; MJ: new SFX location
		moveq	#5,d0

loc_71FF8:
		bclr	#7,(a5)
		adda.w	#$30,a5
		dbf	d0,loc_71FF8
		clr.b	0(a6)
		movea.l	a6,a0
		lea	$3D0(a6),a1				; MJ: new SFX location
		move.w	#$87,d0

loc_72012:
		move.l	(a0)+,(a1)+
		dbf	d0,loc_72012

		move.b	#$80,$27(a6)
		clr.b	0(a6)
		bra.s	loc_7202C
; ===========================================================================

loc_72024:
		clr.b	$27(a6)
		clr.b	$26(a6)

loc_7202C:
		jsr	sub_725CA(pc)
		movea.l	(off_719A0).l,a4
		subi.b	#$81,d7
		move.b	(a4,d7.w),$29(a6)
		movea.l	(Go_MusicIndex).l,a4
		lsl.w	#2,d7
		movea.l	(a4,d7.w),a4
		moveq	#0,d0
		move.w	(a4),d0
		add.l	a4,d0
		move.l	d0,$18(a6)
		move.b	5(a4),d0
		move.b	d0,$28(a6)
		tst.b	$2A(a6)
		beq.s	loc_72068
		move.b	$29(a6),d0

loc_72068:
		move.b	d0,2(a6)
		move.b	d0,1(a6)
		moveq	#0,d1
		movea.l	a4,a3
		addq.w	#6,a4
		moveq	#0,d7
		move.b	2(a3),d7
		beq.w	loc_72114
		subq.b	#1,d7
		move.b	#-$40,d1
		move.b	4(a3),d4
		moveq	#$30,d6
		move.b	#1,d5
		lea	$40(a6),a1
		lea	byte_721BA(pc),a2

loc_72098:
		bset	#7,(a1)
		move.b	(a2)+,1(a1)
		move.b	d4,2(a1)
		move.b	d6,$D(a1)
		move.b	d1,$A(a1)
		move.b	d5,$E(a1)
		moveq	#0,d0
		move.w	d0,$10(a1)				; MJ: clear FM's frequency (ensures no frequency writing)
		move.w	(a4)+,d0
		add.l	a3,d0
		move.l	d0,4(a1)
		move.w	(a4)+,8(a1)
		adda.w	d6,a1
		dbf	d7,loc_72098
		moveq	#$2B,d0					; MJ: set YM2612 address to DAC/FM6 switch
		move.b	#%10000000,d1				; MJ: set to turn DAC on
		cmpi.b	#8,2(a3)				; MJ: changed to 8 (8 = 6FM channels, no DAC)
		bne.s	loc_720D8
	;	moveq	#$2B,d0					; MJ: removed...
		moveq	#0,d1
		jsr	sub_7272E(pc)
		bra.w	loc_72114
; ===========================================================================

loc_720D8:
		jsr	sub_7272E(pc)				; MJ: added... (turn DAC on)
		moveq	#$28,d0
		moveq	#6,d1
		jsr	sub_7272E(pc)
		move.b	#$42,d0
		moveq	#$7F,d1
		jsr	sub_72764(pc)
		move.b	#$4A,d0
		moveq	#$7F,d1
		jsr	sub_72764(pc)
		move.b	#$46,d0
		moveq	#$7F,d1
		jsr	sub_72764(pc)
		move.b	#$4E,d0
		moveq	#$7F,d1
		jsr	sub_72764(pc)
		move.b	#-$4A,d0
		move.b	#-$40,d1
		jsr	sub_72764(pc)

loc_72114:
		moveq	#$02,d5					; EXT: set PSG to delay for 1 extra frame (This is to match the PSG with the FM/DAC which is delayed a frame by the Z80)
		moveq	#0,d7
		move.b	3(a3),d7
		beq.s	loc_72154
		subq.b	#1,d7
		lea	$1C0(a6),a1				; MJ: new BGM/SFX location
		lea	byte_721C2(pc),a2

loc_72126:
		bset	#7,(a1)
		move.b	(a2)+,1(a1)
		move.b	d4,2(a1)
		move.b	d6,$D(a1)
		move.b	d5,$E(a1)
		move.w	#$FFFF,$10(a1)				; MJ: clear PSG's frequency (ensures no frequency writing)
		move.b	#$01,$12(a1)				; MJ: set key release rate to 1
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a3,d0
		move.l	d0,4(a1)
		move.w	(a4)+,8(a1)
		move.b	(a4)+,d0
		move.b	(a4)+,$B(a1)
		adda.w	d6,a1
		dbf	d7,loc_72126

loc_72154:
		lea	$250(a6),a1				; MJ: new SFX location
		moveq	#5,d7

loc_7215A:
		tst.b	(a1)
		bpl.w	loc_7217C
		moveq	#0,d0
		move.b	1(a1),d0
		bmi.s	loc_7216E
		subq.b	#2,d0
		lsl.b	#2,d0
		bra.s	loc_72170
; ===========================================================================

loc_7216E:
		lsr.b	#3,d0

loc_72170:
		lea	dword_722CC(pc),a0
		movea.l	(a0,d0.w),a0
		bset	#2,(a0)

loc_7217C:
		adda.w	d6,a1
		dbf	d7,loc_7215A

		tst.w	$370(a6)				; MJ: new SFX location
		bpl.s	loc_7218E
		bset	#2,$130(a6)				; MJ: new BGM location

loc_7218E:
		tst.w	$3A0(a6)				; MJ: new SFX location
		bpl.s	loc_7219A
		bset	#2,$220(a6)				; MJ: new BGM location


loc_7219A:
		lea	$A0(a6),a5				; MJ: new FM location
		moveq	#5,d4

loc_721A0:
		jsr	sub_726FE(pc)
		adda.w	d6,a5
		dbf	d4,loc_721A0
		moveq	#2,d4

loc_721AC:
		jsr	sub_729A0(pc)
		adda.w	d6,a5
		dbf	d4,loc_721AC

loc_721B6:
		addq.w	#4,sp
		rts	
; ===========================================================================
byte_721BA:	dc.b 6,	6, 0, 1, 2, 4, 5, 6, 0			; MJ: extra 6 (for PCM 2)
		even
byte_721C2:	dc.b $80, $A0, $C0, 0
		even
; ===========================================================================
; ---------------------------------------------------------------------------
; Play normal sound effect
; ---------------------------------------------------------------------------

Sound_A0toCF:				; XREF: Sound_ChkValue
		tst.b	$27(a6)
		bne.w	loc_722C6
		tst.b	4(a6)
		bne.w	loc_722C6
		tst.b	$24(a6)
		bne.w	loc_722C6
		cmpi.b	#$B5,d7		; is ring sound	effect played?
		bne.s	Sound_notB5	; if not, branch
		tst.b	$2B(a6)
		bne.s	loc_721EE
		move.b	#$CE,d7		; play ring sound in left speaker

loc_721EE:
		bchg	#0,$2B(a6)	; change speaker

Sound_notB5:
		cmpi.b	#$A7,d7		; is "pushing" sound played?
		bne.s	Sound_notA7	; if not, branch
		tst.b	$2C(a6)
		bne.w	locret_722C4
		move.b	#$80,$2C(a6)

Sound_notA7:
		movea.l	(Go_SoundIndex).l,a0
		subi.b	#$A0,d7
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d1
		move.w	(a1)+,d1
		add.l	a3,d1
		move.b	(a1)+,d5
		move.b	(a1)+,d7
		subq.b	#1,d7
		moveq	#$30,d6

loc_72228:
		moveq	#0,d3
		move.b	1(a1),d3
		moveq	#$02,d2					; EXT: set PSG to delay for 1 extra frame (This is to match the PSG with the FM/DAC which is delayed a frame by the Z80)
		move.b	d3,d4
		bmi.s	loc_72244
		move.b	#$01,d2					; EXT: set DAC/FM to delay for 0 frames like normal (these have an auto delay of 1 frame in the Z80)
		subq.w	#2,d3
		lsl.w	#2,d3
		lea	dword_722CC(pc),a5
		movea.l	(a5,d3.w),a5
		bset	#2,(a5)
		bra.s	loc_7226E
; ===========================================================================

loc_72244:
		lsr.w	#3,d3
		lea	dword_722CC(pc),a5
		movea.l	(a5,d3.w),a5
		bset	#2,(a5)
		cmpi.b	#$C0,d4
		bne.s	loc_7226E
		move.b	d4,d0
		ori.b	#$1F,d0
		move.b	d0,($C00011).l
		bchg	#5,d0
		move.b	d0,($C00011).l

loc_7226E:
		movea.l	dword_722EC(pc,d3.w),a5
		movea.l	a5,a2
		moveq	#$B,d0

loc_72276:
		clr.l	(a2)+
		dbf	d0,loc_72276

		move.w	(a1)+,(a5)
		move.b	d5,2(a5)
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,4(a5)
		move.w	(a1)+,8(a5)
		move.b	d2,$E(a5)				; EXT: moving d2 contents (1 for FM/4 for PSG)
		move.b	d6,$D(a5)
		tst.b	d4
		bmi.s	loc_722A8
		move.b	#$C0,$A(a5)
		move.l	d1,$20(a5)

loc_722A8:
		dbf	d7,loc_72228

		tst.b	$280(a6)				; MJ: new SFX location
		bpl.s	loc_722B8
		bset	#2,$370(a6)				; MJ: new SFX location

loc_722B8:
		tst.b	$340(a6)				; MJ: new SFX location
		bpl.s	locret_722C4
		bset	#2,$3A0(a6)				; MJ: new SFX location

locret_722C4:
		rts	
; ===========================================================================

loc_722C6:
		clr.b	0(a6)
		rts	
; ===========================================================================
dword_722CC:	dc.l $FFF0D0+$30				; MJ: new locations (see all +$30)
		dc.l 0
		dc.l $FFF100+$30
		dc.l $FFF130+$30
		dc.l $FFF190+$30
		dc.l $FFF1C0+$30
		dc.l $FFF1F0+$30
		dc.l $FFF1F0+$30
dword_722EC:	dc.l $FFF220+$30
		dc.l 0
		dc.l $FFF250+$30
		dc.l $FFF280+$30
		dc.l $FFF2B0+$30
		dc.l $FFF2E0+$30
		dc.l $FFF310+$30
		dc.l $FFF310+$30
; ===========================================================================
; ---------------------------------------------------------------------------
; Play GHZ waterfall sound
; ---------------------------------------------------------------------------

Sound_D0toDF:				; XREF: Sound_ChkValue
		tst.b	$27(a6)
		bne.w	locret_723C6
		tst.b	4(a6)
		bne.w	locret_723C6
		tst.b	$24(a6)
		bne.w	locret_723C6
		movea.l	(Go_SoundD0).l,a0
		subi.b	#$D0,d7
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,$20(a6)
		move.b	(a1)+,d5
		move.b	(a1)+,d7
		subq.b	#1,d7
		moveq	#$30,d6

loc_72348:
		move.b	1(a1),d4
		bmi.s	loc_7235A
		bset	#2,$130(a6)				; MJ: new BGM location
		lea	$370(a6),a5				; MJ: new SFX location
		bra.s	loc_72364
; ===========================================================================

loc_7235A:
		bset	#2,$220(a6)				; MJ: new BGM location
		lea	$3A0(a6),a5				; MJ: new SFX location

loc_72364:
		movea.l	a5,a2
		moveq	#$B,d0

loc_72368:
		clr.l	(a2)+
		dbf	d0,loc_72368

		move.w	(a1)+,(a5)
		move.b	d5,2(a5)
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,4(a5)
		move.w	(a1)+,8(a5)
		move.b	#1,$E(a5)
		move.b	d6,$D(a5)
		tst.b	d4
		bmi.s	loc_72396
		move.b	#$C0,$A(a5)

loc_72396:
		dbf	d7,loc_72348

		tst.b	$280(a6)				; MJ: new SFX location
		bpl.s	loc_723A6
		bset	#2,$370(a6)				; MJ: new SFX location

loc_723A6:
		tst.b	$340(a6)				; MJ: new SFX location
		bpl.s	locret_723C6
		bset	#2,$3A0(a6)				; MJ: new SFX location
		ori.b	#$1F,d4
		move.b	d4,($C00011).l
		bchg	#5,d4
		move.b	d4,($C00011).l

locret_723C6:
		rts	
; End of function Sound_ChkValue

; ===========================================================================
		dc.l $FFF100+$30				; MJ: new channel locations (see +$30)
		dc.l $FFF1F0+$30
		dc.l $FFF250+$30
		dc.l $FFF310+$30
		dc.l $FFF340+$30
		dc.l $FFF370+$30

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Snd_FadeOut1:				; XREF: Sound_E0
		clr.b	0(a6)
		lea	$250(a6),a5				; MJ: new SFX location
		moveq	#5,d7

loc_723EA:
		tst.b	(a5)
		bpl.w	loc_72472
		bclr	#7,(a5)
		moveq	#0,d3
		move.b	1(a5),d3
		bmi.s	loc_7243C
		jsr	sub_726FE(pc)
		cmpi.b	#4,d3
		bne.s	loc_72416
		tst.b	$370(a6)				; MJ: new SFX location
		bpl.s	loc_72416
		lea	$370(a6),a5				; MJ: new SFX location
		movea.l	$20(a6),a1
		bra.s	loc_72428
; ===========================================================================

loc_72416:
		subq.b	#2,d3
		lsl.b	#2,d3
		lea	dword_722CC(pc),a0
		movea.l	a5,a3
		movea.l	(a0,d3.w),a5
		movea.l	$18(a6),a1

loc_72428:
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		jsr	sub_72C4E(pc)
		movea.l	a3,a5
		bra.s	loc_72472
; ===========================================================================

loc_7243C:
		jsr	sub_729A0(pc)
		lea	$3A0(a6),a0				; MJ: new SFX location
		cmpi.b	#$E0,d3
		beq.s	loc_7245A
		cmpi.b	#$C0,d3
		beq.s	loc_7245A
		lsr.b	#3,d3
		lea	dword_722CC(pc),a0
		movea.l	(a0,d3.w),a0

loc_7245A:
		bclr	#2,(a0)
		bset	#1,(a0)
		cmpi.b	#$E0,1(a0)
		bne.s	loc_72472
		move.b	$1F(a0),($C00011).l

loc_72472:
		adda.w	#$30,a5
		dbf	d7,loc_723EA

		rts	
; End of function Snd_FadeOut1


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Snd_FadeOut2:				; XREF: Sound_E0
		lea	$370(a6),a5				; MJ: new SFX location
		tst.b	(a5)
		bpl.s	loc_724AE
		bclr	#7,(a5)
		btst	#2,(a5)
		bne.s	loc_724AE
		jsr	loc_7270A(pc)
		lea	$130(a6),a5				; MJ: new BGM location
		bclr	#2,(a5)
		bset	#1,(a5)
		tst.b	(a5)
		bpl.s	loc_724AE
		movea.l	$18(a6),a1
		move.b	$B(a5),d0
		jsr	sub_72C4E(pc)

loc_724AE:
		lea	$3A0(a6),a5				; MJ: new SFX location
		tst.b	(a5)
		bpl.s	locret_724E4
		bclr	#7,(a5)
		btst	#2,(a5)
		bne.s	locret_724E4
		jsr	loc_729A6(pc)
		lea	$220(a6),a5				; MJ: new BGM location
		bclr	#2,(a5)
		bset	#1,(a5)
		tst.b	(a5)
		bpl.s	locret_724E4
		cmpi.b	#-$20,1(a5)
		bne.s	locret_724E4
		move.b	$1F(a5),($C00011).l

locret_724E4:
		rts	
; End of function Snd_FadeOut2

; ===========================================================================
; ---------------------------------------------------------------------------
; Fade out music
; ---------------------------------------------------------------------------
FadeOutMusic:
Sound_E0:				; XREF: Sound_ExIndex
		jsr	Snd_FadeOut1(pc)
		jsr	Snd_FadeOut2(pc)
		move.b	#3,6(a6)
		move.b	#$28,4(a6)
		clr.b	$40(a6)
		clr.b	$70(a6)					; MJ: stop PCM 2 as well
		clr.b	$2A(a6)
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72504:				; XREF: sub_71B4C
		move.b	6(a6),d0
		beq.s	loc_72510
		subq.b	#1,6(a6)
		rts	
; ===========================================================================

loc_72510:
		subq.b	#1,4(a6)
		beq.w	Sound_E4
		move.b	#3,6(a6)
		lea	$A0(a6),a5				; MJ: new FM location
		moveq	#5,d7

loc_72524:
		tst.b	(a5)
		bpl.s	loc_72538
		addq.b	#1,9(a5)
		bpl.s	loc_72534
		bclr	#7,(a5)
		bra.s	loc_72538
; ===========================================================================

loc_72534:
		jsr	sub_72CB4(pc)

loc_72538:
		adda.w	#$30,a5
		dbf	d7,loc_72524

		moveq	#2,d7

loc_72542:
		tst.b	(a5)
		bpl.s	loc_72560
		addq.b	#1,9(a5)
		cmpi.b	#$10,9(a5)
		bcs.s	loc_72558
		bclr	#7,(a5)
		bra.s	loc_72560
; ===========================================================================

loc_72558:
		move.b	9(a5),d6
		jsr	sub_7296A(pc)

loc_72560:
		adda.w	#$30,a5
		dbf	d7,loc_72542

		rts	
; End of function sub_72504


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_7256A:				; XREF: Sound_E4; sub_725CA
		moveq	#2,d3
		moveq	#$28,d0

loc_7256E:
		move.b	d3,d1
		jsr	sub_7272E(pc)
		addq.b	#4,d1
		jsr	sub_7272E(pc)
		dbf	d3,loc_7256E

		moveq	#$40,d0
		moveq	#$7F,d1
		moveq	#2,d4

loc_72584:
		moveq	#3,d3

loc_72586:
		jsr	sub_7272E(pc)
		jsr	sub_72764(pc)
		addq.w	#4,d0
		dbf	d3,loc_72586

		subi.b	#$F,d0
		dbf	d4,loc_72584

		rts	
; End of function sub_7256A

; ===========================================================================
; ---------------------------------------------------------------------------
; Stop music
; ---------------------------------------------------------------------------

Sound_E4:
		StopZ80
		lea	(StopSample).l,a0				; EXT: load stop sample address
		lea	($A00000+PCM1_Sample).l,a1			; EXT: load PCM 1 slot address
		move.b	(a0)+,(a1)+					; EXT: set address of sample
		move.b	(a0)+,(a1)+					; EXT: ''
		move.b	(a0)+,(a1)+					; EXT: ''
		move.b	#(CUPCM1_NewSample&$FF),($A00000+CU_Stack).l	; EXT: set routine to run
		move.b	#(CUPCM1_NewSample>>$08),($A00000+CU_Stack+1).l	; EXT: ''
		move.b	#%11001001,($A00000+CUPCM1_RET).l		; EXT: change "NOP" to "RET"
		lea	(StopSample).l,a0				; EXT: load stop sample address
		lea	($A00000+PCM2_Sample).l,a1			; EXT: load PCM 2 slot address
		move.b	(a0)+,(a1)+					; EXT: ''
		move.b	(a0)+,(a1)+					; EXT: ''
		move.b	(a0)+,(a1)+					; EXT: ''
		move.b	#%00101000,($A00000+CUPCM2_RET).l		; EXT: change "JR NZ" to "JR Z"
		StartZ80

		moveq	#$2B,d0
		move.b	#$80,d1
		jsr	sub_7272E(pc)
		moveq	#$27,d0
		moveq	#0,d1
		jsr	sub_7272E(pc)
		movea.l	a6,a0
		move.l	$10(a6),d6					; EXT: store YM Cue list pointer
		move.w	#$EF,d0						; MJ: new size of data to clear

loc_725B6:
		clr.l	(a0)+
		dbf	d0,loc_725B6

		move.l	d6,$10(a6)					; EXT: restore YM Cue list pointer
		move.b	#$80,9(a6)	; set music to $80 (silence)
		jsr	sub_7256A(pc)
		bra.w	sub_729B6

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_725CA:				; XREF: Sound_ChkValue
		movea.l	a6,a0
		move.b	0(a6),d1
		move.b	$27(a6),d2
		move.b	$2A(a6),d3
		move.b	$26(a6),d4
		move.w	$A(a6),d5
		move.l	$10(a6),d6					; EXT: store YM Cue list pointer
		move.w	#$93,d0						; MJ: new size

loc_725E4:
		clr.l	(a0)+
		dbf	d0,loc_725E4

		move.b	d1,0(a6)
		move.b	d2,$27(a6)
		move.b	d3,$2A(a6)
		move.b	d4,$26(a6)
		move.w	d5,$A(a6)
		move.l	d6,$10(a6)					; EXT: restore YM Cue list pointer
		move.b	#$80,9(a6)
		jsr	sub_7256A(pc)
		bra.w	sub_729B6
; End of function sub_725CA


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_7260C:				; XREF: sub_71B4C
		move.b	2(a6),1(a6)
		lea	$4E(a6),a0
		moveq	#$30,d0
		moveq	#10,d1				; MJ: new number of channels

loc_7261A:
		addq.b	#1,(a0)
		adda.w	d0,a0
		dbf	d1,loc_7261A

		rts	
; End of function sub_7260C

; ===========================================================================
; ---------------------------------------------------------------------------
; Speed	up music
; ---------------------------------------------------------------------------

Sound_E2:				; XREF: Sound_ExIndex
		tst.b	$27(a6)
		bne.s	loc_7263E
		move.b	$29(a6),2(a6)
		move.b	$29(a6),1(a6)
		move.b	#$80,$2A(a6)
		rts	
; ===========================================================================

loc_7263E:
		move.b	$3F9(a6),$3D2(a6)			; MJ: new location
		move.b	$3F9(a6),$3D1(a6)			; MJ: new location
		move.b	#$80,$3FA(a6)
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Change music back to normal speed
; ---------------------------------------------------------------------------

Sound_E3:				; XREF: Sound_ExIndex
		tst.b	$27(a6)
		bne.s	loc_7266A
		move.b	$28(a6),2(a6)
		move.b	$28(a6),1(a6)
		clr.b	$2A(a6)
		rts	
; ===========================================================================

loc_7266A:
		move.b	$3F8(a6),$3D2(a6)
		move.b	$3F8(a6),$3D1(a6)
		clr.b	$3FA(a6)
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_7267C:				; XREF: sub_71B4C
		tst.b	$25(a6)
		beq.s	loc_72688
		subq.b	#1,$25(a6)
		rts	
; ===========================================================================

loc_72688:
		tst.b	$26(a6)
		beq.s	loc_726D6
		subq.b	#1,$26(a6)
		move.b	#2,$25(a6)
		lea	$A0(a6),a5				; MJ: new SFX location
		moveq	#5,d7

loc_7269E:
		tst.b	(a5)
		bpl.s	loc_726AA
		subq.b	#1,9(a5)
		jsr	sub_72CB4(pc)

loc_726AA:
		adda.w	#$30,a5
		dbf	d7,loc_7269E
		moveq	#2,d7

loc_726B4:
		tst.b	(a5)
		bpl.s	loc_726CC
		subq.b	#1,9(a5)
		move.b	9(a5),d6
		cmpi.b	#$10,d6
		bcs.s	loc_726C8
		moveq	#$F,d6

loc_726C8:
		jsr	sub_7296A(pc)

loc_726CC:
		adda.w	#$30,a5
		dbf	d7,loc_726B4
		rts	
; ===========================================================================

loc_726D6:
		bclr	#2,$40(a6)
		bclr	#2,$70(a6)				; MJ: do PCM 2 as well...
		clr.b	$24(a6)
		rts	
; End of function sub_7267C

; ===========================================================================

loc_726E2:				; XREF: sub_71CCA
		btst	#1,(a5)
		bne.s	locret_726FC
		btst	#2,(a5)
		bne.s	locret_726FC
		moveq	#$28,d0
		move.b	1(a5),d1
		ori.b	#-$10,d1
		bra.w	sub_7272E
; ===========================================================================

locret_726FC:
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_726FE:				; XREF: sub_71CEC; sub_71D9E; Sound_ChkValue; Snd_FadeOut1
		btst	#4,(a5)
		bne.s	locret_72714
		btst	#2,(a5)
		bne.s	locret_72714

loc_7270A:				; XREF: Snd_FadeOut2
		moveq	#$28,d0
		move.b	1(a5),d1
		bra.w	sub_7272E
; ===========================================================================

locret_72714:
		rts	
; End of function sub_726FE

; ===========================================================================

loc_72716:				; XREF: sub_72A5A
		btst	#2,(a5)
		bne.s	locret_72720
		bra.w	sub_72722
; ===========================================================================

locret_72720:
		rts

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72722:				; XREF: sub_71E18; sub_72C4E; sub_72CB4
		btst	#2,1(a5)
		bne.s	loc_7275A
		add.b	1(a5),d0
; End of function sub_72722


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

sub_7272E:
		movem.l	d2/a0,-(sp)				; EXT: store register data
		movea.l	$10(a6),a0				; EXT: load Cue pointer
		addq.w	#$01,a0					; EXT: skip $40
		move.b	#$00,d2					; EXT: prepare d2 for YM2612 port address ($4000 - $4001)
		StopZ80						; EXT: request Z80 stop "ON"
		move.b	d2,(a0)+				; EXT: write YM2612 port address
		move.b	d1,(a0)+				; EXT: write YM2612 data
		move.b	d0,(a0)+				; EXT: write YM2612 address
		StartZ80					; EXT: request Z80 stop "OFF"
		move.w	a0,d2					; EXT: load Cue pointer
		andi.w	#$0FFF,d2				; EXT: wrap it
		ori.w	#$1000,d2				; EXT: ''
		move.w	d2,$12(a6)				; EXT: update it
		movem.l	(sp)+,d2/a0				; EXT: restore register data
		rts						; EXT: return

; ===========================================================================

loc_7275A:				; XREF: sub_72722
		move.b	1(a5),d2
		bclr	#2,d2
		add.b	d2,d0

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72764:
		movem.l	d2/a0,-(sp)				; EXT: store register data
		movea.l	$10(a6),a0				; EXT: load Cue pointer
		addq.w	#$01,a0					; EXT: skip $40
		move.b	#$02,d2					; EXT: prepare d2 for YM2612 port address ($4002 - $4003)
		StopZ80						; EXT: request Z80 stop "ON"
		move.b	d2,(a0)+				; EXT: write YM2612 port address
		move.b	d1,(a0)+				; EXT: write YM2612 data
		move.b	d0,(a0)+				; EXT: write YM2612 address
		StartZ80					; EXT: request Z80 stop "OFF"
		move.w	a0,d2					; EXT: load Cue pointer
		andi.w	#$0FFF,d2				; EXT: wrap it
		ori.w	#$1000,d2				; EXT: ''
		move.w	d2,$12(a6)				; EXT: update it
		movem.l	(sp)+,d2/a0				; EXT: restore register data
		rts						; EXT: return

; ===========================================================================
word_72790:	dc.w $25E, $284, $2AB, $2D3, $2FE, $32D, $35C, $38F, $3C5
		dc.w $3FF, $43C, $47C, $A5E, $A84, $AAB, $AD3, $AFE, $B2D
		dc.w $B5C, $B8F, $BC5, $BFF, $C3C, $C7C, $125E,	$1284
		dc.w $12AB, $12D3, $12FE, $132D, $135C,	$138F, $13C5, $13FF
		dc.w $143C, $147C, $1A5E, $1A84, $1AAB,	$1AD3, $1AFE, $1B2D
		dc.w $1B5C, $1B8F, $1BC5, $1BFF, $1C3C,	$1C7C, $225E, $2284
		dc.w $22AB, $22D3, $22FE, $232D, $235C,	$238F, $23C5, $23FF
		dc.w $243C, $247C, $2A5E, $2A84, $2AAB,	$2AD3, $2AFE, $2B2D
		dc.w $2B5C, $2B8F, $2BC5, $2BFF, $2C3C,	$2C7C, $325E, $3284
		dc.w $32AB, $32D3, $32FE, $332D, $335C,	$338F, $33C5, $33FF
		dc.w $343C, $347C, $3A5E, $3A84, $3AAB,	$3AD3, $3AFE, $3B2D
		dc.w $3B5C, $3B8F, $3BC5, $3BFF, $3C3C,	$3C7C

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72850:				; XREF: sub_71B4C
		subq.b	#1,$E(a5)
		bne.s	loc_72866
		bclr	#4,(a5)
		jsr	sub_72878(pc)
		jsr	sub_728DC(pc)
		bra.w	loc_7292E
; ===========================================================================

loc_72866:
		jsr	sub_71D9E(pc)
		jsr	sub_72926(pc)
		jsr	sub_71DC6(pc)
		jsr	sub_728E2(pc)
		rts	
; End of function sub_72850


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72878:				; XREF: sub_72850
		bclr	#1,(a5)
		movea.l	4(a5),a4

loc_72880:
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_72890
		jsr	sub_72A5A(pc)
		bra.s	loc_72880
; ===========================================================================

loc_72890:
		tst.b	d5
		bpl.s	loc_728A4
		jsr	sub_728AC(pc)
		move.b	(a4)+,d5
		tst.b	d5
		bpl.s	loc_728A4
		subq.w	#1,a4
		bra.w	sub_71D60
; ===========================================================================

loc_728A4:
		jsr	sub_71D40(pc)
		bra.w	sub_71D60
; End of function sub_72878


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_728AC:				; XREF: sub_72878
		subi.b	#$81,d5
		bcs.s	loc_728CA
		add.b	8(a5),d5
		andi.w	#$7F,d5
		lsl.w	#1,d5
		lea	word_729CE(pc),a0
		move.w	(a0,d5.w),$10(a5)
		bra.w	sub_71D60
; ===========================================================================

loc_728CA:
		bset	#1,(a5)
		move.w	#-1,$10(a5)
		jsr	sub_71D60(pc)
		bra.w	sub_729A0
; End of function sub_728AC


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_728DC:				; XREF: sub_72850
		move.w	$10(a5),d6
		bmi.s	loc_72920
; End of function sub_728DC


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_728E2:				; XREF: sub_72850
		move.b	$1E(a5),d0
		ext.w	d0
		add.w	d0,d6
		btst	#2,(a5)
		bne.s	locret_7291E
		btst	#1,(a5)
		bne.s	locret_7291E
		move.b	1(a5),d0
		cmpi.b	#$E0,d0
		bne.s	loc_72904
		move.b	#$C0,d0

loc_72904:
		move.w	d6,d1
		andi.b	#$F,d1
		or.b	d1,d0
		lsr.w	#4,d6
		andi.b	#$3F,d6
		move.b	d0,($C00011).l
		move.b	d6,($C00011).l

locret_7291E:
		rts	
; End of function sub_728E2

; ===========================================================================

loc_72920:				; XREF: sub_728DC
		bset	#1,(a5)
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72926:				; XREF: sub_72850
		tst.b	$B(a5)
		beq.w	locret_7298A

loc_7292E:				; XREF: sub_72850
		move.b	9(a5),d6
		moveq	#0,d0
		move.b	$B(a5),d0
		beq.s	sub_7296A
		movea.l	(Go_PSGIndex).l,a0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a0,d0.w),a0
		move.b	$C(a5),d0
		move.b	(a0,d0.w),d0
		addq.b	#1,$C(a5)
		btst	#7,d0
		beq.s	loc_72960
		cmpi.b	#$80,d0
		beq.s	loc_7299A

loc_72960:
		add.w	d0,d6
		cmpi.b	#$10,d6
		bcs.s	sub_7296A
		moveq	#$F,d6
; End of function sub_72926


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_7296A:				; XREF: sub_72504; sub_7267C; sub_72926
		btst	#1,(a5)
		bne.s	locret_7298A
		btst	#2,(a5)
		bne.s	locret_7298A
		btst	#4,(a5)
		bne.s	loc_7298C

loc_7297C:
		or.b	1(a5),d6
		addi.b	#$10,d6
		move.b	d6,($C00011).l

locret_7298A:
		rts	
; ===========================================================================

loc_7298C:
		tst.b	$13(a5)
		beq.s	loc_7297C
		tst.b	$12(a5)
		bne.s	loc_7297C
		rts	
; End of function sub_7296A

; ===========================================================================

loc_7299A:				; XREF: sub_72926
		subq.b	#1,$C(a5)
		rts	

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_729A0:				; XREF: sub_71D9E; Sound_ChkValue; Snd_FadeOut1; sub_728AC
		btst	#2,(a5)
		bne.s	locret_729B4

loc_729A6:				; XREF: Snd_FadeOut2
		move.b	1(a5),d0
		ori.b	#$1F,d0
		move.b	d0,($C00011).l

locret_729B4:
		rts	
; End of function sub_729A0


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_729B6:				; XREF: loc_71E7C
		lea	($C00011).l,a0
		move.b	#$9F,(a0)
		move.b	#$BF,(a0)
		move.b	#$DF,(a0)
		move.b	#$FF,(a0)
		rts	
; End of function sub_729B6

; ===========================================================================
word_729CE:	dc.w $356, $326, $2F9, $2CE, $2A5, $280, $25C, $23A, $21A
		dc.w $1FB, $1DF, $1C4, $1AB, $193, $17D, $167, $153, $140
		dc.w $12E, $11D, $10D, $FE, $EF, $E2, $D6, $C9,	$BE, $B4
		dc.w $A9, $A0, $97, $8F, $87, $7F, $78,	$71, $6B, $65
		dc.w $5F, $5A, $55, $50, $4B, $47, $43,	$40, $3C, $39
		dc.w $36, $33, $30, $2D, $2B, $28, $26,	$24, $22, $20
		dc.w $1F, $1D, $1B, $1A, $18, $17, $16,	$15, $13, $12
		dc.w $11, 0

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72A5A:				; XREF: sub_71C4E; sub_71CEC; sub_72878
		subi.w	#$E0,d5
		lsl.w	#2,d5
		jmp	loc_72A64(pc,d5.w)
; End of function sub_72A5A

; ===========================================================================

loc_72A64:
		bra.w	loc_72ACC
; ===========================================================================
		bra.w	loc_72AEC
; ===========================================================================
		bra.w	loc_72AF2
; ===========================================================================
		bra.w	loc_72AF8
; ===========================================================================
		bra.w	loc_72B14
; ===========================================================================
		bra.w	loc_72B9E
; ===========================================================================
		bra.w	loc_72BA4
; ===========================================================================
		bra.w	loc_72BAE
; ===========================================================================
		bra.w	loc_72BB4
; ===========================================================================
		bra.w	loc_72BBE
; ===========================================================================
		bra.w	loc_72BC6
; ===========================================================================
		bra.w	loc_72BD0
; ===========================================================================
		bra.w	loc_72BE6
; ===========================================================================
		bra.w	loc_72BEE
; ===========================================================================
		bra.w	loc_72BF4
; ===========================================================================
		bra.w	loc_72C26
; ===========================================================================
		bra.w	loc_72D30
; ===========================================================================
		bra.w	loc_72D52
; ===========================================================================
		bra.w	loc_72D58
; ===========================================================================
		bra.w	loc_72E06
; ===========================================================================
		bra.w	loc_72E20
; ===========================================================================
		bra.w	loc_72E26
; ===========================================================================
		bra.w	loc_72E2C
; ===========================================================================
		bra.w	loc_72E38
; ===========================================================================
		bra.w	loc_72E52
; ===========================================================================
		bra.w	loc_72E64
; ===========================================================================

loc_72ACC:				; XREF: loc_72A64
		move.b	(a4)+,d1
		tst.b	1(a5)
		bmi.s	locret_72AEA
		move.b	$A(a5),d0
		andi.b	#$37,d0
		or.b	d0,d1
		move.b	d1,$A(a5)
		move.b	#$B4,d0
		bra.w	loc_72716
; ===========================================================================

locret_72AEA:
		rts	
; ===========================================================================

loc_72AEC:				; XREF: loc_72A64
		move.b	(a4)+,$1E(a5)
		rts	
; ===========================================================================

loc_72AF2:				; XREF: loc_72A64
		move.b	(a4)+,7(a6)
		rts	
; ===========================================================================

loc_72AF8:				; XREF: loc_72A64
		moveq	#0,d0
		move.b	$D(a5),d0
		movea.l	(a5,d0.w),a4
		move.l	#0,(a5,d0.w)
		addq.w	#2,a4
		addq.b	#4,d0
		move.b	d0,$D(a5)
		rts	
; ===========================================================================

loc_72B14:				; XREF: loc_72A64
		movea.l	a6,a0
		lea	$3D0(a6),a1				; MJ: new SFX location
		move.w	#$93,d0					; MJ: new size to store

loc_72B1E:
		move.l	(a1)+,(a0)+
		dbf	d0,loc_72B1E

		bset	#2,$40(a6)
		bset	#2,$70(a6)				; MJ: enable PCM 2
		movea.l	a5,a3
		move.b	#$28,d6
		sub.b	$26(a6),d6
		moveq	#5,d7
		lea	$A0(a6),a5				; MJ: new FM location

loc_72B3A:
		btst	#7,(a5)
		beq.s	loc_72B5C
		bset	#1,(a5)
		add.b	d6,9(a5)
		btst	#2,(a5)
		bne.s	loc_72B5C
		moveq	#0,d0
		move.b	$B(a5),d0
		movea.l	$18(a6),a1
		jsr	sub_72C4E(pc)

loc_72B5C:
		adda.w	#$30,a5
		dbf	d7,loc_72B3A

		moveq	#2,d7

loc_72B66:
		btst	#7,(a5)
		beq.s	loc_72B78
		bset	#1,(a5)
		jsr	sub_729A0(pc)
		add.b	d6,9(a5)

loc_72B78:
		adda.w	#$30,a5
		dbf	d7,loc_72B66
		movea.l	a3,a5
		move.b	#$80,$24(a6)
		move.b	#$28,$26(a6)
		clr.b	$27(a6)
		addq.w	#8,sp
		rts	
; ===========================================================================

loc_72B9E:				; XREF: loc_72A64
		move.b	(a4)+,2(a5)
		rts	
; ===========================================================================

loc_72BA4:				; XREF: loc_72A64
		move.b	(a4)+,d0
		add.b	d0,9(a5)
		bra.w	sub_72CB4
; ===========================================================================

loc_72BAE:				; XREF: loc_72A64
		bset	#4,(a5)
		rts	
; ===========================================================================

loc_72BB4:				; XREF: loc_72A64
		move.b	(a4),$12(a5)
		move.b	(a4)+,$13(a5)
		rts	
; ===========================================================================

loc_72BBE:				; XREF: loc_72A64
		move.b	(a4)+,d0
		add.b	d0,8(a5)
		rts	
; ===========================================================================

loc_72BC6:				; XREF: loc_72A64
		move.b	(a4),2(a6)
		move.b	(a4)+,1(a6)
		rts	
; ===========================================================================

loc_72BD0:				; XREF: loc_72A64
		lea	$40(a6),a0
		move.b	(a4)+,d0
		moveq	#$30,d1
		moveq	#10,d2				; MJ: extra channel

loc_72BDA:
		move.b	d0,2(a0)
		adda.w	d1,a0
		dbf	d2,loc_72BDA

		rts	
; ===========================================================================

loc_72BE6:				; XREF: loc_72A64
		move.b	(a4)+,d0
		add.b	d0,9(a5)
		rts	
; ===========================================================================

loc_72BEE:				; XREF: loc_72A64
		clr.b	$2C(a6)
		rts	
; ===========================================================================

loc_72BF4:				; XREF: loc_72A64
		bclr	#7,(a5)
		bclr	#4,(a5)
		jsr	sub_726FE(pc)
		tst.b	$280(a6)				; MJ: new SFX location
		bmi.s	loc_72C22
		movea.l	a5,a3
		lea	$130(a6),a5				; MJ: new BGM location
		movea.l	$18(a6),a1
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		jsr	sub_72C4E(pc)
		movea.l	a3,a5

loc_72C22:
		addq.w	#8,sp
		rts	
; ===========================================================================

loc_72C26:				; XREF: loc_72A64
		moveq	#0,d0
		move.b	(a4)+,d0
		move.b	d0,$B(a5)
		btst	#2,(a5)
		bne.w	locret_72CAA
		movea.l	$18(a6),a1
		tst.b	$E(a6)
		beq.s	sub_72C4E
		movea.l	$20(a5),a1
		tst.b	$E(a6)
		bmi.s	sub_72C4E
		movea.l	$20(a6),a1

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72C4E:				; XREF: Snd_FadeOut1; et al
		subq.w	#1,d0
		bmi.s	loc_72C5C
		move.w	#$19,d1

loc_72C56:
		adda.w	d1,a1
		dbf	d0,loc_72C56

loc_72C5C:
		move.b	(a1)+,d1
		move.b	d1,$1F(a5)
		move.b	d1,d4
		move.b	#$B0,d0
		jsr	sub_72722(pc)
		lea	byte_72D18(pc),a2
		moveq	#$13,d3

loc_72C72:
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		jsr	sub_72722(pc)
		dbf	d3,loc_72C72
		moveq	#3,d5
		andi.w	#7,d4
		move.b	byte_72CAC(pc,d4.w),d4
		move.b	9(a5),d3

loc_72C8C:
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4
		bcc.s	loc_72C96
		add.b	d3,d1

loc_72C96:
		jsr	sub_72722(pc)
		dbf	d5,loc_72C8C
		move.b	#$B4,d0
		move.b	$A(a5),d1
		jsr	sub_72722(pc)

locret_72CAA:
		rts	
; End of function sub_72C4E

; ===========================================================================
byte_72CAC:	dc.b 8,	8, 8, 8, $A, $E, $E, $F

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_72CB4:				; XREF: sub_72504; sub_7267C; loc_72BA4
		btst	#2,(a5)
		bne.s	locret_72D16
		moveq	#0,d0
		move.b	$B(a5),d0
		movea.l	$18(a6),a1
		tst.b	$E(a6)
		beq.s	loc_72CD8
		movea.l	$20(a6),a1
		tst.b	$E(a6)
		bmi.s	loc_72CD8
		movea.l	$20(a6),a1

loc_72CD8:
		subq.w	#1,d0
		bmi.s	loc_72CE6
		move.w	#$19,d1

loc_72CE0:
		adda.w	d1,a1
		dbf	d0,loc_72CE0

loc_72CE6:
		adda.w	#$15,a1
		lea	byte_72D2C(pc),a2
		move.b	$1F(a5),d0
		andi.w	#7,d0
		move.b	byte_72CAC(pc,d0.w),d4
		move.b	9(a5),d3
		bmi.s	locret_72D16
		moveq	#3,d5

loc_72D02:
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4
		bcc.s	loc_72D12
		add.b	d3,d1
		bcs.s	loc_72D12
		jsr	sub_72722(pc)

loc_72D12:
		dbf	d5,loc_72D02

locret_72D16:
		rts	
; End of function sub_72CB4

; ===========================================================================
byte_72D18:	dc.b $30, $38, $34, $3C, $50, $58, $54,	$5C, $60, $68
		dc.b $64, $6C, $70, $78, $74, $7C, $80,	$88, $84, $8C
byte_72D2C:	dc.b $40, $48, $44, $4C
; ===========================================================================

loc_72D30:				; XREF: loc_72A64
		bset	#3,(a5)
		move.l	a4,$14(a5)
		move.b	(a4)+,$18(a5)
		move.b	(a4)+,$19(a5)
		move.b	(a4)+,$1A(a5)
		move.b	(a4)+,d0
		lsr.b	#1,d0
		move.b	d0,$1B(a5)
		clr.w	$1C(a5)
		rts	
; ===========================================================================

loc_72D52:				; XREF: loc_72A64
		bset	#3,(a5)
		rts	
; ===========================================================================

loc_72D58:				; XREF: loc_72A64
		bclr	#7,(a5)
		bclr	#4,(a5)
		tst.b	1(a5)
		bmi.s	loc_72D74
		tst.b	8(a6)
		bmi.w	loc_72E02
		jsr	sub_726FE(pc)
		bra.s	loc_72D78
; ===========================================================================

loc_72D74:
		jsr	sub_729A0(pc)

loc_72D78:
		tst.b	$E(a6)
		bpl.w	loc_72E02
		clr.b	0(a6)
		moveq	#0,d0
		move.b	1(a5),d0
		bmi.s	loc_72DCC
		lea	dword_722CC(pc),a0
		movea.l	a5,a3
		cmpi.b	#4,d0
		bne.s	loc_72DA8
		tst.b	$370(a6)				; MJ: new SFX location
		bpl.s	loc_72DA8
		lea	$370(a6),a5				; MJ: new SFX location
		movea.l	$20(a6),a1
		bra.s	loc_72DB8
; ===========================================================================

loc_72DA8:
		subq.b	#2,d0
		lsl.b	#2,d0
		movea.l	(a0,d0.w),a5
		tst.b	(a5)
		bpl.s	loc_72DC8
		movea.l	$18(a6),a1

loc_72DB8:
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		jsr	sub_72C4E(pc)

loc_72DC8:
		movea.l	a3,a5
		bra.s	loc_72E02
; ===========================================================================

loc_72DCC:
		lea	$3A0(a6),a0				; MJ: new SFX location
		tst.b	(a0)
		bpl.s	loc_72DE0
		cmpi.b	#$E0,d0
		beq.s	loc_72DEA
		cmpi.b	#$C0,d0
		beq.s	loc_72DEA

loc_72DE0:
		lea	dword_722CC(pc),a0
		lsr.b	#3,d0
		movea.l	(a0,d0.w),a0

loc_72DEA:
		bclr	#2,(a0)
		bset	#1,(a0)
		cmpi.b	#$E0,1(a0)
		bne.s	loc_72E02
		move.b	$1F(a0),($C00011).l

loc_72E02:
		addq.w	#4,sp					; MJ: changed to 4 (go back, but not out of sound driver)
		tst.b	$08(a6)					; MJ: is this a PCM channel?
		bne.s	FlagF2_NoWaitFrame			; MJ: if so, branch
		addq.w	#4,sp					; MJ: go back outside the sound driver like normal

FlagF2_NoWaitFrame:
		rts	
; ===========================================================================

loc_72E06:				; XREF: loc_72A64
		move.b	#$E0,1(a5)
		move.b	(a4)+,$1F(a5)
		btst	#2,(a5)
		bne.s	locret_72E1E 
		move.b	-1(a4),d0				; MJ: reload F3 setting to d0
		move.b	d0,($C00011).l				; MJ: save F3 setting (should be EX (PSG 4) related)
		andi.b	#%00000011,d0				; MJ: get only frequency mode bits
		cmpi.b	#%00000011,d0				; MJ: has it been set to use PSG 3's frequency?
		bne.s	locret_72E1E				; MJ: if not, branch
		move.b	#%11011111,($C00011).l			; MJ: mute PSG 3's volume

locret_72E1E:
		rts	
; ===========================================================================

loc_72E20:				; XREF: loc_72A64
		bclr	#3,(a5)
		rts	
; ===========================================================================

loc_72E26:				; XREF: loc_72A64
		move.b	(a4)+,$B(a5)
		rts	
; ===========================================================================

loc_72E2C:				; XREF: loc_72A64
		move.b	(a4)+,d0
		lsl.w	#8,d0
		move.b	(a4)+,d0
		adda.w	d0,a4
		subq.w	#1,a4
		rts	
; ===========================================================================

loc_72E38:				; XREF: loc_72A64
		moveq	#0,d0
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		tst.b	$24(a5,d0.w)
		bne.s	loc_72E48
		move.b	d1,$24(a5,d0.w)

loc_72E48:
		subq.b	#1,$24(a5,d0.w)
		bne.s	loc_72E2C
		addq.w	#2,a4
		rts	
; ===========================================================================

loc_72E52:				; XREF: loc_72A64
		moveq	#0,d0
		move.b	$D(a5),d0
		subq.b	#4,d0
		move.l	a4,(a5,d0.w)
		move.b	d0,$D(a5)
		bra.s	loc_72E2C
; ===========================================================================

loc_72E64:				; XREF: loc_72A64
		move.b	#$88,d0
		move.b	#$F,d1
		jsr	sub_7272E(pc)
		move.b	#$8C,d0
		move.b	#$F,d1
		bra.w	sub_7272E
; ===========================================================================
Z80ROM:		incbin	"Dual PCM\Z80.bin"
Z80ROM_End:	even
Music81:	incbin	sound\music81.bin
		even
Music82:	incbin	sound\music82.bin
		even
Music83:	incbin	sound\music83.bin
		even
Music84:	incbin	sound\music84.bin
		even
Music85:	incbin	sound\music85.bin
		even
Music86:	incbin	sound\music86.bin
		even
Music87:	incbin	sound\music87.bin
		even
Music88:	incbin	sound\music88.bin
		even
Music89:	incbin	sound\music89.bin
		even
Music8A:	incbin	sound\music8A.bin
		even
Music8B:	incbin	sound\music8B.bin
		even
Music8C:	incbin	sound\music8C.bin
		even
Music8D:	incbin	sound\music8D.bin
		even
Music8E:	incbin	sound\music8E.bin
		even
Music8F:	incbin	sound\music8F.bin
		even
Music90:	incbin	sound\music90.bin
		even
Music91:	incbin	sound\music91.bin
		even
Music92:	incbin	sound\music92.bin
		even
Music93:	incbin	sound\music93.bin
		even
; ---------------------------------------------------------------------------
; Sound	effect pointers
; ---------------------------------------------------------------------------
SoundIndex:
ptr_sndA0:	dc.l SoundA0
ptr_sndA1:	dc.l SoundA1
ptr_sndA2:	dc.l SoundA2
ptr_sndA3:	dc.l SoundA3
ptr_sndA4:	dc.l SoundA4
ptr_sndA5:	dc.l SoundA5
ptr_sndA6:	dc.l SoundA6
ptr_sndA7:	dc.l SoundA7
ptr_sndA8:	dc.l SoundA8
ptr_sndA9:	dc.l SoundA9
ptr_sndAA:	dc.l SoundAA
ptr_sndAB:	dc.l SoundAB
ptr_sndAC:	dc.l SoundAC
ptr_sndAD:	dc.l SoundAD
ptr_sndAE:	dc.l SoundAE
ptr_sndAF:	dc.l SoundAF
ptr_sndB0:	dc.l SoundB0
ptr_sndB1:	dc.l SoundB1
ptr_sndB2:	dc.l SoundB2
ptr_sndB3:	dc.l SoundB3
ptr_sndB4:	dc.l SoundB4
ptr_sndB5:	dc.l SoundB5
ptr_sndB6:	dc.l SoundB6
ptr_sndB7:	dc.l SoundB7
ptr_sndB8:	dc.l SoundB8
ptr_sndB9:	dc.l SoundB9
ptr_sndBA:	dc.l SoundBA
ptr_sndBB:	dc.l SoundBB
ptr_sndBC:	dc.l SoundBC
ptr_sndBD:	dc.l SoundBD
ptr_sndBE:	dc.l SoundBE
ptr_sndBF:	dc.l SoundBF
ptr_sndC0:	dc.l SoundC0
ptr_sndC1:	dc.l SoundC1
ptr_sndC2:	dc.l SoundC2
ptr_sndC3:	dc.l SoundC3
ptr_sndC4:	dc.l SoundC4
ptr_sndC5:	dc.l SoundC5
ptr_sndC6:	dc.l SoundC6
ptr_sndC7:	dc.l SoundC7
ptr_sndC8:	dc.l SoundC8
ptr_sndC9:	dc.l SoundC9
ptr_sndCA:	dc.l SoundCA
ptr_sndCB:	dc.l SoundCB
ptr_sndCC:	dc.l SoundCC
ptr_sndCD:	dc.l SoundCD
ptr_sndCE:	dc.l SoundCE
ptr_sndCF:	dc.l SoundCF
ptr_sndend

SpecSoundIndex:
SoundD0Index:	
ptr_sndD0:	dc.l SoundD0
ptr_specend
SoundA0:	incbin	sound\soundA0.bin
		even
SoundA1:	incbin	sound\soundA1.bin
		even
SoundA2:	incbin	sound\soundA2.bin
		even
SoundA3:	incbin	sound\soundA3.bin
		even
SoundA4:	incbin	sound\soundA4.bin
		even
SoundA5:	incbin	sound\soundA5.bin
		even
SoundA6:	incbin	sound\soundA6.bin
		even
SoundA7:	incbin	sound\soundA7.bin
		even
SoundA8:	incbin	sound\soundA8.bin
		even
SoundA9:	incbin	sound\soundA9.bin
		even
SoundAA:	incbin	sound\soundAA.bin
		even
SoundAB:	incbin	sound\soundAB.bin
		even
SoundAC:	incbin	sound\soundAC.bin
		even
SoundAD:	incbin	sound\soundAD.bin
		even
SoundAE:	incbin	sound\soundAE.bin
		even
SoundAF:	incbin	sound\soundAF.bin
		even
SoundB0:	incbin	sound\soundB0.bin
		even
SoundB1:	incbin	sound\soundB1.bin
		even
SoundB2:	incbin	sound\soundB2.bin
		even
SoundB3:	incbin	sound\soundB3.bin
		even
SoundB4:	incbin	sound\soundB4.bin
		even
SoundB5:	incbin	sound\soundB5.bin
		even
SoundB6:	incbin	sound\soundB6.bin
		even
SoundB7:	incbin	sound\soundB7.bin
		even
SoundB8:	incbin	sound\soundB8.bin
		even
SoundB9:	incbin	sound\soundB9.bin
		even
SoundBA:	incbin	sound\soundBA.bin
		even
SoundBB:	incbin	sound\soundBB.bin
		even
SoundBC:	incbin	sound\soundBC.bin
		even
SoundBD:	incbin	sound\soundBD.bin
		even
SoundBE:	incbin	sound\soundBE.bin
		even
SoundBF:	incbin	sound\soundBF.bin
		even
SoundC0:	incbin	sound\soundC0.bin
		even
SoundC1:	incbin	sound\soundC1.bin
		even
SoundC2:	incbin	sound\soundC2.bin
		even
SoundC3:	incbin	sound\soundC3.bin
		even
SoundC4:	incbin	sound\soundC4.bin
		even
SoundC5:	incbin	sound\soundC5.bin
		even
SoundC6:	incbin	sound\soundC6.bin
		even
SoundC7:	incbin	sound\soundC7.bin
		even
SoundC8:	incbin	sound\soundC8.bin
		even
SoundC9:	incbin	sound\soundC9.bin
		even
SoundCA:	incbin	sound\soundCA.bin
		even
SoundCB:	incbin	sound\soundCB.bin
		even
SoundCC:	incbin	sound\soundCC.bin
		even
SoundCD:	incbin	sound\soundCD.bin
		even
SoundCE:	incbin	sound\soundCE.bin
		even
SoundCF:	incbin	sound\soundCF.bin
		even
SoundD0:	incbin	sound\soundD0.bin
		even
SegaPCM:	incbin	sound\segapcm.wav,$3A
SegaPCM_End:	even

; ===========================================================================

