; ===========================================================================
; ---------------------------------------------------------------------------
; Kosinski decompression routine
;
; Created by vladikcomper
; Special thanks to flamewing and MarkeyJester
; ---------------------------------------------------------------------------
 
_Kos_RunBitStream macro
    dbf d2,@skip\@
    moveq   #7,d2
    move.b  d1,d0
    swap    d3
    bpl.s   @skip\@
    move.b  (a0)+,d0            ; get desc. bitfield
    move.b  (a0)+,d1            ;
    move.b  (a4,d0.w),d0            ; reload converted desc. bitfield from a LUT
    move.b  (a4,d1.w),d1            ;
@skip\@
    endm
; ---------------------------------------------------------------------------
 
KosDec:
    moveq   #7,d7
    moveq   #0,d0
    moveq   #0,d1
    lea KosDec_ByteMap(pc),a4
    move.b  (a0)+,d0            ; get desc field low-byte
    move.b  (a0)+,d1            ; get desc field hi-byte
    move.b  (a4,d0.w),d0            ; reload converted desc. bitfield from a LUT
    move.b  (a4,d1.w),d1            ;
    moveq   #7,d2               ; set repeat count to 8
    moveq   #-1,d3              ; d3 will be desc field switcher
    clr.w   d3              ;
    bra.s   KosDec_FetchNewCode
 
KosDec_FetchCodeLoop:
    ; code 1 (Uncompressed byte)
    _Kos_RunBitStream
    move.b  (a0)+,(a1)+
 
KosDec_FetchNewCode:
    add.b   d0,d0               ; get a bit from the bitstream
    bcs.s   KosDec_FetchCodeLoop        ; if code = 0, branch
 
    ; codes 00 and 01
    _Kos_RunBitStream
    moveq   #0,d4               ; d4 will contain copy count
    add.b   d0,d0               ; get a bit from the bitstream
    bcs.s   KosDec_Code_01
 
    ; code 00 (Dictionary ref. short)
    _Kos_RunBitStream
    add.b   d0,d0               ; get a bit from the bitstream
    addx.w  d4,d4
    _Kos_RunBitStream
    add.b   d0,d0               ; get a bit from the bitstream
    addx.w  d4,d4
    _Kos_RunBitStream
    moveq   #-1,d5
    move.b  (a0)+,d5            ; d5 = displacement
 
KosDec_StreamCopy:
    lea (a1,d5),a3
    move.b  (a3)+,(a1)+         ; do 1 extra copy (to compensate for +1 to copy counter)
 
KosDec_copy:
    move.b  (a3)+,(a1)+
    dbf d4,KosDec_copy
    bra.w   KosDec_FetchNewCode
; ---------------------------------------------------------------------------
KosDec_Code_01:
    ; code 01 (Dictionary ref. long / special)
    _Kos_RunBitStream
    move.b  (a0)+,d6            ; d6 = %LLLLLLLL
    move.b  (a0)+,d4            ; d4 = %HHHHHCCC
    moveq   #-1,d5
    move.b  d4,d5               ; d5 = %11111111 HHHHHCCC
    lsl.w   #5,d5               ; d5 = %111HHHHH CCC00000
    move.b  d6,d5               ; d5 = %111HHHHH LLLLLLLL
    and.w   d7,d4               ; d4 = %00000CCC
    bne.s   KosDec_StreamCopy       ; if CCC=0, branch
 
    ; special mode (extended counter)
    move.b  (a0)+,d4            ; read cnt
    beq.s   KosDec_Quit         ; if cnt=0, quit decompression
    subq.b  #1,d4
    beq.w   KosDec_FetchNewCode     ; if cnt=1, fetch a new code
 
    lea (a1,d5),a3
    move.b  (a3)+,(a1)+         ; do 1 extra copy (to compensate for +1 to copy counter)
    move.w  d4,d6
    not.w   d6
    and.w   d7,d6
    add.w   d6,d6
    lsr.w   #3,d4
    jmp KosDec_largecopy(pc,d6.w)
 
KosDec_largecopy:
    rept 8
    move.b  (a3)+,(a1)+
    endr
    dbf d4,KosDec_largecopy
    bra.w   KosDec_FetchNewCode
 
KosDec_Quit:
    rts
 
; ---------------------------------------------------------------------------
; A look-up table to invert bits order in desc. field bytes
; ---------------------------------------------------------------------------
 
