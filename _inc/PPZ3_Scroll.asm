PPZ3_IntScroll:
        swap    d0
        asr.l   #4,d0
        move.l  d0,d2
        add.l   d2,d2
        add.l   d2,d0
        move.l  d0,(cameraBgY).w
        swap    d0
        move.w  d0,(cameraBg2Y).w
        move.w  d0,(cameraBg3Y).w
        asr.w   #3,d1
        move.w  d1,(cameraBgX).w
        asr.w   #1,d1
        move.w  d1,d2
        add.w   d2,d2
        add.w   d1,d2
        move.w  d2,(cameraBg2X).w
        asr.w   #1,d1
        move.w  d1,d2
        add.w   d2,d2
        add.w   d1,d2
        move.w  d2,(cameraBg3X).w
        lea     (deformBuffer).w,a2
        clr.l   (a2)+
        clr.l   (a2)+
        clr.l   (a2)+
        clr.l   (a2)+
        clr.l   (a2)+
        rts
PPZ3_Scroll:                            ; CODE XREF: StageStart+298↑p ...
        lea     (objPlayerSlot).w,a6
        tst.b   (scrollLock).w
        beq.s   loc_202916
        rts
; ---------------------------------------------------------------------------

loc_202916:                             ; CODE XREF: ScrollStage+8↑j
        clr.w   (scrollFlags).w
        clr.w   (scrollFlagsBg).w
        clr.w   (scrollFlagsBg2).w
        clr.w   (scrollFlagsBg3).w
        jsr   MoveCameraX
        jsr   MoveCameraY
        jsr   RunLevelEvents
        move.w  (cameraY).w,(vscrollScreen).w
        move.w  (cameraBgY).w,(vscrollScreen+2).w
        move.w  (scrollXDiff).w,d4
        ext.l   d4
        asl.l   #3,d4
        move.l  d4,d3
        add.l   d4,d4
        add.l   d3,d4
        moveq   #6,d6
        jsr   SetHScrollFlagsBG3
        move.w  (scrollXDiff).w,d4
        ext.l   d4
        asl.l   #4,d4
        move.l  d4,d3
        add.l   d3,d3
        add.l   d3,d4
        moveq   #4,d6
        jsr   SetHScrollFlagsBG2
        lea     (deformBuffer+$FFA814).l,a1
        move.w  (scrollXDiff).w,d4
        ext.l   d4
        asl.l   #5,d4
        move.w  (scrollYDiff).w,d5
        ext.l   d5
        asl.l   #4,d5
        move.l  d5,d3
        add.l   d5,d5
        add.l   d3,d5
        jsr   SetScrollFlagsBG
        move.w  (cameraBgY).w,(vscrollScreen+2).w
        move.w  (cameraBgY).w,(cameraBg2Y).w
        move.w  (cameraBgY).w,(cameraBg3Y).w
        move.b  (scrollFlagsBg3).w,d0
        or.b    (scrollFlagsBg2).w,d0
        or.b    d0,(scrollFlagsBg).w
        clr.b   (scrollFlagsBg3).w
        clr.b   (scrollFlagsBg2).w
        lea     (deformBuffer).w,a2
        addi.l  #$10000,(a2)+
        addi.l  #$E000,(a2)+
        addi.l  #$C000,(a2)+
        addi.l  #$A000,(a2)+
        addi.l  #$8000,(a2)+
        move.w  (cameraX).w,d0
        neg.w   d0
        swap    d0
        lea     (deformBuffer).w,a2
        moveq   #4,d6

loc_2029DA:                             ; CODE XREF: ScrollStage+EC↓j
        move.l  (a2)+,d1
        swap    d1
        add.w   (cameraBg3X).w,d1
        neg.w   d1
        moveq   #0,d5
        lea     (unk_202A60).l,a3
        move.b  (a3,d6.w),d5

loc_2029F0:                             ; CODE XREF: ScrollStage+E8↓j
        move.w  d1,(a1)+
        dbf     d5,loc_2029F0
        dbf     d6,loc_2029DA
        move.w  #5,d1
        move.w  (cameraBg3X).w,d0
        neg.w   d0

loc_202A04:                             ; CODE XREF: ScrollStage+FC↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202A04
        move.w  #1,d1
        move.w  (cameraBgX).w,d0
        neg.w   d0

loc_202A14:                             ; CODE XREF: ScrollStage+10C↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202A14
        move.w  #7,d1
        move.w  (cameraBg2X).w,d0
        neg.w   d0

loc_202A24:                             ; CODE XREF: ScrollStage+11C↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202A24
        lea     (hscroll).w,a1
        lea     (deformBuffer+$FFA814).l,a2
        move.w  (cameraBgY).w,d0
        move.w  d0,d2
        andi.w  #$1F8,d0
        lsr.w   #2,d0
        move.w  d0,d3
        lsr.w   #1,d3
        moveq   #$1F,d1
        moveq   #$1C,d5
        sub.w   d3,d1
        bcs.s   loc_202A5C
        cmpi.w  #$1B,d1
        bcs.s   loc_202A52
        moveq   #$1B,d1

loc_202A52:                             ; CODE XREF: ScrollStage+144↑j
        sub.w   d1,d5
        lea     (a2,d0.w),a2
        bsr.w   sub_202A98

loc_202A5C:                             ; CODE XREF: ScrollStage+13E↑j
        bra.w   loc_202A66
; ---------------------------------------------------------------------------
unk_202A60:dc.b   1                     ; DATA XREF: ScrollStage+DC↑o
        dc.b   3
        dc.b   3
        dc.b   3
        dc.b   1
        dc.b   0
; ---------------------------------------------------------------------------

loc_202A66:                             ; CODE XREF: ScrollStage:loc_202A5C↑j
        move.w  (cameraBg2X).w,d0
        move.w  (cameraX).w,d2
        sub.w   d0,d2
        ext.l   d2
        asl.l   #8,d2
        divs.w  #$100,d2
        ext.l   d2
        asl.l   #8,d2
        moveq   #0,d3
        move.w  d0,d3
        move.w  d5,d1
        lsl.w   #3,d1
        subq.w  #1,d1

loc_202A86:                             ; CODE XREF: ScrollStage+188↓j
        move.w  d3,d0
        neg.w   d0
        move.l  d0,(a1)+
        swap    d3
        add.l   d2,d3
        swap    d3
        dbf     d1,loc_202A86
        rts
; End of function ScrollStage


; =============== S U B R O U T I N E =======================================


sub_202A98:                             ; CODE XREF: ScrollStage+14E↑p
        andi.w  #7,d2
        add.w   d2,d2
        move.w  (a2)+,d0
        jmp     loc_202AA6(pc,d2.w)
; End of function sub_202A98

; ---------------------------------------------------------------------------

loc_202AA4:                             ; CODE XREF: ROM:00202AB6↓j
        move.w  (a2)+,d0

loc_202AA6:                             ; CODE XREF: sub_202A98+8↑j
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        dbf     d1,loc_202AA4
        rts
; ---------------------------------------------------------------------------
Unk_Jump:
        neg.w   d0
        jmp     loc_202AC4(pc,d2.w)
; ---------------------------------------------------------------------------
Unk_Line:
        neg.w   d0
loc_202AC4:                             ; CODE XREF: ROM:00202ABE↑j
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        move.l  d0,(a1)+
        dbf     d1,loc_202AA4
        rts