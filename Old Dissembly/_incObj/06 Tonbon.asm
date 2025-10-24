ObjTonBon:
                moveq   #0,d0
                move.b  $24(a0),d0
                move.w  off_20D916(pc,d0.w),d0
                jsr     off_20D916(pc,d0.w)
                jsr     DisplaySprite
                out_of_range	@DelTon,$3E(a0)
                jmp	DisplaySprite
@DelTon:
            jmp   DeleteObject
                ;move.w  $3E(a0),d0
                ;jmp     loc_2078A6+2
; ---------------------------------------------------------------------------
off_20D916:     dc.w loc_20D91A-*       ; CODE XREF: ROM:0020D902↑p
                                        ; DATA XREF: ROM:0020D8FE↑r ...
                dc.w loc_20D994-off_20D916
; ---------------------------------------------------------------------------

loc_20D91A:                             ; DATA XREF: ROM:off_20D916↑o
                addq.b  #2,$24(a0)
                move.b  #4,1(a0)
                move.b  #$2C,$20(a0) ; ','
                move.b  #1,$18(a0)
                move.b  #$1C,$17(a0)
                move.b  #$1C,$19(a0)
                move.b  #$10,$16(a0)
                move.w  #$2416,2(a0)
                move.w  8(a0),$3E(a0)
                move.l  $C(a0),$2A(a0)
                lea     off_20D9F0(pc),a1
                move.l  #$FFFF0000,d0
                move.w  #4,d1
                move.w  #$100,d2
                tst.b   $28(a0)
                beq.s   loc_20D97E
                lea     off_20DAAE(pc),a1
                move.l  #$FFFF8000,d0
                move.w  #1,d1
                move.w  #$200,d2

loc_20D97E:                             ; CODE XREF: ROM:0020D96A↑j
                move.l  a1,4(a0)
                move.l  d0,$30(a0)
                move.w  d1,$34(a0)
                move.w  d2,$38(a0)
                lsr.w   #1,d2
                move.w  d2,$36(a0)

loc_20D994:                             ; DATA XREF: ROM:0020D918↑o
                move.l  $30(a0),d0
                add.l   d0,8(a0)
                move.w  $2E(a0),d0
                jsr     CalcSine;sub_200700
                swap    d0
                clr.w   d0
                asr.l   #4,d0
                add.l   $2A(a0),d0
                move.l  d0,$C(a0)
                move.w  $34(a0),d0
                add.w   d0,$2E(a0)
                addi.w  #-1,$36(a0)
                bne.s   loc_20D9DA
                move.w  $38(a0),$36(a0)
                neg.l   $30(a0)
                bchg    #0,1(a0)
                bchg    #0,$22(a0)

loc_20D9DA:                             ; CODE XREF: ROM:0020D9C2↑j
                lea     off_20D9E4(pc),a1
                jmp     AnimateSprite
off_20D9E4:     dc.w unk_20D9E8-*       ; DATA XREF: ROM:loc_20D9DA?o
                                       ; ROM:0020D9E6?o
             dc.w unk_20D9EC-off_20D9E4
 unk_20D9E8:     dc.b   2                ; DATA XREF: ROM:off_20D9E4?o
                 dc.b   0
               dc.b   1
              dc.b $FF
 unk_20D9EC:     dc.b   4                ; DATA XREF: ROM:0020D9E6?o
              dc.b   0
               dc.b   2
               dc.b $FF
               even
loc_2078A6:                             ; CODE XREF: sub_20785E+3E↑j
                                        ; ROM:0020D910↓j ...
                move.b  d0,0(a1)
                cmpi.b  #$31,d0 ; '1'
                bne.s   loc_2078B8
                nop
                nop
                nop
                nop

loc_2078B8:                             ; CODE XREF: sub_20785E+50↑j
                move.b  (a0)+,$28(a1)
                move.b  (a0)+,d0
                move.b  (a0)+,$29(a1)
                moveq   #0,d0

locret_2078C4:                          ; CODE XREF: sub_20785E+1C↑j
                rts
; End of function sub_20785E
off_20D9F0:     dc.w unk_20D9F6-*       ; DATA XREF: ROM:0020D954↑o
                                        ; ROM:0020D9F2↓o ...
                dc.w unk_20DA33-off_20D9F0
                dc.w unk_20DA70-off_20D9F0
