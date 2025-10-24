ObjTTZBoss:                             ; DATA XREF: ROM:00203EF8↑o
                moveq   #0,d0
                move.b  obRoutine(a0),d0
                move.w  off_20BA94(pc,d0.w),d0
                jsr     off_20BA94(pc,d0.w)
                lea     (off_20C208).l,a1
                tst.b   objoff_2D(a0)
                beq.s   loc_20BA88
                subq.b  #1,objoff_2D(a0)
                addq.b  #3,obAnim(a0)
                jsr     AnimateObject
                subq.b  #3,obAnim(a0)
                jmp     DrawObject
; ---------------------------------------------------------------------------

loc_20BA88:                             ; CODE XREF: ObjTTZBoss+18↑j
                
                jsr     AnimateObject
                jmp     DrawObject
; End of function ObjTTZBoss

; ---------------------------------------------------------------------------
off_20BA94:     dc.w loc_20BA9E-*       ; CODE XREF: ObjTTZBoss+A↑p
                                        ; DATA XREF: ObjTTZBoss+6↑r ...
                dc.w loc_20BB06-off_20BA94
                dc.w loc_20C0FE-off_20BA94
                dc.w sub_20BDE6-off_20BA94
                dc.w sub_20BFCA-off_20BA94
; ---------------------------------------------------------------------------

loc_20BA9E:                             ; DATA XREF: ROM:off_20BA94↑o
                move.b  #$3D,obColType(a0) ; '='
                move.b  #5,obColProp(a0)
                clr.b   obStatus(a0)
                bset    #0,obStatus(a0)
                move.b  #8,obRoutine(a0)
                move.b  #4,obRender(a0)
                move.b  #6,obPriority(a0)
                move.b  #$24,obActWid(a0) ; '$'
                move.b  #$38,obHeight(a0) ; '8'
                move.w  #$31E,obGfx(a0)
                move.l  #MapTTZBoss,obMap(a0)
                move.l  #$1C000,objoff_3C(a0)
                move.l  #$13C68,obVelX(a0)
                move.w  #5,d0
                movem.l d7-a7,-(sp)
                jsr     sub_2004AC
                movem.l (sp)+,d7-a7
                moveq   #plcid_TTZBoss,d0
                jsr     sub_202774
                bra.w   loc_20BFEC
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_20BDE6

loc_20BB06:                             ; CODE XREF: sub_20BDE6:loc_20BEA6↓j
                                        ; DATA XREF: ROM:0020BA96↑o
                move.w  objoff_38(a0),d0
                sub.w   d0,obY(a0)
                bsr.w   sub_20BEEA
                btst    #7,ob2ndRout(a0)
                beq.s   loc_20BB22
                lea     (unk_20C0D4).l,a1
                bra.s   loc_20BB38
; ---------------------------------------------------------------------------

loc_20BB22:                             ; CODE XREF: sub_20BDE6-2CE↑j
                btst    #6,ob2ndRout(a0)
                beq.s   loc_20BB32
                lea     (unk_20C0E6).l,a1
                bra.s   loc_20BB38
; ---------------------------------------------------------------------------

loc_20BB32:                             ; CODE XREF: sub_20BDE6-2BE↑j
                lea     (unk_20C062).l,a1

loc_20BB38:                             ; CODE XREF: sub_20BDE6-2C6↑j
                                        ; sub_20BDE6-2B6↑j
                moveq   #0,d0
                move.b  ob2ndRout(a0),d0
                andi.b  #$3F,d0 ; '?'
                mulu.w  #6,d0
                adda.w  d0,a1
                move.b  oID(a1),d0
                cmpi.b  #0,d0
                beq.w   loc_20BB90
                cmpi.b  #1,d0
                beq.w   loc_20BBB8
                cmpi.b  #5,d0
                beq.w   loc_20BBE0
                cmpi.b  #6,d0
                beq.w   loc_20BC12
                cmpi.b  #7,d0
                beq.w   loc_20BC5C
                cmpi.b  #2,d0
                beq.w   loc_20BCA6
                cmpi.b  #3,d0
                beq.w   loc_20BCD8
                cmpi.b  #4,d0
                beq.w   loc_20BD22

