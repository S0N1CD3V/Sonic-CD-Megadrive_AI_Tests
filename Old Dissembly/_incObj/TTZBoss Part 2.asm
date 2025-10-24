ObjTTZBoss2:
sub_20C3CE:                             ; DATA XREF: ROM:00203F00↑o
                bclr    #6,objoff_2C(a0)
                tst.b   objoff_2B(a0)
                beq.s   loc_20C3F8
                subq.b  #1,objoff_2B(a0)
                bne.s   loc_20C3FC
                move.b  #0,obAnim(a0)
                clr.b   obFrame(a0)
                clr.b   obAniFrame(a0)
                clr.b   obTimeFrame(a0)
                clr.b   obDelayAni(a0)
                bra.s   loc_20C3FC
; ---------------------------------------------------------------------------

loc_20C3F8:                             ; CODE XREF: sub_20C3CE+A↑j
                bsr.w   sub_20C7AA

loc_20C3FC:                             ; CODE XREF: sub_20C3CE+10↑j
                                        ; sub_20C3CE+28↑j
                moveq   #0,d0
                move.b  obRoutine(a0),d0
                move.w  off_20C41E(pc,d0.w),d0
                jsr     off_20C41E(pc,d0.w)
                lea     (off_20D064).l,a1
                jsr     AnimateObject
                jsr     DrawObject
                rts
; End of function sub_20C3CE

; ---------------------------------------------------------------------------
off_20C41E:     dc.w loc_20C43A-*       ; CODE XREF: sub_20C3CE+38↑p
                                        ; DATA XREF: sub_20C3CE+34↑r ...
                dc.w loc_20C46E-off_20C41E
                dc.w sub_20C75A-off_20C41E
                dc.w sub_20C4BE-off_20C41E
                dc.w sub_20C53C-off_20C41E
                dc.w sub_20C556-off_20C41E
                dc.w sub_20C58C-off_20C41E
                dc.w sub_20C5D4-off_20C41E
                dc.w sub_20C61C-off_20C41E
                dc.w loc_20C828-off_20C41E
                dc.w sub_20C8A4-off_20C41E
                dc.w loc_20C6B4-off_20C41E
                dc.w nullsub_7-off_20C41E
                dc.w nullsub_8-off_20C41E
; ---------------------------------------------------------------------------

loc_20C43A:                             ; DATA XREF: ROM:off_20C41E↑o
                addq.b  #2,obRoutine(a0)
                move.b  #4,obRender(a0)
                move.b  #4,obPriority(a0)
                move.b  #$20,obActWid(a0) ; ' '
                move.b  #$2C,obHeight(a0) ; ','
                move.w  #$31E,obGfx(a0)
                move.l  #UnkMapTTZBoss2,obMap(a0) ;move.l  #$20D07C,obMap(a0)
                move.b  #2,obColProp(a0)
                bsr.w   sub_20CED2

loc_20C46E:                             ; DATA XREF: ROM:0020C420↑o
                move.w  #$9B0,d0
                move.w  d0,(v_limitright2).w
                move.w  d0,(v_limitright1).w
                lea     (v_objspace).w,a1
                move.w  obX(a1),d0
                subi.w  #$A0,d0
                cmp.w   (v_limitleft2).w,d0
                blt.s   locret_20C4BC
                cmpi.w  #$A50,obX(a1)
                blt.s   loc_20C4B4
                move.w  #bgm_Boss,d0 ; 'g'
                jsr     PlaySound
                moveq   #plcid_TTZBoss2,d0
                jsr     sub_202774
                move.b  #6,obRoutine(a0)
                move.w  #$9B0,d0
                move.w  d0,(v_limitright2).w
                move.w  d0,(v_limitright1).w
                move.w  #$9B0,d0

loc_20C4B4:                             ; CODE XREF: ROM:0020C492↑j
                move.w  d0,(v_limitleft2).w
                move.w  d0,(v_limitleft1).w

locret_20C4BC:                          ; CODE XREF: ROM:0020C48A↑j
                rts

; =============== S U B R O U T I N E =======================================


sub_20C4BE:                             ; DATA XREF: ROM:0020C424↑o
                bsr.w   sub_20C514
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$A,objoff_2A(a0)
                bne.w   loc_20C4D6
                jsr     sub_20CEA2

loc_20C4D6:                             ; CODE XREF: sub_20C4BE+E↑j
                cmpi.b  #$14,objoff_2A(a0)
                beq.s   loc_20C4E6
                cmpi.b  #$1E,objoff_2A(a0)
                bcs.s   locret_20C512

loc_20C4E6:                             ; CODE XREF: sub_20C4BE+1E↑j
                move.w  #sfx_Drown,d0
                jsr     PlaySound
                clr.b   objoff_2A(a0)
                jsr     sub_20CEAE
                move.b  objoff_2D(a0),objoff_2D(a1)
                addq.b  #1,objoff_2D(a0)
                cmpi.b  #$10,objoff_2D(a0)
                bne.s   locret_20C512
                move.b  #8,obRoutine(a0)

locret_20C512:                          ; CODE XREF: sub_20C4BE+26↑j
                                        ; sub_20C4BE+4C↑j
                rts
; End of function sub_20C4BE


; =============== S U B R O U T I N E =======================================


sub_20C514:                             ; CODE XREF: sub_20C4BE↑p
                                        ; sub_20C53C↓p
                cmpi.w  #$520,obY(a0)
                bge.s   loc_20C526
                addi.l  #$4650,obY(a0)
                bra.s   locret_20C53A
; ---------------------------------------------------------------------------

loc_20C526:                             ; CODE XREF: sub_20C514+6↑j
                move.w  #$AB0,obX(a0)
                clr.w   obScreenY(a0)
                move.w  #$520,obY(a0)
                clr.w   oVarE(a0)

locret_20C53A:                          ; CODE XREF: sub_20C514+10↑j
                rts
; End of function sub_20C514


; =============== S U B R O U T I N E =======================================


sub_20C53C:                             ; DATA XREF: ROM:0020C426↑o
                bsr.s   sub_20C514
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$96,objoff_2A(a0)
                bne.s   locret_20C554
                clr.b   objoff_2A(a0)
                move.b  #$A,obRoutine(a0)

locret_20C554:                          ; CODE XREF: sub_20C53C+C↑j
                rts
; End of function sub_20C53C


; =============== S U B R O U T I N E =======================================


sub_20C556:                             ; DATA XREF: ROM:0020C428↑o
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$96,objoff_2A(a0)
                bne.s   locret_20C58A
                move.b  #$C,obRoutine(a0)
                move.w  #$60,objoff_3C(a0) ; '`'
                move.w  #$40,obVelX(a0) ; '@'
                move.w  #0,objoff_34(a0)
                move.w  #$60,objoff_38(a0) ; '`'
                move.w  #0,objoff_3A(a0)
                clr.b   objoff_2A(a0)

