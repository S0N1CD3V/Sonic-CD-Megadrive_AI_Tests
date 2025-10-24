ObjTTZDoor:
sub_20B6C0:                             ; DATA XREF: ROM:00203EEC↑o
                moveq   #0,d0
                move.b  $24(a0),d0
                move.w  off_20B6E4(pc,d0.w),d0
                jsr     off_20B6E4(pc,d0.w)
                lea     (v_objspace).w,a1
                jsr     SolidObject
                jsr     DrawObject
                jmp     loc_20B7DC
; ---------------------------------------------------------------------------
off_20B6E4:     dc.w loc_20B6EC-*       ; CODE XREF: sub_20B6C0+A↑p
                                        ; DATA XREF: sub_20B6C0+6↑r ...
                dc.w loc_20B776-off_20B6E4
                dc.w loc_20B7AC-off_20B6E4
                dc.w loc_20B7C0-off_20B6E4
; ---------------------------------------------------------------------------

loc_20B6EC:                             ; DATA XREF: sub_20B6C0:off_20B6E4↑o
                ori.b   #4,1(a0)
                move.b  #3,$18(a0)
                move.b  #$40,$17(a0) ; '@'
                move.b  #$40,$19(a0) ; '@'
                move.b  #$40,$16(a0) ; '@'
                move.w  #$446A,2(a0)
                move.l  #off_20B810,4(a0)
                moveq   #0,d0
                move.b  $23(a0),d0
                lea     ($FF1200).l,a1
                move.w  d0,d1
                add.w   d1,d1
                add.w   d1,d0
                moveq   #0,d1
                move.b  ($FF152E).l,d1
                add.w   d1,d0
                lea     2(a1,d0.w),a1
                move.l  a1,$2C(a0)
                btst    #0,(a1)
                bne.s   loc_20B75E
                move.w  #$10,d0
                move.b  $28(a0),d1
                beq.s   loc_20B750
                addi.w  #$10,d0

loc_20B750:                             ; CODE XREF: sub_20B6C0+8A↑j
                move.w  d0,$2A(a0)
                addq.b  #1,d1
                add.b   d1,d1
                move.b  d1,$24(a0)
                rts
; ---------------------------------------------------------------------------

loc_20B75E:                             ; CODE XREF: sub_20B6C0+80↑j
                move.w  #$40,d0 ; '@'
                tst.b   $28(a0)
                beq.s   loc_20B76C
                addi.w  #$40,d0 ; '@'

loc_20B76C:                             ; CODE XREF: sub_20B6C0+A6↑j
                add.w   d0,$C(a0)
                addq.b  #4,$24(a0)
                rts
; ---------------------------------------------------------------------------

loc_20B776:                             ; DATA XREF: sub_20B6C0+26↑o
                lea     (v_objspace).w,a6
                bsr.s   loc_20B788
                bcc.s   locret_20B786
                st      $3F(a0)
                addq.b  #2,$24(a0)

locret_20B786:                          ; CODE XREF: sub_20B6C0+BC↑j
                rts
; ---------------------------------------------------------------------------

loc_20B788:                             ; CODE XREF: sub_20B6C0+BA↑p
                move.w  $C(a6),d0
                sub.w   $C(a0),d0
                subi.w  #0,d0
                subi.w  #$80,d0
                bcc.s   locret_20B7AA
                move.w  8(a6),d0
                sub.w   8(a0),d0
                subi.w  #$A0,d0
                subi.w  #$20,d0 ; ' '

locret_20B7AA:                          ; CODE XREF: sub_20B6C0+D8↑j
                rts
; ---------------------------------------------------------------------------

loc_20B7AC:                             ; DATA XREF: sub_20B6C0+28↑o
                tst.b   $3F(a0)
                beq.s   locret_20B7BE
                movea.l $2C(a0),a1
                bset    #0,(a1)
                addq.b  #2,$24(a0)

locret_20B7BE:                          ; CODE XREF: sub_20B6C0+F0↑j
                rts
; ---------------------------------------------------------------------------

loc_20B7C0:                             ; DATA XREF: sub_20B6C0+2A↑o
                addi.l  #$40000,$C(a0)
                addi.w  #-1,$2A(a0)
                bne.s   locret_20B7DA
                sf      $3F(a0)
                addi.b  #-2,$24(a0)

locret_20B7DA:                          ; CODE XREF: sub_20B6C0+10E↑j
                rts
; ---------------------------------------------------------------------------

loc_20B7DC:                             ; CODE XREF: sub_20B6C0+1E↑j
                cmpi.b  #1,$28(a0)
                beq.s   locret_20B80E
                move.w  8(a0),d0
                andi.w  #$FF80,d0
                move.w  (v_screenposx).w,d1
                subi.w  #$80,d1
                andi.w  #$FF80,d1
                sub.w   d1,d0
                cmpi.w  #$280,d0
                bls.s   locret_20B80E
                movea.l $2C(a0),a1
                bclr    #7,(a1)
                jmp     DeleteObject
; ---------------------------------------------------------------------------

locret_20B80E:                          ; CODE XREF: sub_20B6C0+122↑j
                                        ; sub_20B6C0+13E↑j
                rts
; End of function sub_20B6C0
TTZDoor:
    include "_maps/UnkMap.asm"
    even