loc_20BB8C:                             ; CODE XREF: sub_20BDE6:loc_20BB8C↓j
                bra.w   loc_20BB8C
; ---------------------------------------------------------------------------

loc_20BB90:                             ; CODE XREF: sub_20BDE6-296↑j
                move.b  #1,obAnim(a0)
                bclr    #0,obStatus(a0)
                move.l  objoff_3C(a0),d2
                add.l   d2,obX(a0)
                move.w  obGfx(a1),d0
                cmp.w   obX(a0),d0
                bgt.w   loc_20BEC4
                move.w  d0,obX(a0)
                bra.w   loc_20BD6C
; ---------------------------------------------------------------------------

loc_20BBB8:                             ; CODE XREF: sub_20BDE6-28E↑j
                move.b  #1,obAnim(a0)
                bset    #0,obStatus(a0)
                move.l  objoff_3C(a0),d2
                sub.l   d2,obX(a0)
                move.w  obGfx(a1),d0
                cmp.w   obX(a0),d0
                blt.w   loc_20BEC4
                move.w  d0,obX(a0)
                bra.w   loc_20BD6C
; ---------------------------------------------------------------------------

loc_20BBE0:                             ; CODE XREF: sub_20BDE6-286↑j
                move.b  #0,obAnim(a0)
                move.l  objoff_3C(a0),d2
                add.l   d2,obY(a0)
                move.w  obMap(a1),d0
                cmp.w   obY(a0),d0
                bgt.w   loc_20BEE0
                cmpi.w  #$880,d0
                beq.s   loc_20BC08
                move.w  d0,obY(a0)
                bra.w   loc_20BD6C
; ---------------------------------------------------------------------------

loc_20BC08:                             ; CODE XREF: sub_20BDE6-1E8↑j
                move.w  #$80,obY(a0)
                bra.w   loc_20BD6C
; ---------------------------------------------------------------------------

loc_20BC12:                             ; CODE XREF: sub_20BDE6-27E↑j
                move.b  #2,obAnim(a0)
                bset    #0,obStatus(a0)
                moveq   #0,d1
                move.l  obVelX(a0),d2
                add.l   d2,obY(a0)
                move.w  obMap(a1),d0
                cmp.w   obY(a0),d0
                bgt.w   loc_20BC3A
                move.w  d0,obY(a0)
                addq.l  #1,d1

loc_20BC3A:                             ; CODE XREF: sub_20BDE6-1B6↑j
                sub.l   d2,obX(a0)
                move.w  obGfx(a1),d0
                cmp.w   obX(a0),d0
                blt.w   loc_20BC50
                move.w  d0,obX(a0)
                addq.l  #1,d1

loc_20BC50:                             ; CODE XREF: sub_20BDE6-1A0↑j
                cmpi.w  #2,d1
                beq.w   loc_20BD6C
                bra.w   loc_20BEE0
; ---------------------------------------------------------------------------

loc_20BC5C:                             ; CODE XREF: sub_20BDE6-276↑j
                move.b  #2,obAnim(a0)
                bclr    #0,obStatus(a0)
                moveq   #0,d1
                move.l  obVelX(a0),d2
                add.l   d2,obY(a0)
                move.w  obMap(a1),d0
                cmp.w   obY(a0),d0
                bgt.w   loc_20BC84
                move.w  d0,obY(a0)
                addq.l  #1,d1

loc_20BC84:                             ; CODE XREF: sub_20BDE6-16C↑j
                add.l   d2,obX(a0)
                move.w  obGfx(a1),d0
                cmp.w   obX(a0),d0
                bgt.w   loc_20BC9A
                move.w  d0,obX(a0)
                addq.l  #1,d1

loc_20BC9A:                             ; CODE XREF: sub_20BDE6-156↑j
                cmpi.w  #2,d1
                beq.w   loc_20BD6C
                bra.w   loc_20BEE0