locret_20C58A:                          ; CODE XREF: sub_20C556+A↑j
                rts
; End of function sub_20C556


; =============== S U B R O U T I N E =======================================


sub_20C58C:                             ; DATA XREF: ROM:0020C42A↑o
                bsr.w   sub_20C7E6
                addi.w  #$100,objoff_34(a0)
                cmpi.w  #$800,objoff_34(a0)
                bne.s   loc_20C5A4
                jsr     sub_20CEFA

loc_20C5A4:                             ; CODE XREF: sub_20C58C+10↑j
                cmpi.w  #$8000,objoff_34(a0)
                beq.s   loc_20C5C2
                move.w  objoff_38(a0),d0
                sub.w   d0,obX(a0)
                move.w  objoff_3A(a0),d0
                sub.w   d0,obY(a0)
                bsr.w   sub_20CE72
                rts
; ---------------------------------------------------------------------------

loc_20C5C2:                             ; CODE XREF: sub_20C58C+1E↑j
                clr.b   objoff_2A(a0)
                move.b  #$10,obRoutine(a0)
                bset    #4,objoff_2C(a0)
                rts
; End of function sub_20C58C


; =============== S U B R O U T I N E =======================================


sub_20C5D4:                             ; DATA XREF: ROM:0020C42C↑o
                bsr.w   sub_20C7E6
                subi.w  #$100,objoff_34(a0)
                cmpi.w  #$7800,objoff_34(a0)
                bne.s   loc_20C5EC
                jsr     sub_20CEFA

loc_20C5EC:                             ; CODE XREF: sub_20C5D4+10↑j
                cmpi.w  #0,objoff_34(a0)
                beq.s   loc_20C60A
                move.w  objoff_38(a0),d0
                sub.w   d0,obX(a0)
                move.w  objoff_3A(a0),d0
                sub.w   d0,obY(a0)
                bsr.w   sub_20CE72
                rts
; ---------------------------------------------------------------------------

loc_20C60A:                             ; CODE XREF: sub_20C5D4+1E↑j
                clr.b   objoff_2A(a0)
                move.b  #$10,obRoutine(a0)
                bset    #4,objoff_2C(a0)
                rts
; End of function sub_20C5D4


; =============== S U B R O U T I N E =======================================


sub_20C61C:                             ; DATA XREF: ROM:0020C42E↑o
                bclr    #4,objoff_2C(a0)
                bclr    #5,objoff_2C(a0)
                bsr.w   sub_20C7E6
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$30,objoff_2A(a0) ; '0'
                beq.s   loc_20C642
                cmpi.b  #$60,objoff_2A(a0) ; '`'
                beq.s   loc_20C660
                rts
; ---------------------------------------------------------------------------

loc_20C642:                             ; CODE XREF: sub_20C61C+1A↑j
                movea.w objoff_30(a0),a1
                bchg    #0,obRender(a1)
                bchg    #0,obStatus(a1)
                bchg    #0,obRender(a0)
                bchg    #0,obStatus(a0)
                rts
; ---------------------------------------------------------------------------

loc_20C660:                             ; CODE XREF: sub_20C61C+22↑j
                clr.b   objoff_2A(a0)
                btst    #0,obStatus(a0)
                beq.s   loc_20C67A
                bset    #3,objoff_2C(a0)
                move.b  #$E,obRoutine(a0)
                bra.s   loc_20C686
; ---------------------------------------------------------------------------

loc_20C67A:                             ; CODE XREF: sub_20C61C+4E↑j
                bclr    #3,objoff_2C(a0)
                move.b  #$C,obRoutine(a0)

loc_20C686:                             ; CODE XREF: sub_20C61C+5C↑j
                                        ; sub_20C61C+80↓j
                moveq   #0,d0
                move.b  objoff_33(a0),d0
                move.b  byte_20C6AC(pc,d0.w),d0
                bmi.s   locret_20C69E
                cmp.b   objoff_2D(a0),d0
                blt.w   locret_20C69E
                bsr.s   sub_20C6A0
                bra.s   loc_20C686
; ---------------------------------------------------------------------------

locret_20C69E:                          ; CODE XREF: sub_20C61C+74↑j
                                        ; sub_20C61C+7A↑j
                rts
; End of function sub_20C61C


; =============== S U B R O U T I N E =======================================


sub_20C6A0:                             ; CODE XREF: sub_20C61C+7E↑p
                addq.b  #1,objoff_33(a0)
                move.b  #$16,obRoutine(a0)
                rts
; End of function sub_20C6A0

; ---------------------------------------------------------------------------
byte_20C6AC:    dc.b $E                 ; DATA XREF: sub_20C61C+70↑r
                dc.b $C, $A, 8
; ---------------------------------------------------------------------------
                addi.b  #-1,d4

loc_20C6B4:                             ; DATA XREF: ROM:0020C434↑o
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$14,objoff_2A(a0)
                beq.s   loc_20C6DC
                cmpi.b  #$15,objoff_2A(a0)
                beq.s   loc_20C6EC
                cmpi.b  #$2D,objoff_2A(a0) ; '-'
                beq.s   loc_20C6D4
                bra.w   loc_20C6F2
; ---------------------------------------------------------------------------

loc_20C6D4:                             ; CODE XREF: ROM:0020C6CE↑j
                jsr     sub_20CEFA
                bra.s   loc_20C6F2
; ---------------------------------------------------------------------------

loc_20C6DC:                             ; CODE XREF: ROM:0020C6BE↑j
                bsr.w   loc_20C7C8
                clr.b   objoff_32(a0)
                bset    #5,objoff_2C(a0)
                bra.s   loc_20C6F2
; ---------------------------------------------------------------------------

loc_20C6EC:                             ; CODE XREF: ROM:0020C6C6↑j
                bclr    #5,objoff_2C(a0)

loc_20C6F2:                             ; CODE XREF: ROM:0020C6D0↑j
                                        ; ROM:0020C6DA↑j ...
                btst    #3,objoff_2C(a0)
                bne.s   loc_20C70C
                subi.l  #$10000,obX(a0)
                cmpi.w  #$9F0,obX(a0)
                ble.s   loc_20C71E
                bra.s   locret_20C71C
; ---------------------------------------------------------------------------

loc_20C70C:                             ; CODE XREF: ROM:0020C6F8↑j
                addi.l  #$10000,obX(a0)
                cmpi.w  #$AB0,obX(a0)
                bge.s   loc_20C71E

locret_20C71C:                          ; CODE XREF: ROM:0020C70A↑j
                rts
; ---------------------------------------------------------------------------