KosDec_ByteMap:
    dc.b    $00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,$70,$F0
    dc.b    $08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8
    dc.b    $04,$84,$44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4
    dc.b    $0C,$8C,$4C,$CC,$2C,$AC,$6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC
    dc.b    $02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,$52,$D2,$32,$B2,$72,$F2
    dc.b    $0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,$7A,$FA
    dc.b    $06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6
    dc.b    $0E,$8E,$4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE
    dc.b    $01,$81,$41,$C1,$21,$A1,$61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1
    dc.b    $09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,$59,$D9,$39,$B9,$79,$F9
    dc.b    $05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,$75,$F5
    dc.b    $0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD
    dc.b    $03,$83,$43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3
    dc.b    $0B,$8B,$4B,$CB,$2B,$AB,$6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB
    dc.b    $07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,$57,$D7,$37,$B7,$77,$F7
    dc.b    $0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,$7F,$FF
 
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine for queueing VDP commands (seems to only queue transfers to VRAM),
; to be issued the next time ProcessDMAQueue is called.
; Can be called a maximum of 18 times before the buffer needs to be cleared
; by issuing the commands (this subroutine DOES check for overflow)
; ---------------------------------------------------------------------------
; In case you wish to use this queue system outside of the spin dash, this is the
; registers in which it expects data in:
; d1.l: Address to data (In 68k address space)
; d2.w: Destination in VRAM
; d3.w: Length of data
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; sub_144E: DMA_68KtoVRAM: QueueCopyToVRAM: QueueVDPCommand: Add_To_DMA_Queue:
QueueDMATransfer:
	movea.l	(VDP_Command_Buffer_Slot).w,a1
	cmpa.w	#VDP_Command_Buffer_Slot,a1
	beq.s	QueueDMATransfer_Done ; return if there's no more room in the buffer
	; piece together some VDP commands and store them for later...
	move.w	#$9300,d0 ; command to specify DMA transfer length & $00FF
	move.b	d3,d0
	move.w	d0,(a1)+ ; store command

	move.w	#$9400,d0 ; command to specify DMA transfer length & $FF00
	lsr.w	#8,d3
	move.b	d3,d0
	move.w	d0,(a1)+ ; store command

	move.w	#$9500,d0 ; command to specify source address & $0001FE
	lsr.l	#1,d1
	move.b	d1,d0
	move.w	d0,(a1)+ ; store command

	move.w	#$9600,d0 ; command to specify source address & $01FE00
	lsr.l	#8,d1
	move.b	d1,d0
	move.w	d0,(a1)+ ; store command

	move.w	#$9700,d0 ; command to specify source address & $FE0000
	lsr.l	#8,d1
	andi.b	#$7F,d1		; this instruction safely allows source to be in RAM; S3K added this
	move.b	d1,d0
	move.w	d0,(a1)+ ; store command

	andi.l	#$FFFF,d2 ; command to specify destination address and begin DMA
	lsl.l	#2,d2
	lsr.w	#2,d2
	swap	d2
	ori.l	#$40000080,d2 ; set bits to specify VRAM transfer
	move.l	d2,(a1)+ ; store command

	move.l	a1,(VDP_Command_Buffer_Slot).w ; set the next free slot address
	cmpa.w	#VDP_Command_Buffer_Slot,a1
	beq.s	QueueDMATransfer_Done ; return if there's no more room in the buffer
	move.w	#0,(a1) ; put a stop token at the end of the used part of the buffer
; return_14AA:
QueueDMATransfer_Done:
	rts
; End of function QueueDMATransfer

; ---------------------------------------------------------------------------
; Subroutine for issuing all VDP commands that were queued
; (by earlier calls to QueueDMATransfer)
; Resets the queue when it's done
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; sub_14AC: CopyToVRAM: IssueVDPCommands: Process_DMA: Process_DMA_Queue:
ProcessDMAQueue:
		lea	(vdp_control_port).l,a5
		lea	(v_sgfx_buffer).w,a1
; loc_14B6:
ProcessDMAQueue_Loop:
		move.w	(a1)+,d0
		beq.s	ProcessDMAQueue_Done ; branch if we reached a stop token
		; issue a set of VDP commands...
		move.w	d0,(a5)		; transfer length
		move.w	(a1)+,(a5)	; transfer length
		move.w	(a1)+,(a5)	; source address
		move.w	(a1)+,(a5)	; source address
		move.w	(a1)+,(a5)	; source address
		move.w	(a1)+,(a5)	; destination
		move.w	(a1)+,(a5)	; destination
		cmpa.w	#$C8FC,a1
		bne.s	ProcessDMAQueue_Loop ; loop if we haven't reached the end of the buffer
; loc_14CE:
ProcessDMAQueue_Done:
		move.w	#0,(v_sgfx_buffer).w
		move.l	#v_sgfx_buffer,(VDP_Command_Buffer_Slot).w
		rts
; End of function ProcessDMAQueue