; ---------------------------------------------------------------------------

loc_20BCA6:                             ; CODE XREF: sub_20BDE6-26E↑j
                move.b  #0,obAnim(a0)
                move.l  objoff_3C(a0),d2
                sub.l   d2,obY(a0)
                move.w  obMap(a1),d0
                cmp.w   obY(a0),d0
                blt.w   loc_20BEE0
                cmpi.w  #$FF40,d0
                beq.s   loc_20BCCE
                move.w  d0,obY(a0)
                bra.w   loc_20BD6C
; ---------------------------------------------------------------------------

loc_20BCCE:                             ; CODE XREF: sub_20BDE6-122↑j
                move.w  #$740,obY(a0)
                bra.w   loc_20BD6C
; ---------------------------------------------------------------------------

loc_20BCD8:                             ; CODE XREF: sub_20BDE6-266↑j
                move.b  #2,obAnim(a0)
                bset    #0,obStatus(a0)
                moveq   #0,d1
                move.l  objoff_3C(a0),d2
                sub.l   d2,obY(a0)
                move.w  obMap(a1),d0
                cmp.w   obY(a0),d0
                blt.w   loc_20BD00
                move.w  d0,obY(a0)
                addq.l  #1,d1

loc_20BD00:                             ; CODE XREF: sub_20BDE6-F0↑j
                sub.l   d2,obX(a0)
                move.w  obGfx(a1),d0
                cmp.w   obX(a0),d0
                blt.w   loc_20BD16
                move.w  d0,obX(a0)
                addq.l  #1,d1

loc_20BD16:                             ; CODE XREF: sub_20BDE6-DA↑j
                cmpi.w  #2,d1
                beq.w   loc_20BD6C
                bra.w   loc_20BEE0
; ---------------------------------------------------------------------------

loc_20BD22:                             ; CODE XREF: sub_20BDE6-25E↑j
                moveq   #0,d1
                move.l  objoff_3C(a0),d2
                sub.l   d2,obY(a0)
                move.w  obMap(a1),d0
                cmp.w   obY(a0),d0
                blt.w   loc_20BD3E
                move.w  d0,obY(a0)
                addq.l  #1,d1

loc_20BD3E:                             ; CODE XREF: sub_20BDE6-B2↑j
                add.l   d2,obX(a0)
                move.w  obGfx(a1),d0
                cmp.w   obX(a0),d0
                bgt.w   loc_20BD54
                move.w  d0,obX(a0)
                addq.l  #1,d1

loc_20BD54:                             ; CODE XREF: sub_20BDE6-9C↑j
                move.b  #2,obAnim(a0)
                bclr    #0,obStatus(a0)
                cmpi.w  #2,d1
                beq.w   loc_20BD6C
                bra.w   loc_20BEE0
; ---------------------------------------------------------------------------

loc_20BD6C:                             ; CODE XREF: sub_20BDE6-232↑j
                                        ; sub_20BDE6-20A↑j ...
                tst.b   obRender(a1)
                beq.s   loc_20BDCC
                tst.b   obColProp(a0)
                bne.w   loc_20BDCC
                cmpi.b  #1,obRender(a1)
                beq.s   loc_20BDA0
                cmpi.b  #2,obRender(a1)
                beq.s   loc_20BDB6
                move.l  #$38000,objoff_3C(a0)
                move.b  #4,obRoutine(a0)
                move.b  #0,obAnim(a0)
                rts
; ---------------------------------------------------------------------------

loc_20BDA0:                             ; CODE XREF: sub_20BDE6-66↑j
                move.b  #$80,ob2ndRout(a0)
                movea.w objoff_30(a0),a1
                movea.w objoff_32(a1),a1
                move.b  #1,objoff_3F(a1)
                rts
; ---------------------------------------------------------------------------

loc_20BDB6:                             ; CODE XREF: sub_20BDE6-5E↑j
                move.b  #$40,ob2ndRout(a0) ; '@'
                movea.w objoff_30(a0),a1
                movea.w objoff_34(a1),a1
                move.b  #1,objoff_3F(a1)
                rts