loc_20C71E:                             ; CODE XREF: ROM:0020C708↑j
                                        ; ROM:0020C71A↑j
                neg.l   objoff_38(a0)
                addi.w  #-$8000,objoff_34(a0)
                move.w  #$A50,obX(a0)
                clr.w   obScreenY(a0)
                move.l  objoff_38(a0),d0
                add.l   d0,obX(a0)
                move.w  #$520,obY(a0)
                clr.w   oVarE(a0)
                clr.b   objoff_2A(a0)
                move.b  #$10,obRoutine(a0)
                bset    #4,objoff_2C(a0)
                rts
; =============== S U B R O U T I N E =======================================
nullsub_7:                              ; DATA XREF: ROM:0020C436↑o
                 rts
; End of function nullsub_7
; =============== S U B R O U T I N E =======================================
nullsub_8:                              ; DATA XREF: ROM:0020C438↑o
                 rts
; End of function nullsub_8

; =============== S U B R O U T I N E =======================================


sub_20C75A:                             ; DATA XREF: ROM:0020C422↑o
                lea     (dword_202BA4).l,a1
                move.w  (a1)+,d0
                move.w  (a1)+,d1
                move.w  (a1)+,d2
                move.w  (a1)+,d3
                addq.w  #6,(v_limitright2).w
                addq.w  #6,(v_limitright1).w
                cmp.w   (v_limitright2).w,d1
                ble.s   loc_20C77A
                addq.l  #4,sp
                rts
; ---------------------------------------------------------------------------

loc_20C77A:                             ; CODE XREF: sub_20C75A+1A↑j
                clr.b   (f_lockscreen).w
                move.w  d1,(v_limitright2).w
                move.w  d1,(v_limitright1).w
                move.w  #$17,d0
                tst.b   (v_good_future).l
                beq.s   loc_20C796
                move.w  #$16,d0
loc_20C796:                             ; CODE XREF: sub_20C75A+36↑j
                jsr     PlaySound
                jsr     sub_20A494
                addq.l  #4,sp
                jmp     DeleteObject
; End of function sub_20C75A


; =============== S U B R O U T I N E =======================================


sub_20C7AA:                             ; CODE XREF: sub_20C3CE:loc_20C3F8↑p
                tst.b   obAnim(a0)
                bne.s   locret_20C7C6
                lea     (v_objspace).w,a1
                tst.w   objoff_30(a1)
                bne.w   loc_20C7C8
                cmpi.b  #6,obRoutine(a1)
                beq.w   loc_20C7C8

locret_20C7C6:                          ; CODE XREF: sub_20C7AA+4↑j
                rts
; ---------------------------------------------------------------------------

loc_20C7C8:                             ; CODE XREF: ROM:loc_20C6DC↑p
                                        ; sub_20C7AA+E↑j ...
                move.b  #$78,objoff_2B(a0) ; 'x'
                move.b  #1,obAnim(a0)
                clr.b   obFrame(a0)
                clr.b   obAniFrame(a0)
                clr.b   obTimeFrame(a0)
                clr.b   obDelayAni(a0)
                rts
; End of function sub_20C7AA


; =============== S U B R O U T I N E =======================================


sub_20C7E6:                             ; CODE XREF: sub_20C58C↑p
                                        ; sub_20C5D4↑p ...
                tst.b   obColType(a0)
                beq.s   loc_20C7EE
                rts
; ---------------------------------------------------------------------------

loc_20C7EE:                             ; CODE XREF: sub_20C7E6+4↑j
                move.b  #$3C,obColType(a0) ; '<'
                cmpi.b  #1,obColProp(a0)
                beq.s   loc_20C7FE
                rts
; ---------------------------------------------------------------------------

loc_20C7FE:                             ; CODE XREF: sub_20C7E6+14↑j
                clr.b   objoff_2A(a0)
                move.b  #$12,obRoutine(a0)
                bset    #7,objoff_2C(a0)
                move.b  #2,obAnim(a0)
                clr.b   obFrame(a0)
                clr.b   obAniFrame(a0)
                clr.b   obTimeFrame(a0)
                clr.b   obDelayAni(a0)
                bra.w   *+4
; ---------------------------------------------------------------------------

loc_20C828:                             ; CODE XREF: sub_20C7E6+3E↑j
                                        ; DATA XREF: ROM:0020C430↑o
                moveq   #0,d0
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$3C,objoff_2A(a0) ; '<'
                bcc.s   loc_20C83A
                bsr.w   sub_20C928

loc_20C83A:                             ; CODE XREF: sub_20C7E6+4E↑j
                cmpi.b  #$3C,objoff_2A(a0) ; '<'
                beq.s   loc_20C84C
                cmpi.b  #$3D,objoff_2A(a0) ; '='
                beq.s   loc_20C874
                rts
; ---------------------------------------------------------------------------

loc_20C84C:                             ; CODE XREF: sub_20C7E6+5A↑j
                move.b  #3,obAnim(a0)
                move.b  #$FF,objoff_2B(a0)
                clr.b   obFrame(a0)
                clr.b   obAniFrame(a0)
                clr.b   obTimeFrame(a0)
                clr.b   obDelayAni(a0)
                movea.w objoff_30(a0),a1
                move.b  #1,obFrame(a0)
                rts
; ---------------------------------------------------------------------------

loc_20C874:                             ; CODE XREF: sub_20C7E6+62↑j
                clr.b   objoff_2A(a0)
                move.b  #$14,obRoutine(a0)
                bset    #0,obRender(a0)
                bset    #0,obStatus(a0)
                movea.w objoff_30(a0),a1
                bset    #0,obRender(a1)
                bset    #0,obStatus(a1)
                moveq   #$64,d0 ; 'd'
                jsr     AddPoints
                rts
; End of function sub_20C7E6


; =============== S U B R O U T I N E =======================================


sub_20C8A4:                             ; DATA XREF: ROM:0020C432↑o
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$3C,objoff_2A(a0) ; '<'
                bcs.s   locret_20C8C0
                addi.l  #$1C000,obX(a0)
                cmpi.w  #$B30,obX(a0)
                bge.s   loc_20C8C2

locret_20C8C0:                          ; CODE XREF: sub_20C8A4+A↑j
                rts
; ---------------------------------------------------------------------------

loc_20C8C2:                             ; CODE XREF: sub_20C8A4+1A↑j
                move.b  #4,obRoutine(a0)
                movea.w objoff_30(a0),a1
                jsr     loc_203B40
                rts
; End of function sub_20C8A4
; =============== S U B R O U T I N E =======================================


sub_20A494:                             ; CODE XREF: sub_20C75A+42↓p
                move.w  #7,d6
                lea     (word_20A4AA).l,a1
                lea     (UnkCDBossFlag).w,a2

loc_20A4A2:                             ; CODE XREF: sub_20A494+10↓j
                move.l  (a1)+,(a2)+
                dbf     d6,loc_20A4A2
                rts
; End of function sub_20A494

