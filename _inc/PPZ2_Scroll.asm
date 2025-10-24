; =============== S U B R O U T I N E =======================================


PPZ2_IntScroll:                         ; CODE XREF: InitCamera+10C↑p
        swap    d0
        asr.l   #4,d0
        move.l  d0,d2
        add.l   d2,d2
        add.l   d2,d0
        move.l  d0,(cameraBgY).w
        swap    d0
        move.w  d0,(cameraBg2Y).w
        move.w  d0,(cameraBg3Y).w
        lsr.w   #1,d1
        move.w  d1,(cameraBgX).w
        lsr.w   #2,d1
        move.w  d1,(cameraBg3X).w
        lsr.w   #1,d1
        move.w  d1,d2
        add.w   d2,d2
        add.w   d2,d1
        move.w  d1,(cameraBg2X).w
        lea     (deformBuffer).w,a2
        clr.l   (a2)+
        clr.l   (a2)+
        clr.l   (a2)+
        rts
; End of function PPZ2_IntScroll


; =============== S U B R O U T I N E =======================================


PPZ2_Scroll:                            ; CODE XREF: StageStart+298↑p ...
        lea     (objPlayerSlot).w,a6
        tst.b   (scrollLock).w
        beq.s   loc_202A64
        rts
; ---------------------------------------------------------------------------

loc_202A64:                             ; CODE XREF: PPZ2_Scroll+8↑j
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
        asl.l   #5,d4
        moveq   #6,d6
        jsr   SetHScrollFlagsBG3
        move.w  (scrollXDiff).w,d4
        ext.l   d4
        asl.l   #4,d4
        move.l  d4,d3
        add.l   d3,d3
        add.l   d3,d4
        moveq   #4,d6
        jsr     SetHScrollFlagsBG2
        lea     (deformBuffer+$FFA80C).l,a1
        move.w  (scrollXDiff).w,d4
        ext.l   d4
        asl.l   #7,d4
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
        addi.l  #$C000,(a2)+
        addi.l  #$8000,(a2)+
        move.w  (cameraX).w,d0
        neg.w   d0
        swap    d0
        move.w  (deformBuffer).w,d0
        add.w   (cameraBg3X).w,d0
        neg.w   d0
        move.w  #3,d1

loc_202B1E:                             ; CODE XREF: PPZ2_Scroll+C8↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202B1E
        move.w  (deformBuffer+4).w,d0
        add.w   (cameraBg3X).w,d0
        neg.w   d0
        move.w  #3,d1

loc_202B32:                             ; CODE XREF: PPZ2_Scroll+DC↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202B32
        move.w  (deformBuffer+8).w,d0
        add.w   (cameraBg3X).w,d0
        neg.w   d0
        move.w  #3,d1

loc_202B46:                             ; CODE XREF: PPZ2_Scroll+F0↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202B46
        move.w  #$13,d1
        move.w  (cameraBg3X).w,d0
        neg.w   d0

loc_202B56:                             ; CODE XREF: PPZ2_Scroll+100↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202B56
        move.w  #3,d1
        move.w  (cameraBg2X).w,d0
        neg.w   d0

loc_202B66:                             ; CODE XREF: PPZ2_Scroll+110↓j
        move.w  d0,(a1)+
        dbf     d1,loc_202B66
        lea     (hscroll).w,a1
        lea     (deformBuffer+$FFA80C).l,a2
        move.w  (cameraBgY).w,d0
        move.w  d0,d2
        andi.w  #$1F8,d0
        lsr.w   #2,d0
        move.w  d0,d3
        lsr.w   #1,d3
        moveq   #$23,d1 ; '#'
        moveq   #$1C,d5
        sub.w   d3,d1
        bcs.s   loc_202B9E
        cmpi.w  #$1B,d1
        bcs.s   loc_202B94
        moveq   #$1B,d1

loc_202B94:                             ; CODE XREF: PPZ2_Scroll+138↑j
        sub.w   d1,d5
        lea     (a2,d0.w),a2
        bsr.w   sub_202BD0

loc_202B9E:                             ; CODE XREF: PPZ2_Scroll+132↑j
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

loc_202BBE:                             ; CODE XREF: PPZ2_Scroll+172↓j
        move.w  d3,d0
        neg.w   d0
        move.l  d0,(a1)+
        swap    d3
        add.l   d2,d3
        swap    d3
        dbf     d1,loc_202BBE
        rts
; End of function PPZ2_Scroll

; =============== S U B R O U T I N E =======================================


sub_202BD0:                             ; CODE XREF: PPZ2_Scroll+142↑p
        andi.w  #7,d2
        add.w   d2,d2
        move.w  (a2)+,d0
        jmp     word_202BDE(pc,d2.w)
; End of function sub_202BD0

; ---------------------------------------------------------------------------
        dc.b $30 ; 0
        dc.b $1A
word_202BDE:dc.w $22C0                  ; CODE XREF: sub_202BD0+8↑j
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $51 ; Q
        dc.b $C9
        dc.b $FF
        dc.b $EC
        dc.b $4E ; N
        dc.b $75 ; u
        dc.b $44 ; D
        dc.b $40 ; @
        dc.b $4E ; N
        dc.b $FB
        dc.b $20
        dc.b   4
        dc.b $44 ; D
        dc.b $40 ; @
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $22 ; "
        dc.b $C0
        dc.b $51 ; Q
        dc.b $C9
        dc.b $FF
        dc.b $CE
        dc.b $4E ; N
        dc.b $75 ; u