; ---------------------------------------------------------------------------

loc_20BDCC:                             ; CODE XREF: sub_20BDE6-76↑j
                                        ; sub_20BDE6-70↑j
                addq.b  #1,ob2ndRout(a0)
                move.b  ob2ndRout(a0),d0
                andi.b  #$3F,d0 ; '?'
                cmpi.b  #$13,d0
                blt.s   locret_20BDE4
                andi.b  #$C0,ob2ndRout(a0)

locret_20BDE4:                          ; CODE XREF: sub_20BDE6-A↑j
                rts
; END OF FUNCTION CHUNK FOR sub_20BDE6

; =============== S U B R O U T I N E =======================================


sub_20BDE6:                             ; DATA XREF: ROM:0020BA9A↑o

; FUNCTION CHUNK AT 0020BB06 SIZE 000002E0 BYTES

                bsr.w   sub_20BF80
                lea     (v_objspace).w,a1
                moveq   #0,d1
                moveq   #0,d2
                move.w  obX(a1),d1
                sub.w   obX(a0),d1
                bge.s   loc_20BDFE
                neg.w   d1

loc_20BDFE:                             ; CODE XREF: sub_20BDE6+14↑j
                move.w  obY(a1),d2
                sub.w   obY(a0),d2
                bge.s   loc_20BE0A
                neg.w   d2

loc_20BE0A:                             ; CODE XREF: sub_20BDE6+20↑j
                mulu.w  d1,d1
                mulu.w  d2,d2
                add.l   d2,d1
                btst    #5,objoff_2E(a0)
                beq.s   loc_20BE28
                cmpi.l  #$5100,d1
                bge.w   loc_20BEAA
                bclr    #5,objoff_2E(a0)

loc_20BE28:                             ; CODE XREF: sub_20BDE6+30↑j
                cmpi.l  #$11040,d1
                bge.w   loc_20BEAA
                cmpi.l  #$1E40,d1
                blt.w   loc_20BE6E
                cmpi.l  #$4840,d1
                blt.w   loc_20BE5A
                move.l  #$1C000,objoff_3C(a0)
                move.l  #$13C68,obVelX(a0)
                bra.w   loc_20BEA6
; ---------------------------------------------------------------------------

loc_20BE5A:                             ; CODE XREF: sub_20BDE6+5C↑j
                move.l  #$30000,objoff_3C(a0)
                move.l  #$21EF8,obVelX(a0)
                bra.w   loc_20BEA6
; ---------------------------------------------------------------------------

loc_20BE6E:                             ; CODE XREF: sub_20BDE6+52↑j
                cmpi.w  #$800,obVelY(a1)
                bgt.s   loc_20BE92
                cmpi.w  #$800,obVelX(a1)
                bgt.s   loc_20BE92
                move.l  #$80000,objoff_3C(a0)
                move.l  #$5A550,obVelX(a0)
                bra.w   loc_20BEA6
; ---------------------------------------------------------------------------

loc_20BE92:                             ; CODE XREF: sub_20BDE6+8E↑j
                                        ; sub_20BDE6+96↑j
                move.l  #$100000,objoff_3C(a0)
                move.l  #$B4E88,obVelX(a0)
                bra.w   *+4
; ---------------------------------------------------------------------------

loc_20BEA6:                             ; CODE XREF: sub_20BDE6+70↑j
                                        ; sub_20BDE6+84↑j ...
                bra.w   loc_20BB06
; ---------------------------------------------------------------------------

loc_20BEAA:                             ; CODE XREF: sub_20BDE6+38↑j
                                        ; sub_20BDE6+48↑j
                bset    #5,objoff_2E(a0)
                move.w  objoff_38(a0),d0
                sub.w   d0,obY(a0)
                move.b  #0,obAnim(a0)
                bra.w   loc_20BEC4
; ---------------------------------------------------------------------------
                rts