; ---------------------------------------------------------------------------
word_20A4AA:    dc.w $A22               ; DATA XREF: sub_20A494+4↑o
                dc.w 0, $644, $A66, $C88, $EAA, $EEE
                dc.w $AE8
; =============== S U B R O U T I N E =======================================
ObjUnk:
sub_20C8D4:                             ; DATA XREF: ROM:00203F04↑o
                moveq   #0,d0
                move.b  obRoutine(a0),d0
                move.w  off_20C8E8(pc,d0.w),d0
                jsr     off_20C8E8(pc,d0.w)
                jmp     DrawObject
; End of function sub_20C8D4

; ---------------------------------------------------------------------------
off_20C8E8:     dc.w loc_20C8EC-*       ; CODE XREF: sub_20C8D4+A↑p
                                        ; DATA XREF: sub_20C8D4+6↑r ...
                dc.w loc_20C916-off_20C8E8
; ---------------------------------------------------------------------------

loc_20C8EC:                             ; DATA XREF: ROM:off_20C8E8↑o
                addq.b  #2,obRoutine(a0)
                move.b  #4,obRender(a0)
                move.b  #4,obPriority(a0)
                move.b  #$20,obActWid(a0) ; ' '
                move.b  #$1C,obHeight(a0)
                move.w  #$31E,obGfx(a0)
                move.l  #UnkTTZBossItem,obMap(a0)

loc_20C916:                             ; DATA XREF: ROM:0020C8EA↑o
                movea.w objoff_2E(a0),a1
                move.w  obX(a1),obX(a0)
                move.w  obY(a1),obY(a0)
                rts

; =============== S U B R O U T I N E =======================================


sub_20C928:                             ; CODE XREF: sub_20C7E6+50↑p
                moveq   #0,d2
                move.b  objoff_2A(a0),d2
                divu.w  #4,d2
                swap    d2
                tst.w   d2
                bne.s   locret_20C982
                clr.w   d2
                swap    d2
                divu.w  #$A,d2
                swap    d2
                add.w   d2,d2
                add.w   d2,d2
                jsr     Create_New_Sprite
                bne.s   locret_20C982
                st      ob2ndRout(a1)
                lea     (dword_20C984).l,a2
                adda.w  d2,a2
                move.b  #id_ExplosionBomb,oID(a1)
                move.w  obX(a0),obX(a1)
                move.w  obY(a0),obY(a1)
                move.w  (a2)+,d0
                add.w   d0,obX(a1)
                move.w  (a2),d0
                add.w   d0,obY(a1)
                move.w  #sfx_Bomb,d0
                jsr     PlaySound

locret_20C982:                          ; CODE XREF: sub_20C928+E↑j
                                        ; sub_20C928+24↑j
                rts
; End of function sub_20C928

; ---------------------------------------------------------------------------
dword_20C984:   dc.l $FFD0FFF0, $300010, $FFF0FFF0, $100010, $FFE00000
                                        ; DATA XREF: sub_20C928+2A↑o
                dc.l $30FFF0, $FFD00010, $FFF00010, $10FFF0, $200000
; =============== S U B R O U T I N E =======================================

ObjUnkBubbles:
sub_20C9AC:                             ; DATA XREF: ROM:00203F0C↑o
                moveq   #0,d0
                move.b  obRoutine(a0),d0
                move.w  off_20C9C0(pc,d0.w),d0
                jsr     off_20C9C0(pc,d0.w)
                jmp     DrawObject
; End of function sub_20C9AC

; ---------------------------------------------------------------------------

off_20C9C0:     dc.w loc_20C9D2-*       ; CODE XREF: sub_20C9AC+A↑p
                                        ; DATA XREF: sub_20C9AC+6↑r ...
                dc.w loc_20CA3E-off_20C9C0
                dc.w sub_20CAE2-off_20C9C0
                dc.w sub_20CB44-off_20C9C0
                dc.w sub_20CBF8-off_20C9C0
                dc.w loc_20CC50-off_20C9C0
                dc.w loc_20CE30-off_20C9C0
                dc.w loc_20CE3C-off_20C9C0
                dc.w loc_20CD40-off_20C9C0
; ---------------------------------------------------------------------------

loc_20C9D2:                             ; DATA XREF: ROM:off_20C9C0↑o
                move.b  #2,obRoutine(a0)
                move.b  #4,obRender(a0)
                move.b  #3,obPriority(a0)
                move.b  #$10,obActWid(a0)
                move.b  #$10,obHeight(a0)
                move.w  #$31E,obGfx(a0)
                move.l  #UnkBubbles,obMap(a0)
                jsr     RandomNumber
                andi.l  #$FFFF,d0
                ext.l   d0
                divs.w  #$500,d0
                swap    d0
                tst.w   d0
                bmi.s   loc_20CA1C
                addi.w  #$80,d0
                bra.s   loc_20CA20
; ---------------------------------------------------------------------------

loc_20CA1C:                             ; CODE XREF: ROM:0020CA14↑j
                subi.w  #$80,d0

loc_20CA20:                             ; CODE XREF: ROM:0020CA1A↑j
                move.w  d0,objoff_36(a0)
                jsr     RandomNumber
                andi.l  #$FFFF,d0
                divu.w  #$10,d0
                swap    d0
                addi.w  #$A,d0
                move.w  d0,objoff_3C(a0)

loc_20CA3E:                             ; DATA XREF: ROM:0020C9C2↑o
                subi.l  #$18000,obY(a0)
                tst.b   ob2ndRout(a0)
                beq.s   loc_20CA58
                cmpi.w  #$470,obY(a0)
                bge.s   loc_20CA68
                bra.w   loc_20CE3C
; ---------------------------------------------------------------------------

loc_20CA58:                             ; CODE XREF: ROM:0020CA4A↑j
                movea.w objoff_2E(a0),a1
                move.w  obY(a1),d0
                cmp.w   obY(a0),d0
                bge.w   loc_20CA72

loc_20CA68:                             ; CODE XREF: ROM:0020CA52↑j
                move.w  objoff_36(a0),d0
                add.w   d0,objoff_34(a0)
                bra.s   loc_20CAB6
; ---------------------------------------------------------------------------

loc_20CA72:                             ; CODE XREF: ROM:0020CA64↑j
                move.w  obX(a0),d0
                sub.w   obX(a1),d0
                bge.s   loc_20CA84
                move.w  #0,objoff_34(a0)
                bra.s   loc_20CA8A
; ---------------------------------------------------------------------------

loc_20CA84:                             ; CODE XREF: ROM:0020CA7A↑j
                move.w  #$8000,objoff_34(a0)