unk_20D9F6:     dc.b  $C                ; DATA XREF: ROM:off_20D9F0↑o
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b  $A
                dc.b $E4
                dc.b $FC
                dc.b   4
                dc.b   0
                dc.b  $D
                dc.b $E4
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b  $F
                dc.b $F4
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $10
                dc.b $EC
                dc.b $F4
                dc.b   0
                dc.b   0
                dc.b   0
                dc.b $FC
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b   1
                dc.b   4
                dc.b $FC
                dc.b  $C
                dc.b   0
                dc.b   4
                dc.b $FC
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b   8
                dc.b $FC
                dc.b $F0
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $E3
                dc.b $F0
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b   3
                dc.b $EF
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $EA
                dc.b $EF
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b  $A
unk_20DA33:     dc.b  $C                ; DATA XREF: ROM:0020D9F2↑o
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b  $A
                dc.b $E4
                dc.b $FC
                dc.b   4
                dc.b   0
                dc.b  $D
                dc.b $E4
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b  $F
                dc.b $F4
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $10
                dc.b $EC
                dc.b $F4
                dc.b   0
                dc.b   0
                dc.b   0
                dc.b $FC
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b   1
                dc.b   4
                dc.b $FC
                dc.b  $C
                dc.b   0
                dc.b   4
                dc.b $FC
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b   8
                dc.b $FC
                dc.b $F2
                dc.b  $C
                dc.b   0
                dc.b $19
                dc.b $E3
                dc.b $F2
                dc.b   0
                dc.b   0
                dc.b $1D
                dc.b   3
                dc.b $F1
                dc.b  $C
                dc.b   0
                dc.b $19
                dc.b $EA
                dc.b $F1
                dc.b   0
                dc.b   0
                dc.b $1D
                dc.b  $A
unk_20DA70:     dc.b  $C                ; DATA XREF: ROM:0020D9F4↑o
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b  $A
                dc.b $E4
                dc.b $FC
                dc.b   4
                dc.b   0
                dc.b $12
                dc.b $E4
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b  $F
                dc.b $F4
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $10
                dc.b $EC
                dc.b $F4
                dc.b   0
                dc.b   0
                dc.b   0
                dc.b $FC
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b   1
                dc.b   4
                dc.b $FC
                dc.b  $C
                dc.b   0
                dc.b   4
                dc.b $FC
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b   8
                dc.b $FC
                dc.b $F0
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $E3
                dc.b $F0
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b   3
                dc.b $EF
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $EA
                dc.b $EF
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b  $A
                dc.b   0
                even
off_20DAAE:     dc.w unk_20DAB4-*       ; DATA XREF: ROM:0020D96C↑o
                                        ; ROM:0020DAB0↓o ...
                dc.w unk_20DAEC-off_20DAAE
                dc.w unk_20DB24-off_20DAAE
unk_20DAB4:     dc.b  $B                ; DATA XREF: ROM:off_20DAAE↑o
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b  $A
                dc.b $E4
                dc.b $FC
                dc.b   4
                dc.b   0
                dc.b $1E
                dc.b $E4
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b  $F
                dc.b $F4
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $10
                dc.b $EC
                dc.b $F4
                dc.b  $C
                dc.b   0
                dc.b $20
                dc.b $FC
                dc.b $FC
                dc.b  $C
                dc.b   0
                dc.b $24 ; $
                dc.b $FC
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $28 ; (
                dc.b $FC
                dc.b $F0
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $E3
                dc.b $F0
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b   3
                dc.b $EF
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $EA
                dc.b $EF
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b  $A
unk_20DAEC:     dc.b  $B                ; DATA XREF: ROM:0020DAB0↑o
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b  $A
                dc.b $E4
                dc.b $FC
                dc.b   4
                dc.b   0
                dc.b $1E
                dc.b $E4
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b  $F
                dc.b $F4
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $10
                dc.b $EC
                dc.b $F4
                dc.b  $C
                dc.b   0
                dc.b $20
                dc.b $FC
                dc.b $FC
                dc.b  $C
                dc.b   0
                dc.b $24 ; $
                dc.b $FC
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $28 ; (
                dc.b $FC
                dc.b $F2
                dc.b  $C
                dc.b   0
                dc.b $19
                dc.b $E3
                dc.b $F2
                dc.b   0
                dc.b   0
                dc.b $1D
                dc.b   3
                dc.b $F1
                dc.b  $C
                dc.b   0
                dc.b $19
                dc.b $EA
                dc.b $F1
                dc.b   0
                dc.b   0
                dc.b $1D
                dc.b  $A
unk_20DB24:     dc.b  $B                ; DATA XREF: ROM:0020DAB2↑o
                dc.b $F4
                dc.b   8
                dc.b   0
                dc.b  $A
                dc.b $E4
                dc.b $FC
                dc.b   4
                dc.b   0
                dc.b $12
                dc.b $E4
                dc.b $FC
                dc.b   0
                dc.b   0
                dc.b  $F
                dc.b $F4
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $10
                dc.b $EC
                dc.b $F4
                dc.b  $C
                dc.b   0
                dc.b $20
                dc.b $FC
                dc.b $FC
                dc.b  $C
                dc.b   0
                dc.b $24 ; $
                dc.b $FC
                dc.b   4
                dc.b   4
                dc.b   0
                dc.b $28 ; (
                dc.b $FC
                dc.b $F0
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $E3
                dc.b $F0
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b   3
                dc.b $EF
                dc.b  $C
                dc.b   0
                dc.b $14
                dc.b $EA
                dc.b $EF
                dc.b   0
                dc.b   0
                dc.b $18
                dc.b  $A
                dc.b $4A ; J
                dc.b $28 ; (
                dc.b   0
                dc.b $28 ; (
                dc.b $6B ; k
                dc.b   0
                dc.b   2
                dc.b $6A ; j
                dc.b $4E ; N
                dc.b $B9
                dc.b   0
                dc.b $20
                dc.b $FD
                dc.b $2C ; ,
                even