; ---------------------------------------------------------------------------

loc_20BEC4:                             ; CODE XREF: sub_20BDE6-23A↑j
                                        ; sub_20BDE6-212↑j ...
                moveq   #0,d0
                addq.b  #2,objoff_2F(a0)
                move.b  objoff_2F(a0),d0
                jsr     GetSine
                asr.w   #5,d0
                move.w  d0,objoff_38(a0)
                add.w   d0,obY(a0)
                rts
; ---------------------------------------------------------------------------

loc_20BEE0:                             ; CODE XREF: sub_20BDE6-1F0↑j
                                        ; sub_20BDE6-18E↑j ...
                move.w  objoff_38(a0),d0
                add.w   d0,obY(a0)
                rts
; End of function sub_20BDE6


; =============== S U B R O U T I N E =======================================


sub_20BEEA:                             ; CODE XREF: sub_20BDE6-2D8↑p
                tst.b   objoff_2C(a0)
                beq.s   loc_20BF06
                subq.b  #1,objoff_2C(a0)
                bne.s   loc_20BF06
                move.l  #$1C000,objoff_3C(a0)
                move.l  #$13C68,obVelX(a0)

loc_20BF06:                             ; CODE XREF: sub_20BEEA+4↑j
                                        ; sub_20BEEA+A↑j
                tst.b   obColProp(a0)
                beq.w   locret_20BF7E
                tst.b   objoff_2B(a0)
                bne.s   loc_20BF20
                tst.b   obColType(a0)
                beq.w   loc_20BF32
                bra.w   locret_20BF7E
; ---------------------------------------------------------------------------

loc_20BF20:                             ; CODE XREF: sub_20BEEA+28↑j
                subq.b  #1,objoff_2B(a0)
                bne.w   locret_20BF7E
                move.b  #$3D,obColType(a0) ; '='
                bra.w   locret_20BF7E
; ---------------------------------------------------------------------------

loc_20BF32:                             ; CODE XREF: sub_20BEEA+2E↑j
                ;move.w  #$AC,d0
                ;jsr     PlaySound
                movea.w objoff_30(a0),a1
                move.b  #$28,objoff_2A(a1) ; '('
                move.b  #$46,objoff_2C(a0) ; 'F'
                move.l  #$48000,objoff_3C(a0)
                move.l  #$32C80,obVelX(a0)
                move.b  #$10,objoff_2D(a0)
                cmpi.b  #1,obColProp(a0)
                beq.s   loc_20BF74
                move.b  #$1E,objoff_2B(a0)
                bra.w   locret_20BF7E
; ---------------------------------------------------------------------------

loc_20BF74:                             ; CODE XREF: sub_20BEEA+7E↑j
                move.b  #6,obRoutine(a0)
                clr.b   obColProp(a0)

locret_20BF7E:                          ; CODE XREF: sub_20BEEA+20↑j
                                        ; sub_20BEEA+32↑j ...
                rts
; End of function sub_20BEEA


; =============== S U B R O U T I N E =======================================


sub_20BF80:                             ; CODE XREF: sub_20BDE6↑p
                movea.w objoff_30(a0),a1
                move.b  #$1E,objoff_2A(a1)
                tst.b   objoff_2A(a0)
                bne.s   loc_20BF9A
                move.b  #$20,objoff_2A(a0) ; ' '
                bsr.w   sub_20BFA0

loc_20BF9A:                             ; CODE XREF: sub_20BF80+E↑j
                subq.b  #1,objoff_2A(a0)
                rts
; End of function sub_20BF80


; =============== S U B R O U T I N E =======================================


sub_20BFA0:                             ; CODE XREF: sub_20BF80+16↑p
                jsr     Create_New_Sprite
                bne.s   locret_20BFC8
                st      ob2ndRout(a1)
                move.b  #id_ExplosionBomb,oID(a1)
                move.w  obX(a0),obX(a1)
                move.w  obY(a0),obY(a1)
                move.w  #sfx_Bomb,d0
                jsr     PlaySound