loc_20CA8A:                             ; CODE XREF: ROM:0020CA82↑j
                move.w  d0,objoff_3C(a0)
                move.w  d0,obVelX(a0)
                neg.w   d0
                move.w  d0,objoff_38(a0)
                clr.w   objoff_3A(a0)
                move.w  obX(a1),obX(a0)
                move.w  obY(a1),obY(a0)
                move.b  #4,obRoutine(a0)
                move.b  #2,obAnim(a0)
                rts
; ---------------------------------------------------------------------------

loc_20CAB6:                             ; CODE XREF: ROM:0020CA70↑j
                move.w  objoff_38(a0),d3
                sub.w   d3,obX(a0)
                bsr.w   sub_20CE72
                cmpi.b  #4,obAniFrame(a0)
                bne.s   loc_20CAD4
                move.b  #1,obAnim(a0)
                clr.b   obAniFrame(a0)

loc_20CAD4:                             ; CODE XREF: ROM:0020CAC8↑j
                lea     (off_20D12C).l,a1
                jsr     AnimateObject
                rts

; =============== S U B R O U T I N E =======================================


sub_20CAE2:                             ; DATA XREF: ROM:0020C9C4↑o
                movea.w objoff_2E(a0),a1
                move.w  obX(a1),obX(a0)
                move.w  obY(a1),obY(a0)
                bsr.w   sub_20CE72
                move.w  objoff_36(a0),d0
                bmi.s   loc_20CAFE
                neg.w   d0

loc_20CAFE:                             ; CODE XREF: sub_20CAE2+18↑j
                add.w   d0,objoff_34(a0)
                movea.w objoff_2E(a0),a1
                cmpi.b  #$A,obRoutine(a1)
                bne.s   locret_20CB42
                clr.w   objoff_38(a0)
                clr.w   objoff_3A(a0)
                move.b  #6,obRoutine(a0)
                move.l  obX(a1),obX(a0)
                move.l  obY(a1),obY(a0)
                moveq   #0,d0
                move.b  objoff_2D(a0),d0
                mulu.w  #$1000,d0
                move.w  d0,objoff_34(a0)
                move.w  #$10,objoff_3C(a0)
                move.w  #$10,obVelX(a0)

locret_20CB42:                          ; CODE XREF: sub_20CAE2+2A↑j
                rts
; End of function sub_20CAE2


; =============== S U B R O U T I N E =======================================


sub_20CB44:                             ; DATA XREF: ROM:0020C9C6↑o
                btst    #1,objoff_2C(a0)
                beq.s   loc_20CB50
                bsr.w   sub_20CDE0

loc_20CB50:                             ; CODE XREF: sub_20CB44+6↑j
                moveq   #0,d3
                movea.w objoff_2E(a0),a1
                move.l  obX(a1),obX(a0)
                move.l  obY(a1),obY(a0)
                cmpi.w  #$30,objoff_3C(a0) ; '0'
                bge.s   loc_20CB74
                addi.l  #$4000,objoff_3C(a0)
                bra.s   loc_20CB7C
; ---------------------------------------------------------------------------

loc_20CB74:                             ; CODE XREF: sub_20CB44+24↑j
                move.w  #$30,objoff_3C(a0) ; '0'
                addq.l  #1,d3

loc_20CB7C:                             ; CODE XREF: sub_20CB44+2E↑j
                cmpi.w  #$30,obVelX(a0) ; '0'
                bge.s   loc_20CB8E
                addi.l  #$4000,obVelX(a0)
                bra.s   loc_20CB96
; ---------------------------------------------------------------------------

loc_20CB8E:                             ; CODE XREF: sub_20CB44+3E↑j
                move.w  #$30,obVelX(a0) ; '0'
                addq.l  #1,d3

loc_20CB96:                             ; CODE XREF: sub_20CB44+48↑j
                btst    #3,objoff_2C(a1)
                beq.s   loc_20CBA6
                addi.w  #$480,objoff_34(a0)
                bra.s   loc_20CBAC
; ---------------------------------------------------------------------------

loc_20CBA6:                             ; CODE XREF: sub_20CB44+58↑j
                subi.w  #$480,objoff_34(a0)

loc_20CBAC:                             ; CODE XREF: sub_20CB44+60↑j
                movem.l d3,-(sp)
                bsr.w   sub_20CE72
                movem.l (sp)+,d3
                cmpi.b  #2,obAniFrame(a0)
                bne.s   loc_20CBCA
                move.b  #3,obAnim(a0)
                clr.b   obAniFrame(a0)

loc_20CBCA:                             ; CODE XREF: sub_20CB44+7A↑j
                cmpi.w  #2,d3
                bne.s   loc_20CBEA
                move.b  #8,obRoutine(a0)
                bset    #1,objoff_2C(a0)
                bne.s   loc_20CBEA
                move.b  #$FF,obColType(a0)
                move.b  #2,obColProp(a0)

loc_20CBEA:                             ; CODE XREF: sub_20CB44+8A↑j
                                        ; sub_20CB44+98↑j
                lea     (off_20D12C).l,a1
                jsr     AnimateObject
                rts
; End of function sub_20CB44


; =============== S U B R O U T I N E =======================================


sub_20CBF8:                             ; DATA XREF: ROM:0020C9C8↑o

; FUNCTION CHUNK AT 0020CD40 SIZE 0000007E BYTES

                movea.w objoff_2E(a0),a1
                move.l  obX(a1),obX(a0)
                move.l  obY(a1),obY(a0)
                btst    #4,objoff_2C(a1)
                beq.s   loc_20CC1A
                move.b  #$A,obRoutine(a0)
                bra.w   loc_20CC50
; ---------------------------------------------------------------------------

loc_20CC1A:                             ; CODE XREF: sub_20CBF8+16↑j
                btst    #5,objoff_2C(a1)
                beq.s   loc_20CC32
                move.b  #$10,obRoutine(a0)
                move.b  #3,obPriority(a0)
                bra.w   loc_20CD40
; ---------------------------------------------------------------------------

loc_20CC32:                             ; CODE XREF: sub_20CBF8+28↑j
                bsr.w   sub_20CDE0
                btst    #3,objoff_2C(a1)
                beq.s   loc_20CC46
                addi.w  #$180,objoff_34(a0)
                bra.s   loc_20CC4C
; ---------------------------------------------------------------------------

loc_20CC46:                             ; CODE XREF: sub_20CBF8+44↑j
                subi.w  #$180,objoff_34(a0)

loc_20CC4C:                             ; CODE XREF: sub_20CBF8+4C↑j
                bra.w   sub_20CE72
; ---------------------------------------------------------------------------

loc_20CC50:                             ; CODE XREF: sub_20CBF8+1E↑j
                                        ; DATA XREF: ROM:0020C9CA↑o
                bsr.w   sub_20CDE0
                movea.w objoff_2E(a0),a1
                move.l  obX(a1),obX(a0)
                move.l  obY(a1),obY(a0)
                tst.b   ob2ndRout(a0)
                bne.w   loc_20CC7E
                subi.l  #$10000,objoff_3C(a0)
                bge.w   sub_20CCAA
                addq.b  #1,ob2ndRout(a0)
                bra.s   sub_20CCAA
; ---------------------------------------------------------------------------

loc_20CC7E:                             ; CODE XREF: sub_20CBF8+70↑j
                subi.l  #$10000,objoff_3C(a0)
                cmpi.l  #$FFD00000,objoff_3C(a0)
                bgt.s   sub_20CCAA
                move.l  #$300000,objoff_3C(a0)
                move.b  #8,obRoutine(a0)
                bsr.w   sub_20CCEC
                bsr.s   sub_20CCAA
                clr.b   ob2ndRout(a0)
                rts
; End of function sub_20CBF8


; =============== S U B R O U T I N E =======================================


sub_20CCAA:                             ; CODE XREF: sub_20CBF8+7C↑j
                                        ; sub_20CBF8+84↑j ...
                move.w  #$480,d0
                btst    #3,objoff_2C(a1)
                bne.s   loc_20CCB8
                neg.w   d0

loc_20CCB8:                             ; CODE XREF: sub_20CCAA+A↑j
                add.w   d0,objoff_34(a0)
                move.b  objoff_34(a0),d0
                subi.b  #$40,d0 ; '@'
                movea.w objoff_2E(a0),a1
                btst    #3,objoff_2C(a1)
                beq.s   loc_20CCD4
                eori.b  #$80,d0

loc_20CCD4:                             ; CODE XREF: sub_20CCAA+24↑j
                andi.b  #$80,d0
                bne.s   loc_20CCE2
                move.b  #3,obPriority(a0)
                bra.s   loc_20CCE8
; ---------------------------------------------------------------------------

loc_20CCE2:                             ; CODE XREF: sub_20CCAA+2E↑j
                move.b  #5,obPriority(a0)

loc_20CCE8:                             ; CODE XREF: sub_20CCAA+36↑j
                bra.w   sub_20CE72
; End of function sub_20CCAA


; =============== S U B R O U T I N E =======================================


sub_20CCEC:                             ; CODE XREF: sub_20CBF8+A6↑p
                move.w  objoff_34(a0),d0
                cmpi.w  #$4000,d0
                bcc.s   loc_20CD08
                move.w  #$4000,d1
                sub.w   d0,d1
                addi.w  #$4000,d1
                move.w  d1,objoff_34(a0)
                bra.w   locret_20CD3E
; ---------------------------------------------------------------------------

loc_20CD08:                             ; CODE XREF: sub_20CCEC+8↑j
                cmpi.w  #$8000,d0
                bcc.s   loc_20CD1C
                move.w  #$8000,d1
                sub.w   d0,d1
                move.w  d1,objoff_34(a0)
                bra.w   locret_20CD3E
; ---------------------------------------------------------------------------

loc_20CD1C:                             ; CODE XREF: sub_20CCEC+20↑j
                cmpi.w  #$C000,d0
                bcc.s   loc_20CD30
                move.w  #$8000,d1
                sub.w   d0,d1
                move.w  d1,objoff_34(a0)
                bra.w   locret_20CD3E
; ---------------------------------------------------------------------------

loc_20CD30:                             ; CODE XREF: sub_20CCEC+34↑j
                move.w  #$8000,d1
                sub.w   d0,d1
                move.w  d1,objoff_34(a0)
                bra.w   *+4
; ---------------------------------------------------------------------------

locret_20CD3E:                          ; CODE XREF: sub_20CCEC+18↑j
                                        ; sub_20CCEC+2C↑j ...
                rts
; End of function sub_20CCEC

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_20CBF8

loc_20CD40:                             ; CODE XREF: sub_20CBF8+36↑j
                                        ; DATA XREF: ROM:0020C9D0↑o
                bsr.w   sub_20CDE0
                movea.w objoff_2E(a0),a1
                move.l  obX(a1),obX(a0)
                move.l  obY(a1),obY(a0)
                subi.l  #$10000,objoff_3C(a0)
                subi.l  #$10000,obVelX(a0)
                cmpi.l  #$100000,objoff_3C(a0)
                bgt.s   loc_20CDA0
                moveq   #0,d0
                moveq   #0,d1
                move.b  objoff_2D(a1),d0
                add.w   d0,d0
                move.w  word_20CDBE(pc,d0.w),d0
                move.b  objoff_32(a1),d1
                mulu.w  d0,d1
                move.w  d1,objoff_34(a0)
                addq.b  #1,objoff_32(a1)
                move.l  #$100000,objoff_3C(a0)
                move.l  #$100000,obVelX(a0)
                move.b  #6,obRoutine(a0)

loc_20CDA0:                             ; CODE XREF: sub_20CBF8+174↑j
                bsr.w   sub_20CDE0
                btst    #3,objoff_2C(a1)
                beq.s   loc_20CDB4
                addi.w  #$480,objoff_34(a0)
                bra.s   loc_20CDBA
; ---------------------------------------------------------------------------

loc_20CDB4:                             ; CODE XREF: sub_20CBF8+1B2↑j
                subi.w  #$480,objoff_34(a0)

loc_20CDBA:                             ; CODE XREF: sub_20CBF8+1BA↑j
                bra.w   sub_20CE72
; END OF FUNCTION CHUNK FOR sub_20CBF8
; ---------------------------------------------------------------------------
word_20CDBE:    dc.w 0                  ; DATA XREF: sub_20CBF8+180↑r
                dc.w 0
                dc.w $8000
                dc.w $5555
                dc.w $4000
                dc.w $3333
                dc.w $2AAA
                dc.w $2492
                dc.w $2000
                dc.w $1C71
                dc.w $1999
                dc.w $1745
                dc.w $1555
                dc.w $13B1
                dc.w $1249
                dc.w $1111
                dc.w $1000

; =============== S U B R O U T I N E =======================================


sub_20CDE0:                             ; CODE XREF: sub_20CB44+8↑p
                                        ; sub_20CBF8:loc_20CC32↑p ...
                movea.w objoff_2E(a0),a1
                cmpi.b  #$14,obRoutine(a1)
                beq.w   loc_20CE0C
                tst.b   obColType(a0)
                beq.s   loc_20CDF6
                rts
; ---------------------------------------------------------------------------

loc_20CDF6:                             ; CODE XREF: sub_20CDE0+12↑j
                bset    #6,objoff_2C(a1)
                beq.s   loc_20CE0C
                move.b  #$FF,obColType(a0)
                move.b  #2,obColProp(a0)
                rts
; ---------------------------------------------------------------------------