locret_20BFC8:                          ; CODE XREF: sub_20BFA0+6↑j
                rts
; End of function sub_20BFA0


; =============== S U B R O U T I N E =======================================


sub_20BFCA:                             ; DATA XREF: ROM:0020BA9C↑o
                lea     (v_objspace).w,a1
                cmpi.w  #$478,obX(a1)
                blt.s   locret_20BFEA
                move.b  #2,obRoutine(a0)
                move.b  #4,(f_lockscreen).w
                move.l  #$32C80,obVelX(a0)

locret_20BFEA:                          ; CODE XREF: sub_20BFCA+A↑j
                rts
; End of function sub_20BFCA

; ---------------------------------------------------------------------------

loc_20BFEC:                             ; CODE XREF: ROM:0020BB02↑j
                movea.l a0,a3
                jsr     Create_New_Sprite
                bne.w   locret_20C012
                move.w  a1,objoff_30(a3)
                move.w  a3,objoff_30(a1)
                move.b  #id_TTZBossHead,0(a1) ; 'K'
                move.w  obX(a0),obX(a1)
                move.w  obY(a0),obY(a1)

locret_20C012:                          ; CODE XREF: ROM:0020BFF4↑j
                rts

; =============== S U B R O U T I N E =======================================


sub_20C014:                             ; CODE XREF: ROM:0020C16E↓p
                jsr     Create_New_Sprite
                bne.w   locret_20C060
                move.w  a1,objoff_32(a0)
                move.b  #id_TTZDoor,oID(a1) ; $47
                move.b  #1,obSubtype(a1)
                move.w  #$760,obX(a1)
                move.w  #$2C0,obY(a1)
                jsr     Create_New_Sprite
                bne.w   locret_20C060
                move.w  a1,objoff_34(a0)
                move.b  #id_TTZDoor,oID(a1) ; $47
                move.b  #1,obSubtype(a1)
                move.w  #$6C0,obX(a1)
                move.w  #$460,obY(a1)

locret_20C060:                          ; CODE XREF: sub_20C014+6↑j
                                        ; sub_20C014+2C↑j
                rts
; End of function sub_20C014