loc_20CE0C:                             ; CODE XREF: sub_20CDE0+A↑j
                                        ; sub_20CDE0+1C↑j
                move.b  #$C,obRoutine(a0)
                move.b  #4,obAnim(a0)
                clr.b   obFrame(a0)
                clr.b   obAniFrame(a0)
                clr.b   obTimeFrame(a0)
                clr.b   obDelayAni(a0)
                subq.b  #1,objoff_2D(a1)
                bra.w   *+4
; ---------------------------------------------------------------------------

loc_20CE30:                             ; CODE XREF: sub_20CDE0+4C↑j
                                        ; DATA XREF: ROM:0020C9CC↑o
                lea     (off_20D12C).l,a1
                jmp     AnimateObject
; End of function sub_20CDE0

; ---------------------------------------------------------------------------

loc_20CE3C:                             ; CODE XREF: ROM:0020CA54↑j
                                        ; DATA XREF: ROM:0020C9CE↑o
                addq.l  #4,sp
                jmp     DeleteObject
; ---------------------------------------------------------------------------
                move.b  objoff_34(a0),d0
                subi.b  #$40,d0 ; '@'
                movea.w objoff_2E(a0),a1
                btst    #3,objoff_2C(a1)
                beq.s   loc_20CE5C
                eori.b  #$80,d0

loc_20CE5C:                             ; CODE XREF: ROM:0020CE56↑j
                andi.b  #$80,d0
                bne.s   loc_20CE6A
                move.b  #3,obPriority(a0)
                bra.s   locret_20CE70
; ---------------------------------------------------------------------------

loc_20CE6A:                             ; CODE XREF: ROM:0020CE60↑j
                move.b  #5,obPriority(a0)

locret_20CE70:                          ; CODE XREF: ROM:0020CE68↑j
                rts

; =============== S U B R O U T I N E =======================================


sub_20CE72:                             ; CODE XREF: sub_20C58C+30↑p
                                        ; sub_20C5D4+30↑p ...
                move.b  objoff_34(a0),d0
                jsr     GetSine
                moveq   #0,d3
                moveq   #0,d2
                move.w  objoff_3C(a0),d3
                move.w  obVelX(a0),d2
                muls.w  d0,d2
                muls.w  d1,d3
                asr.w   #8,d2
                asr.w   #8,d3
                move.w  d3,objoff_38(a0)
                move.w  d2,objoff_3A(a0)
                add.w   d3,obX(a0)
                add.w   d2,obY(a0)
                rts
; End of function sub_20CE72


; =============== S U B R O U T I N E =======================================


sub_20CEA2:                             ; CODE XREF: sub_20C4BE+12↑p
                bsr.w   sub_20CEAE
                move.b  #1,ob2ndRout(a1)
                rts
; End of function sub_20CEA2


; =============== S U B R O U T I N E =======================================


sub_20CEAE:                             ; CODE XREF: sub_20C4BE+36↑p
                                        ; sub_20CEA2↑p
                movea.l a0,a3
                jsr     Create_New_Sprite
                bne.w   locret_20CED0
                move.w  a3,objoff_2E(a1)
                move.b  #id_UnkBubbles,oID(a1) ; 'O'
                move.w  obX(a0),obX(a1)
                move.w  #$5B8,obY(a1)

locret_20CED0:                          ; CODE XREF: sub_20CEAE+8↑j
                rts
; End of function sub_20CEAE


; =============== S U B R O U T I N E =======================================


sub_20CED2:                             ; CODE XREF: ROM:0020C46A↑p
                movea.l a0,a3
                jsr     Create_New_Sprite
                bne.w   locret_20CEF8
                move.w  a1,objoff_30(a3)
                move.w  a3,objoff_2E(a1)
                move.b  #id_8D,oID(a1) ; 'M'
                move.w  obX(a0),obX(a1)
                move.w  obY(a0),obY(a1)

locret_20CEF8:                          ; CODE XREF: sub_20CED2+8↑j
                rts
; End of function sub_20CED2


; =============== S U B R O U T I N E =======================================


sub_20CEFA:                             ; CODE XREF: sub_20C58C+12↑p
                                        ; sub_20C5D4+12↑p ...
                lea     (word_20CF5A).l,a2
                moveq   #3,d0

loc_20CF02:                             ; CODE XREF: sub_20CEFA+56↓j
                movem.l d0/a2,-(sp)
                jsr     Create_New_Sprite
                movem.l (sp)+,d0/a2
                bne.s   loc_20CF56
                move.w  a0,objoff_2E(a1)
                move.b  #id_8F,oID(a1) ; 'N'
                move.w  obX(a0),obX(a1)
                move.w  obY(a0),obY(a1)
                move.b  (a2)+,d1
                ext.w   d1
                move.b  (a2)+,d2
                ext.w   d2
                move.l  (a2)+,d3
                move.l  (a2)+,d4
                btst    #0,obStatus(a0)
                beq.s   loc_20CF40
                neg.w   d1
                neg.l   d3

loc_20CF40:                             ; CODE XREF: sub_20CEFA+40↑j
                move.w  d1,objoff_38(a1)
                move.w  d2,objoff_3A(a1)
                move.l  d3,objoff_3C(a1)
                move.l  d4,obVelX(a1)
                dbf     d0,loc_20CF02
                bra.s   locret_20CF58
; ---------------------------------------------------------------------------

loc_20CF56:                             ; CODE XREF: sub_20CEFA+16↑j
                nop

locret_20CF58:                          ; CODE XREF: sub_20CEFA+5A↑j
                rts
; End of function sub_20CEFA

; ---------------------------------------------------------------------------
word_20CF5A:    dc.w $E317              ; DATA XREF: sub_20CEFA↑o
                dc.l $FFFEC398, $13C68, $FA1F0000, 1, $C000101C, $E000
                dc.l $183F7, $1D110001, $3C680001
                dc.b $3C, $68

UnkTTZBossItem: include "_maps/UnkTTZBossItemMap.asm"
                even
UnkBubbles:     include "_maps/UnkBubbles.asm"
                even 
UnkMapTTZBoss2: include "_maps/UnkMapTTZBoss2.asm"
                even                                            
off_20D12C:     dc.w unk_20D136-*       ; DATA XREF: ROM:loc_20CAD4↑o
                                        ; sub_20CB44:loc_20CBEA↑o ...
                dc.w unk_20D13D-off_20D12C
                dc.w unk_20D140-off_20D12C
                dc.w unk_20D145-off_20D12C
                dc.w unk_20D148-off_20D12C
unk_20D136:     dc.b   9                ; DATA XREF: ROM:off_20D12C↑o
                dc.b   0
                dc.b   1
                dc.b   2
                dc.b   3
                dc.b   4
                dc.b $FF
unk_20D13D:     dc.b $FF                ; DATA XREF: ROM:0020D12E↑o
                dc.b   4
                dc.b $FF
unk_20D140:     dc.b $13                ; DATA XREF: ROM:0020D130↑o
                dc.b   4
                dc.b   5
                dc.b   6
                dc.b $FF
unk_20D145:     dc.b $FF                ; DATA XREF: ROM:0020D132↑o
                dc.b   6
                dc.b $FF
unk_20D148:     dc.b $13                ; DATA XREF: ROM:0020D134↑o
                dc.b   7
                dc.b   8
                dc.b $FC
                even                
; =============== S U B R O U T I N E =======================================

ObjUnk_2:
sub_20CF82:                             ; DATA XREF: ROM:00203F08↑o
                moveq   #0,d0
                move.b  obRoutine(a0),d0
                move.w  off_20CFA2(pc,d0.w),d0
                jsr     off_20CFA2(pc,d0.w)
                lea     (off_20D116).l,a1
                jsr     AnimateObject
                jmp     DrawObject
; End of function sub_20CF82

; ---------------------------------------------------------------------------
off_20CFA2:     dc.w loc_20CFA8-*       ; CODE XREF: sub_20CF82+A↑p
                                        ; DATA XREF: sub_20CF82+6↑r ...
                 dc.w loc_20CFD2-off_20CFA2
                 dc.w sub_20D018-off_20CFA2
; ---------------------------------------------------------------------------

loc_20CFA8:                             ; DATA XREF: ROM:off_20CFA2↑o
                addq.b  #2,obRoutine(a0)
                move.b  #4,obRender(a0)
                move.b  #6,obPriority(a0)
                move.b  #4,obActWid(a0)
                move.b  #4,obHeight(a0)
                move.w  #$31E,obGfx(a0)
                move.l  #UnkMapTTZBoss2,obMap(a0)
loc_20CFD2:                
                movea.w objoff_2E(a0),a1
                btst    #7,objoff_2C(a1)
                bne.s   loc_20D03C
                move.w  obX(a1),obX(a0)
                move.w  obY(a1),obY(a0)
                move.w  objoff_38(a0),d0
                add.w   d0,obX(a0)
                move.w  objoff_3A(a0),d0
                add.w   d0,obY(a0)
                addq.b  #1,objoff_2A(a0)
                cmpi.b  #$2D,objoff_2A(a0) ; '-'
                bne.s   locret_20D016
                move.b  #$FE,obColType(a0)
                move.b  #2,obColProp(a0)
                addq.b  #2,obRoutine(a0)

locret_20D016:                          ; CODE XREF: ROM:0020D004↑j
                rts
; ---------------------------------------------------------------------------
sub_20D018:
                movea.w objoff_2E(a0),a1
                btst    #7,objoff_2C(a1)
                bne.s   loc_20D03C
                move.l  objoff_3C(a0),d0
                add.l   d0,obX(a0)
                move.l  obVelX(a0),d0
                add.l   d0,obY(a0)
                bsr.w   sub_20D044
                bne.s   loc_20D03C
                rts
; ---------------------------------------------------------------------------

loc_20D03C:                             ; CODE XREF: ROM:0020CFDC↑j
                                        ; ROM:0020D022↑j ...
                addq.l  #4,sp
                jmp     DeleteObject

; =============== S U B R O U T I N E =======================================


sub_20D044:                             ; CODE XREF: ROM:0020D034↑p
                cmpi.w  #$9A0,obX(a0)
                blt.s   loc_20D060
                cmpi.w  #$B00,obX(a0)
                bgt.s   loc_20D060
                cmpi.w  #$5D0,obY(a0)
                bgt.s   loc_20D060
                moveq   #0,d0
                rts
; ---------------------------------------------------------------------------

loc_20D060:                             ; CODE XREF: sub_20D044+6↑j
                                        ; sub_20D044+E↑j ...
                moveq   #$FFFFFFFF,d0
                rts
; End of function sub_20D044

; ---------------------------------------------------------------------------
off_20D064:     dc.w unk_20D06C-*       ; DATA XREF: sub_20C3CE+3C↑o
                                        ; ROM:0020D066↓o ...
                dc.w unk_20D06F-off_20D064
                dc.w unk_20D073-off_20D064
                dc.w unk_20D076-off_20D064
unk_20D06C:     dc.b $FF                ; DATA XREF: ROM:off_20D064↑o
                dc.b   0
                dc.b $FF
unk_20D06F:     dc.b   7                ; DATA XREF: ROM:0020D066↑o
                dc.b   1
                dc.b   2
                dc.b $FF
unk_20D073:     dc.b $FF                ; DATA XREF: ROM:0020D068↑o
                dc.b   3
                dc.b $FF
unk_20D076:     dc.b   3                ; DATA XREF: ROM:0020D06A↑o
                dc.b   5
                dc.b   4
                dc.b   6
                dc.b   4
                dc.b $FF
                dc.b   0
                dc.b  $E
                dc.b   0
                dc.b $1A
                dc.b   0
                dc.b $26 ; &
                dc.b   0
                dc.b $32 ; 2
                dc.b   0
                dc.b $3E ; >
                dc.b   0
                dc.b $4A ; J
                dc.b   0
                dc.b $5A ; Z
                dc.b   2
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $38 ; 8
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $40 ; @
                dc.b   0
                dc.b   0
                dc.b   2
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $44 ; D
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $4C ; L
                dc.b   0
                dc.b   0
                dc.b   2
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $50 ; P
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $58 ; X
                dc.b   0
                dc.b   0
                dc.b   2
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $5C ; \
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $64 ; d
                dc.b   0
                dc.b   0
                dc.b   2
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $68 ; h
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $70 ; p
                dc.b   0
                dc.b   0
                dc.b   3
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $68 ; h
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $70 ; p
                dc.b   0
                dc.b $D4
                dc.b   5
                dc.b   8
                dc.b $F2
                dc.b   4
                dc.b   3
                dc.b $E4
                dc.b  $D
                dc.b   0
                dc.b $68 ; h
                dc.b $E0
                dc.b $E4
                dc.b   5
                dc.b   0
                dc.b $70 ; p
                dc.b   0
                dc.b $D4
                dc.b   5
                dc.b   8
                dc.b $F6
                dc.b   4
                even                
off_20D116:     dc.w unk_20D118-*       ; DATA XREF: sub_20CF82+E↑o
unk_20D118:     dc.b   1                ; DATA XREF: ROM:off_20D116↑o
                dc.b   0
                dc.b   1
                dc.b $FF
                dc.b   0
                dc.b   4
                dc.b   0
                dc.b  $A
                dc.b   1
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b $AC
                dc.b $FC
                dc.b   1
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b $AD
                dc.b $FC
                even            
dword_202BA4:   dc.l $40000, $D970000, $8000060, $5003B0, $EA0046C, $175000BD
                                         ; DATA XREF: sub_202B48+1A↑o
                 dc.l $A00062C, $BB0004C, $1570016C, $1B0072C, $140002AC                    