; ---------------------------------------------------------------------------
unk_20C062:     dc.b   5                ; DATA XREF: sub_20BDE6:loc_20BB32↑o
                dc.b   0
                dc.b   4
                dc.b $D0
                dc.b   4
                dc.b $20
                dc.b   7
                dc.b   0
                dc.b   4
                dc.b $E0
                dc.b   4
                dc.b $30 ; 0
                dc.b   5
                dc.b   0
                dc.b   4
                dc.b $E0
                dc.b   4
                dc.b $60 ; `
                dc.b   0
                dc.b   2
                dc.b   6
                dc.b $3C ; <
                dc.b   4
                dc.b $60 ; `
                dc.b   5
                dc.b   0
                dc.b   6
                dc.b $3C ; <
                dc.b   5
                dc.b $20
                dc.b   1
                dc.b   0
                dc.b   5
                dc.b $60 ; `
                dc.b   5
                dc.b $20
                dc.b   5
                dc.b   0
                dc.b   5
                dc.b $60 ; `
                dc.b   5
                dc.b $D8
                dc.b   7
                dc.b   0
                dc.b   5
                dc.b $74 ; t
                dc.b   5
                dc.b $EC
                dc.b   5
                dc.b   0
                dc.b   5
                dc.b $74 ; t
                dc.b   8
                dc.b $80
                dc.b   5
                dc.b   0
                dc.b   5
                dc.b $74 ; t
                dc.b   1
                dc.b $28 ; (
                dc.b   7
                dc.b   0
                dc.b   5
                dc.b $F8
                dc.b   1
                dc.b $AC
                dc.b   0
                dc.b   0
                dc.b   6
                dc.b $74 ; t
                dc.b   1
                dc.b $AC
                dc.b   7
                dc.b   0
                dc.b   6
                dc.b $C4
                dc.b   1
                dc.b $FC
                dc.b   5
                dc.b   0
                dc.b   6
                dc.b $C4
                dc.b   2
                dc.b $70 ; p
                dc.b   7
                dc.b   0
                dc.b   6
                dc.b $E4
                dc.b   2
                dc.b $90
                dc.b   5
                dc.b   1
                dc.b   6
                dc.b $E4
                dc.b   2
                dc.b $B0
                dc.b   5
                dc.b   0
                dc.b   6
                dc.b $E4
                dc.b   2
                dc.b $EC
                dc.b   6
                dc.b   0
                dc.b   6
                dc.b $A0
                dc.b   3
                dc.b $30 ; 0
                dc.b   1
                dc.b   0
                dc.b   4
                dc.b $D0
                dc.b   3
                dc.b $30 ; 0
unk_20C0D4:     dc.b   0                ; DATA XREF: sub_20BDE6-2CC↑o
                dc.b   0
                dc.b   7
                dc.b $A0
                dc.b   2
                dc.b $B0
                dc.b   7
                dc.b   0
                dc.b   7
                dc.b $D0
                dc.b   2
                dc.b $E0
                dc.b   0
                dc.b   3
                dc.b   8
                dc.b $78 ; x
                dc.b   2
                dc.b $E0
unk_20C0E6:     dc.b   2                ; DATA XREF: sub_20BDE6-2BC↑o
                dc.b   0
                dc.b   6
                dc.b $3C ; <
                dc.b   4
                dc.b $40 ; @
                dc.b   0
                dc.b   0
                dc.b   7
                dc.b $40 ; @
                dc.b   4
                dc.b $40 ; @
                dc.b   4
                dc.b   0
                dc.b   7
                dc.b $A4
                dc.b   3
                dc.b $DC
                dc.b   0
                dc.b   3
                dc.b   8
                dc.b $78 ; x
                dc.b   3
                dc.b $DC
; ---------------------------------------------------------------------------

loc_20C0FE:                             ; DATA XREF: ROM:0020BA98↑o
                move.l  objoff_3C(a0),d0
                add.l   d0,obY(a0)
                addi.l  #$3000,objoff_3C(a0)
                cmpi.w  #$580,obY(a0)
                blt.s   locret_20C12E
                movea.w objoff_30(a0),a1
                addq.b  #2,obRoutine(a1)
                moveq   #plcid_Boss,d0
                jsr     sub_202774
                addq.l  #4,sp
                jmp     DeleteObject
; ---------------------------------------------------------------------------

locret_20C12E:                          ; CODE XREF: ROM:0020C114↑j
                rts
; =============== S U B R O U T I N E =======================================


ObjTTZBossHead:                         ; DATA XREF: ROM:00203EFC↑o
                moveq   #0,d0
                move.b  obRoutine(a0),d0
                move.w  off_20C13E(pc,d0.w),d0
                jmp     off_20C13E(pc,d0.w)
; End of function ObjTTZBossHead

; ---------------------------------------------------------------------------
off_20C13E:     dc.w loc_20C144-*       ; CODE XREF: ObjTTZBossHead+A↑j
                                        ; DATA XREF: ObjTTZBossHead+6↑r ...
                dc.w loc_20C172-off_20C13E
                dc.w loc_20C1C6-off_20C13E
; ---------------------------------------------------------------------------

loc_20C144:                             ; DATA XREF: ROM:off_20C13E↑o
                addq.b  #2,obRoutine(a0)
                move.b  #4,obRender(a0)
                move.b  #6,obPriority(a0)
                move.b  #$24,obActWid(a0) ; '$'
                move.b  #$38,obHeight(a0) ; '8'
                move.w  #$31E,obGfx(a0)
                move.l  #MapBossHead,obMap(a0)
                bsr.w   sub_20C014

loc_20C172:                             ; DATA XREF: ROM:0020C140↑o
                tst.b   objoff_2A(a0)
                beq.s   loc_20C19C
                subq.b  #1,objoff_2A(a0)
                beq.s   loc_20C186
                move.b  #1,obAnim(a0)
                bra.s   loc_20C19C
; ---------------------------------------------------------------------------

loc_20C186:                             ; CODE XREF: ROM:0020C17C↑j
                move.b  #0,obAnim(a0)
                clr.b   obFrame(a0)
                clr.b   obAniFrame(a0)
                clr.b   obTimeFrame(a0)
                clr.b   obDelayAni(a0)

loc_20C19C:                             ; CODE XREF: ROM:0020C176↑j
                                        ; ROM:0020C184↑j
                movea.w objoff_30(a0),a1
                move.w  obX(a1),obX(a0)
                move.w  obY(a1),obY(a0)
                move.b  obStatus(a1),obStatus(a0)
                lea     (off_20C394).l,a1
                jsr     AnimateObject
                jsr     DrawObject
                rts
; ---------------------------------------------------------------------------

loc_20C1C6:                             ; DATA XREF: ROM:0020C142↑o
                lea     (v_objspace).w,a1
                cmpi.w  #$840,obX(a1)
                blt.s   locret_20C206
                cmpi.w  #$550,obY(a1)
                blt.s   locret_20C206
                move.b  #4,(v_bossstatus).w
                movea.w objoff_32(a0),a1
                tst.b   oID(a1)
                beq.s   loc_20C1F0
                jmp     loc_203B40
; ---------------------------------------------------------------------------

loc_20C1F0:                             ; CODE XREF: ROM:0020C1E8↑j
                movea.w objoff_34(a0),a1
                tst.b   oID(a1)
                beq.s   loc_20C200
                jmp     loc_203B40
; ---------------------------------------------------------------------------

loc_20C200:                             ; CODE XREF: ROM:0020C1F8↑j
                jmp     DeleteObject
; ---------------------------------------------------------------------------

locret_20C206:                          ; CODE XREF: ROM:0020C1D0↑j
                                        ; ROM:0020C1D8↑j
                rts
; ---------------------------------------------------------------------------
off_20C208:     dc.w unk_20C214-*       ; DATA XREF: ObjTTZBoss+E↑o
                                        ; ROM:0020C20A↓o ...
                dc.w unk_20C218-off_20C208
                dc.w unk_20C21C-off_20C208
                dc.w unk_20C220-off_20C208
                dc.w unk_20C224-off_20C208
                dc.w unk_20C228-off_20C208
unk_20C214:     dc.b   3                ; DATA XREF: ROM:off_20C208↑o
                dc.b   0
                dc.b   1
                dc.b $FF
unk_20C218:     dc.b   3                ; DATA XREF: ROM:0020C20A↑o
                dc.b   2
                dc.b   3
                dc.b $FF
unk_20C21C:     dc.b   3                ; DATA XREF: ROM:0020C20C↑o
                dc.b   4
                dc.b   5
                dc.b $FF
unk_20C220:     dc.b   0                ; DATA XREF: ROM:0020C20E↑o
                dc.b   6
                dc.b   1
                dc.b $FF
unk_20C224:     dc.b   0                ; DATA XREF: ROM:0020C210↑o
                dc.b   7
                dc.b   3
                dc.b $FF
unk_20C228:     dc.b   0                ; DATA XREF: ROM:0020C212↑o
                dc.b   8
                dc.b   5
                dc.b $FF
MapTTZBoss: 
     include "_maps/MapTTZBoss.asm"
     even                
MapBossHead:
     include "_maps/MapBossHead.asm"
     even      
off_20C394:     dc.w unk_20C398-*       ; DATA XREF: ROM:0020C1B2↑o
                                        ; ROM:0020C396↓o
                dc.w unk_20C39B-off_20C394
unk_20C398:     dc.b $FF                ; DATA XREF: ROM:off_20C394↑o
                dc.b   0
                dc.b $FF
unk_20C39B:     dc.b   3                ; DATA XREF: ROM:0020C396↑o
                dc.b   2
                dc.b   1
                dc.b   3
                dc.b   1
                dc.b $FF
                dc.b   0     