ObjBossEggman:                          ; DATA XREF: ROM:00203C22↑o
        bsr.w   sub_20B9A6
        bsr.w   sub_20B9CA
        bsr.w   sub_20BAC0
        bsr.w   sub_20B9FC
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20B996(pc,d0.w),d0
        jsr     off_20B996(pc,d0.w)
        lea     (Ani_20D7BC).l,a1
        jsr     AnimateObject
        jmp     DrawObject
; End of function ObjBossEggman

; ---------------------------------------------------------------------------
off_20B996:dc.w ObjBossEggman_0_Routine0-off_20B996
                                        ; CODE XREF: ObjBossEggman+1A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossEggman_0_Routine2-off_20B996
        dc.w ObjBossEggman_0_Routine4-off_20B996
        dc.w ObjBossEggman_0_Routine6-off_20B996
        dc.w ObjBossEggman_0_Routine8-off_20B996
        dc.w ObjBossEggman_0_RoutineA-off_20B996
        dc.w ObjBossEggman_0_RoutineC-off_20B996
        dc.w ObjBossEggman_0_RoutineE-off_20B996

; =============== S U B R O U T I N E =======================================


sub_20B9A6:                             ; CODE XREF: ObjBossEggman↑p
        tst.b   oVar2A(a0)
        beq.s   locret_20B9C8
        subq.b  #1,oVar2A(a0)
        bne.s   locret_20B9C8
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.b  #0,oAnim(a0)

locret_20B9C8:                          ; CODE XREF: sub_20B9A6+4↑j ...
        rts
; End of function sub_20B9A6


; =============== S U B R O U T I N E =======================================


sub_20B9CA:                             ; CODE XREF: ObjBossEggman+4↑p
        move.w  #$310,d1
        tst.b   (bossFlags).w
        beq.s   loc_20B9F2
        move.w  #$100,d1
        tst.b   oVar35(a0)
        beq.s   loc_20B9F2
        subq.b  #1,oVar35(a0)
        move.w  #1,d0
        btst    #0,oVar35(a0)
        beq.s   loc_20B9F0
        neg.w   d0

loc_20B9F0:                             ; CODE XREF: sub_20B9CA+22↑j
        add.w   d0,d1

loc_20B9F2:                             ; CODE XREF: sub_20B9CA+8↑j ...
        move.w  d1,(bottomBound).w
        move.w  d1,(destBottomBound).w
        rts
; End of function sub_20B9CA


; =============== S U B R O U T I N E =======================================


sub_20B9FC:                             ; CODE XREF: ObjBossEggman+C↑p

; FUNCTION CHUNK AT 0020BAF8 SIZE 000000AA BYTES

        tst.b   oVar34(a0)
        bne.s   loc_20BA0C
        btst    #3,oVar2C(a0)
        bne.s   loc_20BA1A
        rts
; ---------------------------------------------------------------------------

loc_20BA0C:                             ; CODE XREF: sub_20B9FC+4↑j
        subq.b  #1,oVar34(a0)
        bne.s   locret_20BA18
        jsr     sub_20BC06

locret_20BA18:                          ; CODE XREF: sub_20B9FC+14↑j
        rts
; ---------------------------------------------------------------------------

loc_20BA1A:                             ; CODE XREF: sub_20B9FC+C↑j
        movea.l a0,a1
        tst.b   $20(a1)
        beq.w   loc_20BAF8
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        tst.b   $20(a1)
        beq.w   loc_20BAF8
        movea.w $30(a1),a1
        tst.b   $20(a1)
        beq.w   loc_20BAF8
        movea.w oVar30(a0),a1
        movea.w $32(a1),a1
        movea.w $30(a1),a1
        tst.b   $20(a1)
        beq.w   loc_20BAF8
        movea.w $30(a1),a1
        tst.b   $20(a1)
        beq.w   loc_20BAF8
        cmpi.b  #3,oVar2B(a0)
        beq.s   loc_20BA76
        cmpi.b  #2,oVar2B(a0)
        beq.s   loc_20BA8E
        rts
; ---------------------------------------------------------------------------

loc_20BA76:                             ; CODE XREF: sub_20B9FC+6E↑j
        movea.w oVar32(a0),a1
        movea.w $32(a1),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        tst.b   $20(a1)
        beq.w   loc_20BAA8

loc_20BA8E:                             ; CODE XREF: sub_20B9FC+76↑j
        movea.w oVar32(a0),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        tst.b   $20(a1)
        beq.w   loc_20BAA8
        rts
; ---------------------------------------------------------------------------

loc_20BAA8:                             ; CODE XREF: sub_20B9FC+8E↑j ...
        bset    #4,$2C(a1)
        bsr.w   sub_20BBCE
        bsr.w   sub_20BC06
        move.w  #sfx_bumper,d0
        jsr     PlayFMSound
; End of function sub_20B9FC


; =============== S U B R O U T I N E =======================================


sub_20BAC0:                             ; CODE XREF: ObjBossEggman+8↑p
        tst.b   oAnim(a0)
        bne.s   locret_20BAD8
        lea     (v_player).w,a1
        tst.w   objPlayerSlot+oVar30-objPlayerSlot(a1)
        bne.s   loc_20BADA
        cmpi.b  #6,$24(a1)
        beq.s   loc_20BADA

locret_20BAD8:                          ; CODE XREF: sub_20BAC0+4↑j
        rts
; ---------------------------------------------------------------------------

loc_20BADA:                             ; CODE XREF: sub_20BAC0+E↑j ...
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.b  #1,oAnim(a0)
        move.b  #$3C,oVar2A(a0) ; '<'
        rts
; End of function sub_20BAC0

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR sub_20B9FC

loc_20BAF8:                             ; CODE XREF: sub_20B9FC+24↑j ...
        move.b  #$14,oVar34(a0)
        bsr.w   sub_20BBCE
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.b  #2,oAnim(a0)
        move.b  #$78,oVar2A(a0) ; 'x'
        subq.b  #1,oVar2B(a0)
        beq.w   loc_20BB4C
        cmpi.b  #2,oVar2B(a0)
        beq.w   loc_20BB3E
        movea.w oVar32(a0),a1
        bset    #6,$2C(a1)
        bra.w   loc_20BC38
; ---------------------------------------------------------------------------

loc_20BB3E:                             ; CODE XREF: sub_20B9FC+130↑j
        movea.w oVar32(a0),a1
        bset    #5,$2C(a1)
        bra.w   loc_20BC2C
; ---------------------------------------------------------------------------

loc_20BB4C:                             ; CODE XREF: sub_20B9FC+126↑j
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.b  #2,oAnim(a0)
        clr.b   oVar2A(a0)
        bclr    #3,oVar2C(a0)
        clr.b   oRoutine2(a0)
        move.b  #6,oRoutine(a0)
        clr.b   oColType(a0)
        clr.b   oColStatus(a0)
        movea.w oVar32(a0),a1
        move.b  #4,$24(a1)
        movea.w oVar30(a0),a1
        move.b  #$E,$24(a1)
        movea.w $30(a1),a1
        bsr.w   sub_20BBA2
        movea.w oVar30(a0),a1
        movea.w $32(a1),a1
; END OF FUNCTION CHUNK FOR sub_20B9FC

; =============== S U B R O U T I N E =======================================


sub_20BBA2:                             ; CODE XREF: sub_20B9FC+19A↑p
        move.b  #$18,$24(a1)
        movea.w $30(a1),a1
        move.b  #$E,$24(a1)
        clr.b   $20(a1)
        clr.b   $21(a1)
        movea.w $30(a1),a1
        move.b  #$C,$24(a1)
        clr.b   $20(a1)
        clr.b   $21(a1)
        rts
; End of function sub_20BBA2


; =============== S U B R O U T I N E =======================================


sub_20BBCE:                             ; CODE XREF: sub_20B9FC+B2↑p ...
        lea     (objPlayerSlot).w,a2
        move.w  #$400,d1
        move.w  #$FC00,d2
        move.w  #$400,$14(a2)
        btst    #1,$22(a2)
        bne.s   loc_20BBF0
        eori.b  #$80,$26(a2)
        moveq   #0,d2

loc_20BBF0:                             ; CODE XREF: sub_20BBCE+18↑j
        move.w  8(a2),d0
        cmp.w   8(a1),d0
        bcc.s   loc_20BBFC
        neg.w   d1

loc_20BBFC:                             ; CODE XREF: sub_20BBCE+2A↑j
        move.w  d1,$10(a2)
        move.w  d2,$12(a2)
        rts
; End of function sub_20BBCE


; =============== S U B R O U T I N E =======================================


sub_20BC06:                             ; CODE XREF: sub_20B9FC+16↑p ...
        cmpi.b  #3,oVar2B(a0)
        beq.s   loc_20BC20
        cmpi.b  #2,oVar2B(a0)
        beq.s   loc_20BC2C
        cmpi.b  #1,oVar2B(a0)
        beq.s   loc_20BC38
        rts
; ---------------------------------------------------------------------------

loc_20BC20:                             ; CODE XREF: sub_20BC06+6↑j
        movea.w oVar32(a0),a1
        movea.w $32(a1),a1
        bsr.w   sub_20BC92

loc_20BC2C:                             ; CODE XREF: sub_20B9FC+14C↑j ...
        movea.w oVar32(a0),a1
        movea.w $30(a1),a1
        bsr.w   sub_20BC92

loc_20BC38:                             ; CODE XREF: sub_20B9FC+13E↑j ...
        move.b  #$FC,oColType(a0)
        move.b  #2,oColStatus(a0)
        movea.w oVar30(a0),a2
        movea.w $30(a2),a1
        movea.w $30(a1),a1
        move.b  #$BD,$20(a1)
        move.b  #2,$21(a1)
        movea.w $30(a1),a1
        move.b  #$BE,$20(a1)
        move.b  #2,$21(a1)
        movea.w $32(a2),a1
        movea.w $30(a1),a1
        move.b  #$BD,$20(a1)
        move.b  #2,$21(a1)
        movea.w $30(a1),a1
        move.b  #$BE,$20(a1)
        move.b  #2,$21(a1)
        rts
; End of function sub_20BC06


; =============== S U B R O U T I N E =======================================


sub_20BC92:                             ; CODE XREF: sub_20BC06+22↑p ...
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        move.b  #$FF,$20(a1)
        move.b  #2,$21(a1)
        rts
; End of function sub_20BC92


; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_Routine0:               ; DATA XREF: ROM:off_20B996↑o
        moveq   #$1D,d0
        jsr     AddPLCs
        move.b  #1,(bossFight).w
        clr.b   oFlags(a0)
        move.b  #2,oRoutine(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #6,oPriority(a0)
        move.b  #$14,oWidth(a0)
        move.b  #8,oYRadius(a0)
        move.w  #$3FD,oTile(a0)
        move.l  #Spr_20D7DC,oSprites(a0)
        move.b  #1,oAnim(a0)
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.w  #$C52,oX(a0)
        move.w  #$78,oY(a0) ; 'x'
        move.w  #5,d0
        movem.l d7-a7,-(sp)
        jsr     LoadPalette
        movem.l (sp)+,d7-a7
        rts
; End of function ObjBossEggman_0_Routine0


; =============== S U B R O U T I N E =======================================
SpawnObjectWithXAndYCord:                             ; CODE XREF: sub_20BD36+2↓p ...
        jsr     FindObjSlot
        bne.w   locret_20BD34
        move.w  oX(a0),oX(a1)
        move.w  oY(a0),oY(a1)
        moveq   #0,d0

locret_20BD34:                          ; CODE XREF: SpawnObjectWithXAndYCord+6↑j
        rts
; End of function SpawnObjectWithXAndYCord


; =============== S U B R O U T I N E =======================================


sub_20BD36:                             ; CODE XREF: ObjBossEggman_0_RoutineE+22↓p
        movea.l a0,a3
        bsr.s   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.w  a3,oVar2E(a1)
        move.b  #6,oPriority(a1)
        move.b  #$43,obj(a1) ; '+'
        movea.l a1,a3
        movea.l a1,a4
        bsr.s   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.w  a3,oVar2E(a1)
        move.b  #6,oPriority(a1)
        move.b  #$44,obj(a1) ; ','
        movea.l a1,a3
        bsr.s   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.w  a3,oVar2E(a1)
        move.b  #3,oPriority(a1)
        move.b  #$45,obj(a1) ; '-'
        movea.l a1,a3
        bsr.s   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.w  a3,oVar2E(a1)
        move.b  #2,oPriority(a1)
        move.b  #$46,obj(a1) ; '.'
        movea.w a4,a3
        move.w  a3,oVar30(a1)
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$32(a3)
        move.w  a3,oVar2E(a1)
        move.b  #7,oPriority(a1)
        move.b  #$44,obj(a1) ; ','
        bset    #2,oVar2C(a1)
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.w  a3,oVar2E(a1)
        move.b  #6,oPriority(a1)
        move.b  #$45,obj(a1) ; '-'
        bset    #2,oVar2C(a1)
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.w  a3,oVar2E(a1)
        move.b  #5,oPriority(a1)
        move.b  #$46,obj(a1) ; '.'
        bset    #2,oVar2C(a1)
        movea.l a1,a3
        movea.w a4,a3
        move.w  a3,oVar30(a1)
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a3,oVar2E(a1)
        movea.w $2E(a3),a3
        move.w  a1,$32(a3)
        move.b  #3,oPriority(a1)
        move.b  #$47,obj(a1) ; '/'
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$30(a3)
        move.b  #$80,oVar2A(a1)
        move.w  a3,oVar2E(a1)
        move.w  a1,$30(a3)
        move.b  #5,oPriority(a1)
        move.b  #$48,obj(a1) ; '0'
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a3,oVar2E(a1)
        move.w  a1,$30(a3)
        move.b  #4,oPriority(a1)
        move.l  #Spr_20D918,oSprites(a1)
        move.b  #$49,obj(a1) ; '1'
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a3,oVar2E(a1)
        move.w  a1,$30(a3)
        move.b  #3,oPriority(a1)
        move.b  #$4A,obj(a1) ; '2'
        movea.l a1,a3
        move.w  a4,oVar30(a1)
        movea.w $2E(a3),a3
        movea.w $2E(a3),a3
        movea.w $2E(a3),a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a1,$32(a3)
        move.w  a3,oVar2E(a1)
        move.b  #7,oPriority(a1)
        move.b  #$48,obj(a1) ; '0'
        bset    #2,oVar2C(a1)
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a3,oVar2E(a1)
        move.w  a1,$30(a3)
        move.b  #7,oPriority(a1)
        move.l  #Spr_20D942,oSprites(a1)
        move.b  #$49,obj(a1) ; '1'
        bset    #2,oVar2C(a1)
        movea.l a1,a3
        bsr.w   SpawnObjectWithXAndYCord
        bne.w   locret_20BF42
        move.w  a3,oVar2E(a1)
        move.w  a1,$30(a3)
        move.b  #6,oPriority(a1)
        move.b  #$4A,obj(a1) ; '2'
        bset    #2,oVar2C(a1)
        movea.l a1,a3
        move.w  a4,oVar30(a1)
        move.b  #3,oVar2B(a0)
        jsr     sub_20BC06                      
locret_20BF42:                          ; CODE XREF: sub_20BD36+4↑j ...
        rts
; End of function sub_20BD36


; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_Routine2:               ; DATA XREF: ROM:0020B998↑o
        move.w  #$AC0,d0
        move.w  d0,(rightBound).w
        move.w  d0,(destRightBound).w
        lea     (objPlayerSlot).w,a1
        cmpi.w  #$A6A,objPlayerSlot+oX-objPlayerSlot(a1)
        blt.s   locret_20BF90
        move.w  8(a1),d0
        subi.w  #$A0,d0
        cmp.w   (leftBound).w,d0
        blt.s   locret_20BF90
        cmpi.w  #$B60,8(a1)
        blt.s   loc_20BF88
        move.b  #$C,oRoutine(a0)
        move.w  #$AC0,d0
        move.w  d0,(rightBound).w
        move.w  d0,(destRightBound).w
        move.w  #$AC0,d0

loc_20BF88:                             ; CODE XREF: ObjBossEggman_0_Routine2+2C↑j
        move.w  d0,(leftBound).w
        move.w  d0,(destLeftBound).w

locret_20BF90:                          ; CODE XREF: ObjBossEggman_0_Routine2+16↑j ...
        rts
; End of function ObjBossEggman_0_Routine2


; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_RoutineC:               ; DATA XREF: ROM:0020B9A2↑o
        addq.w  #6,(camYCenter).w
        cmpi.w  #$C8,(camYCenter).w
        bge.s   loc_20BFA0
        rts
; ---------------------------------------------------------------------------

loc_20BFA0:                             ; CODE XREF: ObjBossEggman_0_RoutineC+A↑j
        move.w  #bgm_S3Boss,d0 ; Play Boss Theme
        jsr     PlaySound
        move.b  #1,(bossFlags).w
        move.b  #$E,oRoutine(a0)
        rts
; End of function ObjBossEggman_0_RoutineC


; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_RoutineE:               ; DATA XREF: ROM:0020B9A4↑o
        addq.b  #1,oVar2B(a0)
        cmpi.b  #$3C,oVar2B(a0) ; '<'
        bne.s   locret_20BFDE
        clr.b   oVar2B(a0)
        move.b  #4,oRoutine(a0)
        move.w  #$BD2,oX(a0)
        move.w  #$78,oY(a0) ; 'x'
        bsr.w   sub_20BD36

locret_20BFDE:                          ; CODE XREF: ObjBossEggman_0_RoutineE+A↑j
        rts
; End of function ObjBossEggman_0_RoutineE


; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_Routine4:               ; DATA XREF: ROM:0020B99A↑o
        movea.w oVar30(a0),a1
        bclr    #0,$2C(a1)
        beq.s   locret_20C04C
        cmpi.b  #2,oRoutine2(a0)
        bne.s   loc_20C020
        move.w  #0,oAnim(a0)
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.b  #3,oVar2B(a0)
        bset    #3,oVar2C(a0)
        jsr     sub_20BC06
        movea.w oVar30(a0),a1

loc_20C020:                             ; CODE XREF: ObjBossEggman_0_Routine4+12↑j
        addq.b  #2,oRoutine2(a0)
        moveq   #0,d0
        bclr    #1,$2C(a1)

loc_20C02C:                             ; CODE XREF: ObjBossEggman_0_Routine4+62↓j
        lea     (unk_20C04E).l,a2
        move.b  oRoutine2(a0),d0
        adda.w  d0,a2
        tst.b   (a2)
        bge.s   loc_20C044
        move.b  #6,oRoutine2(a0)
        bra.s   loc_20C02C
; ---------------------------------------------------------------------------

loc_20C044:                             ; CODE XREF: ObjBossEggman_0_Routine4+5A↑j
        move.b  (a2)+,$24(a1)
        move.b  (a2),$2D(a1)

locret_20C04C:                          ; CODE XREF: ObjBossEggman_0_Routine4+A↑j
        rts
; End of function ObjBossEggman_0_Routine4

; ---------------------------------------------------------------------------
unk_20C04E:dc.b   2                     ; DATA XREF: ObjBossEggman_0_Routine4:loc_20C02C↑o
        dc.b   0
        dc.b   4
        dc.b   0
        dc.b   6
        dc.b   0
        dc.b   8
        dc.b   5
        dc.b  $A
        dc.b   6
        dc.b  $C
        dc.b  $A
        dc.b   8
        dc.b  $A
        dc.b $10
        dc.b $32 ; 2
        dc.b  $A
        dc.b  $A
        dc.b $FF
        dc.b $FF

; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_Routine6:               ; DATA XREF: ROM:0020B99C↑o
        addq.b  #1,oVar2B(a0)
        bsr.w   sub_20D72A
        cmpi.b  #$5E,oVar2B(a0) ; '^'
        bne.s   loc_20C09E
        move.w  oX(a0),oVar3C(a0)
        move.w  oY(a0),oXVel(a0)
        move.b  #3,oAnim(a0)
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        movea.w oVar30(a0),a1
        bset    #0,oVar2C(a1)

loc_20C09E:                             ; CODE XREF: ObjBossEggman_0_Routine6+E↑j
        cmpi.b  #$78,oVar2B(a0) ; 'x'
        bcs.s   locret_20C0C4
        clr.b   oVar2B(a0)
        move.b  #8,oRoutine(a0)
        move.b  #$20,oWidth(a0) ; ' '
        move.b  #$20,oYRadius(a0) ; ' '
        moveq   #$64,d0 ; 'd'
        jsr     AddPoints

locret_20C0C4:                          ; CODE XREF: ObjBossEggman_0_Routine6+42↑j
        rts
; End of function ObjBossEggman_0_Routine6


; =============== S U B R O U T I N E =======================================


ObjBossEggman_0_Routine8:               ; DATA XREF: ROM:0020B99E↑o
        tst.b   oRoutine2(a0)
        beq.w   loc_20C100
        move.w  oVar38(a0),d0
        sub.w   d0,oY(a0)
        addq.b  #3,oVar2B(a0)
        move.b  oVar2B(a0),d0
        jsr     CalcSine
        asr.w   #5,d0
        move.w  d0,oVar38(a0)
        add.w   d0,oY(a0)
        addi.l  #$28000,oX(a0)
        cmpi.w  #$C80,oX(a0)
        bge.s   loc_20C16C
        rts
; ---------------------------------------------------------------------------

loc_20C100:                             ; CODE XREF: ObjBossEggman_0_Routine8+4↑j
        addq.b  #1,oVar2B(a0)
        move.w  oX(a0),d0
        move.w  oY(a0),d1
        movem.w d0-d1,-(sp)
        move.w  oVar3C(a0),oX(a0)
        move.w  oXVel(a0),oY(a0)
        bsr.w   sub_20D72A
        movem.w (sp)+,d0-d1
        move.w  d0,oX(a0)
        move.w  d1,oY(a0)
        addi.l  #$8000,oX(a0)
        subi.l  #$20000,oY(a0)
        cmpi.w  #$158,oY(a0)
        bgt.s   locret_20C16A
        addq.b  #1,oRoutine2(a0)
        clr.b   oSprFrame(a0)
        clr.b   oAnimFrame(a0)
        clr.b   oAnimTime(a0)
        clr.b   oVar1F(a0)
        move.b  #4,oAnim(a0)
        move.b  #$40,oVar2B(a0) ; '@'
        move.w  #8,oVar38(a0)

locret_20C16A:                          ; CODE XREF: ObjBossEggman_0_Routine8+7C↑j
        rts
; ---------------------------------------------------------------------------

loc_20C16C:                             ; CODE XREF: ObjBossEggman_0_Routine8+36↑j
        clr.b   oVar2B(a0)
        move.w  #$11,d0
        tst.b   (goodFuture).l
        beq.s   loc_20C180
        move.w  #$10,d0

loc_20C180:                             ; CODE XREF: ObjBossEggman_0_Routine8+B4↑j
        jsr     SubCPUCmd
        jsr     sub_20B604
        clr.b   (bossFlags).w
        clr.b   (bossFight).w
        move.b  #$A,oRoutine(a0)

ObjBossEggman_0_RoutineA:               ; DATA XREF: ROM:0020B9A0↑o
        lea     (word_2027F8).l,a1
        move.w  (a1)+,d0
        move.w  (a1)+,d1
        addq.w  #6,(rightBound).w
        addq.w  #6,(destRightBound).w
        cmp.w   (rightBound).w,d1
        ble.s   loc_20C1B6
        addq.l  #4,sp
        rts
; ---------------------------------------------------------------------------

loc_20C1B6:                             ; CODE XREF: ObjBossEggman_0_Routine8+EA↑j
        move.w  d1,(rightBound).w
        move.w  d1,(destRightBound).w
        addq.l  #4,sp
        jmp     DeleteObject
; End of function ObjBossEggman_0_Routine8
; =============== S U B R O U T I N E =======================================


ObjBossBody:                            ; DATA XREF: ROM:00203C26↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20C1DA(pc,d0.w),d0
        jsr     off_20C1DA(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossBody

; ---------------------------------------------------------------------------
off_20C1DA:dc.w ObjBossBody_0_Routine0-*
                                        ; CODE XREF: ObjBossBody+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossBody_0_Routine2-off_20C1DA
        dc.w ObjBossBody_0_Routine4-off_20C1DA
        dc.w ObjBossBody_0_Routine6-off_20C1DA
        dc.w ObjBossBody_0_Routine8-off_20C1DA
        dc.w ObjBossBody_0_RoutineA-off_20C1DA
        dc.w ObjBossBody_0_RoutineC-off_20C1DA
        dc.w ObjBossBody_0_RoutineE-off_20C1DA
        dc.w ObjBossBody_0_Routine10-off_20C1DA

; =============== S U B R O U T I N E =======================================


ObjBossBody_0_Routine0:                 ; DATA XREF: ROM:off_20C1DA↑o
        clr.b   oFlags(a0)
        move.b  #2,oRoutine(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #$24,oWidth(a0) ; '$'
        move.b  #$20,oYRadius(a0) ; ' '
        move.w  #$359,oTile(a0)
        move.l  #Spr_20D8AE,oSprites(a0)
        bsr.w   sub_20C5AE
        rts
; End of function ObjBossBody_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_Routine10:                ; DATA XREF: ROM:0020C1EA↑o
        subq.b  #1,oVar2D(a0)
        bne.w   locret_20C234
        bsr.w   sub_20C5AE
        bset    #0,oVar2C(a0)
        bclr    #1,oVar2C(a0)

locret_20C234:                          ; CODE XREF: ObjBossBody_0_Routine10+4↑j
        rts
; End of function ObjBossBody_0_Routine10


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_Routine2:                 ; DATA XREF: ROM:0020C1DC↑o
        movea.w oVar32(a0),a1
        move.b  #$10,$24(a1)
        movea.w $30(a1),a1
        move.b  #4,$24(a1)
        movea.w $30(a1),a1
        move.b  #$A,$24(a1)
        movea.w oVar30(a0),a1
        bsr.w   sub_20C8D0
        btst    #4,$2C(a1)
        bne.s   loc_20C27A
        addi.l  #$18000,oY(a0)
        movea.w oVar2E(a0),a1
        addi.l  #$18000,$C(a1)
        rts
; ---------------------------------------------------------------------------

loc_20C27A:                             ; CODE XREF: ObjBossBody_0_Routine2+2C↑j
        bset    #0,oVar2C(a0)
        rts
; End of function ObjBossBody_0_Routine2


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_Routine4:                 ; DATA XREF: ROM:0020C1DE↑o
        movea.w oVar32(a0),a1
        bclr    #0,$2C(a1)
        movea.w oVar30(a0),a1
        bclr    #0,$2C(a1)
        beq.s   locret_20C2F4
        cmpi.b  #$C,$24(a1)
        beq.s   loc_20C2EC
        cmpi.b  #$A,$24(a1)
        beq.s   loc_20C2E4
        move.b  #2,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w oVar32(a0),a1
        move.b  #8,$24(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #2,$24(a1)
        movea.w $30(a1),a1
        move.b  #4,$24(a1)
        bset    #0,oVar2C(a0)
        rts
; ---------------------------------------------------------------------------

loc_20C2E4:                             ; CODE XREF: ObjBossBody_0_Routine4+24↑j
        move.b  #$E,$24(a1)
        rts
; ---------------------------------------------------------------------------

loc_20C2EC:                             ; CODE XREF: ObjBossBody_0_Routine4+1C↑j
        move.b  #$A,$24(a1)
        rts
; ---------------------------------------------------------------------------

locret_20C2F4:                          ; CODE XREF: ObjBossBody_0_Routine4+14↑j
        rts
; End of function ObjBossBody_0_Routine4


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_Routine6:                 ; DATA XREF: ROM:0020C1E0↑o
        bset    #1,oVar2C(a0)
        bne.s   loc_20C302
        bsr.w   sub_20C474

loc_20C302:                             ; CODE XREF: ObjBossBody_0_Routine6+6↑j
        movea.w oVar30(a0),a1
        btst    #0,$2C(a1)
        beq.s   locret_20C32C
        movea.w oVar32(a0),a1
        btst    #0,$2C(a1)
        beq.s   locret_20C32C
        bclr    #1,oVar2C(a0)
        bset    #6,oVar2C(a0)
        bset    #0,oVar2C(a0)

locret_20C32C:                          ; CODE XREF: ObjBossBody_0_Routine6+16↑j ...
        rts
; End of function ObjBossBody_0_Routine6


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_Routine8:                 ; DATA XREF: ROM:0020C1E2↑o
        btst    #6,oVar2C(a0)
        bne.s   loc_20C340
        movea.w oVar30(a0),a1
        movea.w oVar32(a0),a2
        bra.s   loc_20C348
; ---------------------------------------------------------------------------

loc_20C340:                             ; CODE XREF: ObjBossBody_0_Routine8+6↑j
        movea.w oVar32(a0),a1
        movea.w oVar30(a0),a2

loc_20C348:                             ; CODE XREF: ObjBossBody_0_Routine8+10↑j
        btst    #0,$2C(a1)
        beq.w   locret_20C42C
        btst    #0,$2C(a2)
        beq.w   locret_20C42C
        movea.w $30(a1),a3
        movea.w $30(a3),a3
        movea.w $30(a2),a4
        movea.w $30(a2),a4
        bclr    #0,$2C(a1)
        bclr    #0,$2C(a3)
        bclr    #0,$2C(a2)
        bclr    #0,$2C(a4)
        cmpi.w  #$B58,oX(a0)
        bgt.s   loc_20C392
        move.b  #1,oVar2D(a0)

loc_20C392:                             ; CODE XREF: ObjBossBody_0_Routine8+5C↑j
        subq.b  #1,oVar2D(a0)
        bne.w   loc_20C3A8
        bset    #0,oVar2C(a0)
        bclr    #1,oVar2C(a0)
        rts
; ---------------------------------------------------------------------------

loc_20C3A8:                             ; CODE XREF: ObjBossBody_0_Routine8+68↑j
        bchg    #6,oVar2C(a0)
        beq.w   loc_20C3F0
        movea.w oVar30(a0),a1
        move.b  #8,$24(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #6,$24(a1)
        movea.w oVar32(a0),a1
        move.b  #2,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w $30(a1),a1
        move.b  #8,$24(a1)
        bsr.w   sub_20C42E
        rts
; ---------------------------------------------------------------------------

loc_20C3F0:                             ; CODE XREF: ObjBossBody_0_Routine8+80↑j
        movea.w oVar30(a0),a1
        move.b  #2,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w $30(a1),a1
        move.b  #8,$24(a1)
        movea.w oVar32(a0),a1
        move.b  #8,$24(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #6,$24(a1)
        bsr.w   sub_20C474

locret_20C42C:                          ; CODE XREF: ObjBossBody_0_Routine8+20↑j ...
        rts
; End of function ObjBossBody_0_Routine8


; =============== S U B R O U T I N E =======================================


sub_20C42E:                             ; CODE XREF: ObjBossBody_0_Routine8+BC↑p ...
        movea.w oVar2E(a0),a1
        movea.w $32(a1),a2
        movea.w $32(a2),a1
        move.l  a1,d0
        beq.s   loc_20C454
        move.b  #2,$24(a1)
        movea.w $30(a1),a1
        move.b  #8,$24(a1)
        move.b  #0,$1A(a1)

loc_20C454:                             ; CODE XREF: sub_20C42E+E↑j
        movea.w $30(a2),a1
        move.l  a1,d0
        beq.s   locret_20C472
        move.b  #6,$24(a1)
        movea.w $30(a1),a1
        move.b  #6,$24(a1)
        move.b  #0,$1A(a1)

locret_20C472:                          ; CODE XREF: sub_20C42E+2C↑j
        rts
; End of function sub_20C42E


; =============== S U B R O U T I N E =======================================


sub_20C474:                             ; CODE XREF: ObjBossBody_0_Routine6+8↑p ...
        movea.w oVar2E(a0),a1
        movea.w $32(a1),a2
        movea.w $32(a2),a1
        move.l  a1,d0
        beq.s   loc_20C49A
        move.b  #6,$24(a1)
        movea.w $30(a1),a1
        move.b  #6,$24(a1)
        move.b  #0,$1A(a1)

loc_20C49A:                             ; CODE XREF: sub_20C474+E↑j
        movea.w $30(a2),a1
        move.l  a1,d0
        beq.s   locret_20C4B8
        move.b  #2,$24(a1)
        movea.w $30(a1),a1
        move.b  #8,$24(a1)
        move.b  #0,$1A(a1)

locret_20C4B8:                          ; CODE XREF: sub_20C474+2C↑j
        rts
; End of function sub_20C474


; =============== S U B R O U T I N E =======================================


sub_20C4BA:                             ; CODE XREF: ObjBossBody_0_RoutineC+E6↓p ...
        movea.w oVar2E(a0),a1
        movea.w $32(a1),a2
        movea.w $32(a2),a1
        move.l  a1,d0
        beq.s   loc_20C4E0
        move.b  #2,$24(a1)
        movea.w $30(a1),a1
        move.b  #$A,$24(a1)
        move.b  #1,$1A(a1)

loc_20C4E0:                             ; CODE XREF: sub_20C4BA+E↑j
        movea.w $30(a2),a1
        move.l  a1,d0
        beq.s   locret_20C4FE
        move.b  #2,$24(a1)
        movea.w $30(a1),a1
        move.b  #$A,$24(a1)
        move.b  #1,$1A(a1)

locret_20C4FE:                          ; CODE XREF: sub_20C4BA+2C↑j
        rts
; End of function sub_20C4BA


; =============== S U B R O U T I N E =======================================


sub_20C500:                             ; CODE XREF: ObjBossBody_0_RoutineC+22↓p
        movem.l a1,-(sp)
        movea.w oVar30(a0),a1
        move.b  #8,$3C(a1)
        movea.w $30(a1),a1
        move.l  #$10000,$3C(a1)
        move.l  #$8000,$10(a1)
        movea.w $30(a1),a1
        move.l  #$C000,$3C(a1)
        move.l  #$18000,$10(a1)
        movea.w oVar32(a0),a1
        move.b  #8,$3C(a1)
        movea.w $30(a1),a1
        move.l  #$10000,$3C(a1)
        move.l  #$8000,$10(a1)
        movea.w $30(a1),a1
        move.l  #$C000,$3C(a1)
        move.l  #$18000,$10(a1)
        movem.l (sp)+,a1
        movea.w oVar2E(a0),a1
        movea.w $32(a1),a2
        movea.w $32(a2),a1
        move.l  a1,d0
        beq.s   loc_20C590
        movea.w $30(a1),a1
        bset    #7,$2C(a1)
        movea.w $30(a1),a1
        bset    #7,$2C(a1)

loc_20C590:                             ; CODE XREF: sub_20C500+7A↑j
        movea.w $30(a2),a1
        move.l  a1,d0
        beq.s   locret_20C5AC
        movea.w $30(a1),a1
        bset    #7,$2C(a1)
        movea.w $30(a1),a1
        bset    #7,$2C(a1)

locret_20C5AC:                          ; CODE XREF: sub_20C500+96↑j
        rts
; End of function sub_20C500


; =============== S U B R O U T I N E =======================================


sub_20C5AE:                             ; CODE XREF: ObjBossBody_0_Routine0+2A↑p ...
        movem.l a1,-(sp)
        movea.w oVar30(a0),a1
        move.b  #2,$3C(a1)
        movea.w $30(a1),a1
        move.l  #$8000,$3C(a1)
        move.l  #$4000,$10(a1)
        movea.w $30(a1),a1
        move.l  #$4000,$3C(a1)
        move.l  #$8000,$10(a1)
        movea.w oVar32(a0),a1
        move.b  #2,$3C(a1)
        movea.w $30(a1),a1
        move.l  #$8000,$3C(a1)
        move.l  #$4000,$10(a1)
        movea.w $30(a1),a1
        move.l  #$4000,$3C(a1)
        move.l  #$8000,$10(a1)
        movem.l (sp)+,a1
        movea.w oVar2E(a0),a1
        movea.w $32(a1),a2
        movea.w $32(a2),a1
        move.l  a1,d0
        beq.s   loc_20C63E
        movea.w $30(a1),a1
        bclr    #7,$2C(a1)
        movea.w $30(a1),a1
        bclr    #7,$2C(a1)

loc_20C63E:                             ; CODE XREF: sub_20C5AE+7A↑j
        movea.w $30(a2),a1
        move.l  a1,d0
        beq.s   locret_20C65A
        movea.w $30(a1),a1
        bclr    #7,$2C(a1)
        movea.w $30(a1),a1
        bclr    #7,$2C(a1)

locret_20C65A:                          ; CODE XREF: sub_20C5AE+96↑j
        rts
; End of function sub_20C5AE


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_RoutineA:                 ; DATA XREF: ROM:0020C1E4↑o
        btst    #6,oVar2C(a0)
        bne.s   loc_20C66E
        movea.w oVar30(a0),a1
        movea.w oVar32(a0),a2
        bra.s   loc_20C676
; ---------------------------------------------------------------------------

loc_20C66E:                             ; CODE XREF: ObjBossBody_0_RoutineA+6↑j
        movea.w oVar32(a0),a1
        movea.w oVar30(a0),a2

loc_20C676:                             ; CODE XREF: ObjBossBody_0_RoutineA+10↑j
        btst    #0,$2C(a1)
        beq.w   locret_20C76A
        btst    #0,$2C(a2)
        beq.w   locret_20C76A
        bset    #1,oVar2C(a0)
        bne.s   loc_20C69A
        bsr.w   sub_20C5AE
        bra.w   loc_20C6E6
; ---------------------------------------------------------------------------

loc_20C69A:                             ; CODE XREF: ObjBossBody_0_RoutineA+34↑j
        movea.w $30(a1),a3
        movea.w $30(a3),a3
        movea.w $30(a2),a4
        movea.w $30(a2),a4
        bclr    #0,$2C(a1)
        bclr    #0,$2C(a3)
        bclr    #0,$2C(a2)
        bclr    #0,$2C(a4)
        cmpi.w  #$BA0,oX(a0)
        blt.s   loc_20C6D0
        move.b  #1,oVar2D(a0)

loc_20C6D0:                             ; CODE XREF: ObjBossBody_0_RoutineA+6C↑j
        subq.b  #1,oVar2D(a0)
        bne.w   loc_20C6E6
        bclr    #1,oVar2C(a0)
        bset    #0,oVar2C(a0)
        rts
; ---------------------------------------------------------------------------

loc_20C6E6:                             ; CODE XREF: ObjBossBody_0_RoutineA+3A↑j ...
        bchg    #6,oVar2C(a0)
        beq.w   loc_20C72E
        movea.w oVar30(a0),a1
        move.b  #$16,$24(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #8,$24(a1)
        movea.w oVar32(a0),a1
        move.b  #$12,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w $30(a1),a1
        move.b  #6,$24(a1)
        bsr.w   sub_20C474
        rts
; ---------------------------------------------------------------------------

loc_20C72E:                             ; CODE XREF: ObjBossBody_0_RoutineA+90↑j
        movea.w oVar30(a0),a1
        move.b  #$12,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w $30(a1),a1
        move.b  #6,$24(a1)
        movea.w oVar32(a0),a1
        move.b  #$16,$24(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #8,$24(a1)
        bsr.w   sub_20C42E

locret_20C76A:                          ; CODE XREF: ObjBossBody_0_RoutineA+20↑j ...
        rts
; End of function ObjBossBody_0_RoutineA


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_RoutineC:                 ; DATA XREF: ROM:0020C1E6↑o
        btst    #6,oVar2C(a0)
        bne.s   loc_20C77E
        movea.w oVar30(a0),a1
        movea.w oVar32(a0),a2
        bra.s   loc_20C786
; ---------------------------------------------------------------------------

loc_20C77E:                             ; CODE XREF: ObjBossBody_0_RoutineC+6↑j
        movea.w oVar32(a0),a1
        movea.w oVar30(a0),a2

loc_20C786:                             ; CODE XREF: ObjBossBody_0_RoutineC+10↑j
        bset    #1,oVar2C(a0)
        bne.s   loc_20C792
        bsr.w   sub_20C500

loc_20C792:                             ; CODE XREF: ObjBossBody_0_RoutineC+20↑j
        cmpi.b  #4,$24(a1)
        bne.s   loc_20C7AE
        movea.w $30(a1),a3
        move.b  #$A,$24(a3)
        movea.w $30(a2),a3
        move.b  #$C,$24(a3)

loc_20C7AE:                             ; CODE XREF: ObjBossBody_0_RoutineC+2C↑j
        btst    #0,$2C(a1)
        beq.w   locret_20C8A4
        btst    #0,$2C(a2)
        beq.w   locret_20C8A4
        movea.w $30(a1),a3
        movea.w $30(a3),a3
        movea.w $30(a2),a4
        movea.w $30(a2),a4
        bclr    #0,$2C(a1)
        bclr    #0,$2C(a3)
        bclr    #0,$2C(a2)
        bclr    #0,$2C(a4)
        subq.b  #1,oVar2D(a0)
        bne.w   loc_20C800
        bset    #0,oVar2C(a0)
        bclr    #1,oVar2C(a0)
        rts
; ---------------------------------------------------------------------------

loc_20C800:                             ; CODE XREF: ObjBossBody_0_RoutineC+82↑j
        bchg    #6,oVar2C(a0)
        beq.w   loc_20C858
        movea.w oVar30(a0),a1
        bclr    #1,$2C(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #$A,$24(a1)
        movea.w $30(a1),a1
        move.b  #2,$24(a1)
        movea.w oVar32(a0),a1
        bclr    #1,$2C(a1)
        move.b  #2,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w $30(a1),a1
        move.b  #$C,$24(a1)
        bsr.w   sub_20C4BA
        rts
; ---------------------------------------------------------------------------

loc_20C858:                             ; CODE XREF: ObjBossBody_0_RoutineC+9A↑j
        movea.w oVar30(a0),a1
        bclr    #1,$2C(a1)
        move.b  #2,$24(a1)
        bsr.w   sub_20C8F4
        bsr.w   sub_20C93C
        movea.w $30(a1),a1
        move.b  #$C,$24(a1)
        movea.w oVar32(a0),a1
        bclr    #1,$2C(a1)
        bsr.w   sub_20C8D0
        bsr.w   sub_20C918
        movea.w $30(a1),a1
        move.b  #$A,$24(a1)
        movea.w $30(a1),a1
        move.b  #2,$24(a1)
        bsr.w   sub_20C4BA

locret_20C8A4:                          ; CODE XREF: ObjBossBody_0_RoutineC+48↑j ...
        rts
; End of function ObjBossBody_0_RoutineC


; =============== S U B R O U T I N E =======================================


ObjBossBody_0_RoutineE:                 ; DATA XREF: ROM:0020C1E8↑o
        btst    #0,oVar2C(a0)
        bne.w   loc_20C8C8
        jsr     CheckSolidDown
        tst.w   d1
        ble.s   locret_20C8C6
        movea.w oVar2E(a0),a1
        addq.w  #2,oY(a0)
        addq.w  #2,$C(a1)

locret_20C8C6:                          ; CODE XREF: ObjBossBody_0_RoutineE+12↑j
        rts
; ---------------------------------------------------------------------------

loc_20C8C8:                             ; CODE XREF: ObjBossBody_0_RoutineE+6↑j
        addq.l  #4,sp
        jmp     DeleteObject
; End of function ObjBossBody_0_RoutineE


; =============== S U B R O U T I N E =======================================


sub_20C8D0:                             ; CODE XREF: ObjBossBody_0_Routine2+22↑p ...
        movem.l a1,-(sp)
        bset    #5,$2C(a1)
        movea.w $30(a1),a1
        bset    #5,$2C(a1)
        movea.w $30(a1),a1
        bset    #5,$2C(a1)
        movem.l (sp)+,a1
        rts
; End of function sub_20C8D0


; =============== S U B R O U T I N E =======================================


sub_20C8F4:                             ; CODE XREF: ObjBossBody_0_Routine4+2C↑p ...
        movem.l a1,-(sp)
        bclr    #5,$2C(a1)
        movea.w $30(a1),a1
        bclr    #5,$2C(a1)
        movea.w $30(a1),a1
        bclr    #5,$2C(a1)
        movem.l (sp)+,a1
        rts
; End of function sub_20C8F4


; =============== S U B R O U T I N E =======================================


sub_20C918:                             ; CODE XREF: ObjBossBody_0_Routine4+42↑p ...
        movem.l a1,-(sp)
        bset    #4,$2C(a1)
        movea.w $30(a1),a1
        bset    #4,$2C(a1)
        movea.w $30(a1),a1
        bset    #4,$2C(a1)
        movem.l (sp)+,a1
        rts
; End of function sub_20C918


; =============== S U B R O U T I N E =======================================


sub_20C93C:                             ; CODE XREF: ObjBossBody_0_Routine4+30↑p ...
        movem.l a1,-(sp)
        bclr    #4,$2C(a1)
        movea.w $30(a1),a1
        bclr    #4,$2C(a1)
        movea.w $30(a1),a1
        bclr    #4,$2C(a1)
        movem.l (sp)+,a1
        rts
; End of function sub_20C93C


; =============== S U B R O U T I N E =======================================


sub_20C960:                             ; CODE XREF: ObjBossForearm_0_Routine4+72↓p
        jsr     FindObjSlot
        bne.s   locret_20C988
        st      oRoutine2(a1)
        move.b  #$18,obj(a1) ; Load Explosion Object
        move.w  oX(a0),oX(a1)
        move.w  oY(a0),oY(a1)
        move.w  #sfx_explosion,d0
        jsr     PlayFMSound

locret_20C988:                          ; CODE XREF: sub_20C960+6↑j
        rts
; End of function sub_20C960


; =============== S U B R O U T I N E =======================================


ObjBossElbow: 
                    ; DATA XREF: ROM:00203C36↑o
	moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20C99E(pc,d0.w),d0
        jsr     off_20C99E(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossElbow

; ---------------------------------------------------------------------------
off_20C99E:
        dc.w ObjBossElbow_0_Routine0-off_20C99E
        dc.w ObjBossElbow_0_Routine2-off_20C99E
        dc.w ObjBossElbow_0_Routine4-off_20C99E

; =============== S U B R O U T I N E =======================================


ObjBossElbow_0_Routine0:                ; DATA XREF: ROM:off_20C99E↑o
        clr.b   oStatus(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #$10,oWidth(a0)
        move.b  #$C,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.l  #Spr_20D902,oSprites(a0)
        move.b  #2,oRoutine(a0)

ObjBossElbow_0_Routine2:                ; DATA XREF: ROM:0020C9A0↑o
        movea.w oVar2E(a0),a1
        move.w  8(a1),oX(a0)
        addi.w  #$18,oX(a0)
        move.w  $C(a1),oY(a0)
        addi.w  #-$C,oY(a0)
        bclr    #6,oVar2C(a0)
        bne.s   loc_20CA12
        bclr    #5,oVar2C(a0)
        bne.s   loc_20C9FC
        rts
; ---------------------------------------------------------------------------

loc_20C9FC:                             ; CODE XREF: ObjBossElbow_0_Routine0+54↑j
        movea.w oVar32(a0),a1
        move.b  #$A,oRoutine(a1)
        clr.w   oVar32(a0)
        move.b  #0,oMapFrame(a1)
        rts
; ---------------------------------------------------------------------------

loc_20CA12:                             ; CODE XREF: ObjBossElbow_0_Routine0+4C↑j
        movea.w oVar30(a0),a1
        move.b  #$A,oRoutine(a1)
        clr.w   oVar30(a0)
        movea.w oVar32(a0),a1
        movea.w $30(a1),a1
        rts
; End of function ObjBossElbow_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossElbow_0_Routine4:                ; DATA XREF: ROM:0020C9A2↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        bset    #1,oVar2C(a0)
        bne.s   loc_20CA44
        move.l  #$FFFF0000,oVar3C(a0)
        move.l  #$FFFE0000,oXVel(a0)
        bra.s   loc_20CA54
; ---------------------------------------------------------------------------

loc_20CA44:                             ; CODE XREF: ObjBossElbow_0_Routine4+6↑j
        addi.l  #-$600,oVar3C(a0)
        addi.l  #$1800,oXVel(a0)

loc_20CA54:                             ; CODE XREF: ObjBossElbow_0_Routine4+18↑j
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20CA74
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20CA74:                             ; CODE XREF: ObjBossElbow_0_Routine4+40↑j
        bra.w   locret_20D7AE
; End of function ObjBossElbow_0_Routine4


; =============== S U B R O U T I N E =======================================


ObjBossUpperArm:                        ; DATA XREF: ROM:00203C3A↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20CA96(pc,d0.w),d0
        jsr     off_20CA96(pc,d0.w)
        btst    #2,oVar2C(a0)
        bne.s   locret_20CA94
        jmp     DrawObject
; ---------------------------------------------------------------------------

locret_20CA94:                          ; CODE XREF: ObjBossUpperArm+14↑j
        rts
; End of function ObjBossUpperArm

; ---------------------------------------------------------------------------
off_20CA96:dc.w ObjBossUpperArm_0_Routine0-*
                                        ; CODE XREF: ObjBossUpperArm+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossUpperArm_0_Routine2-off_20CA96
        dc.w ObjBossUpperArm_0_Routine4-off_20CA96
        dc.w ObjBossUpperArm_0_Routine6-off_20CA96
        dc.w ObjBossUpperArm_0_Routine4-off_20CA96
        dc.w ObjBossUpperArm_0_RoutineA-off_20CA96

; =============== S U B R O U T I N E =======================================


ObjBossUpperArm_0_Routine0:             ; DATA XREF: ROM:off_20CA96↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        clr.b   oFlags(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #8,oWidth(a0)
        move.b  #8,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.l  #Spr_20D910,oSprites(a0)
        move.b  #6,oRoutine(a0)

ObjBossUpperArm_0_Routine2:             ; DATA XREF: ROM:0020CA98↑o
        subq.b  #2,oVar2A(a0)
        bhi.w   loc_20CB6E
        move.b  #4,oRoutine(a0)
        clr.b   oVar2A(a0)
        bset    #0,oVar2C(a0)
        bra.w   loc_20CB6E
; ---------------------------------------------------------------------------

ObjBossUpperArm_0_Routine6:             ; DATA XREF: ROM:0020CA9C↑o
        addq.b  #2,oVar2A(a0)
        cmpi.b  #$30,oVar2A(a0) ; '0'
        bcs.w   loc_20CB6E
        move.b  #8,oRoutine(a0)
        move.b  #$30,oVar2A(a0) ; '0'
        bset    #0,oVar2C(a0)
        bra.w   loc_20CB6E
; ---------------------------------------------------------------------------

ObjBossUpperArm_0_Routine4:             ; DATA XREF: ROM:0020CA9A↑o ...
        bra.w   loc_20CB6E
; ---------------------------------------------------------------------------

ObjBossUpperArm_0_RoutineA:             ; DATA XREF: ROM:0020CAA0↑o
        bset    #1,oVar2C(a0)
        bne.s   loc_20CB3A
        move.b  #0,oVar2B(a0)
        move.l  #$10000,oVar3C(a0)
        move.l  #$FFFE0000,oXVel(a0)
        movea.w oVar30(a0),a1
        move.b  #4,$24(a1)
        bra.s   loc_20CB4A
; ---------------------------------------------------------------------------

loc_20CB3A:                             ; CODE XREF: ObjBossUpperArm_0_Routine0+74↑j
        addi.l  #$600,oVar3C(a0)
        addi.l  #$1F00,oXVel(a0)

loc_20CB4A:                             ; CODE XREF: ObjBossUpperArm_0_Routine0+96↑j
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20CB6A
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20CB6A:                             ; CODE XREF: ObjBossUpperArm_0_Routine0+BE↑j
        bra.w   locret_20D7AE
; ---------------------------------------------------------------------------

loc_20CB6E:                             ; CODE XREF: ObjBossUpperArm_0_Routine0+2E↑j ...
        movea.w oVar2E(a0),a1
        move.w  8(a1),oX(a0)
        move.w  $C(a1),oY(a0)
        moveq   #0,d0
        move.b  oVar2A(a0),d0
        addi.b  #$40,d0 ; '@'
        jsr     CalcSine
        asr.w   #4,d0
        asr.w   #4,d1
        add.w   d1,oX(a0)
        add.w   d0,oY(a0)
        btst    #2,oVar2C(a0)
        beq.s   locret_20CBA8
        addi.w  #-$A,oX(a0)

locret_20CBA8:                          ; CODE XREF: ObjBossUpperArm_0_Routine0+FE↑j
        rts
; End of function ObjBossUpperArm_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossForearm:                         ; DATA XREF: ROM:00203C3E↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20CBBE(pc,d0.w),d0
        jsr     off_20CBBE(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossForearm

; ---------------------------------------------------------------------------
off_20CBBE:dc.w ObjBossForearm_0_Routine0-*
                                        ; CODE XREF: ObjBossForearm+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossForearm_0_Routine2-off_20CBBE
        dc.w ObjBossForearm_0_Routine4-off_20CBBE
        dc.w ObjBossForearm_0_Routine6-off_20CBBE
        dc.w ObjBossForearm_0_Routine8-off_20CBBE
        dc.w ObjBossForearm_0_RoutineA-off_20CBBE

; =============== S U B R O U T I N E =======================================


ObjBossForearm_0_Routine0:              ; DATA XREF: ROM:off_20CBBE↑o
        clr.b   oFlags(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #$20,oWidth(a0) ; ' '
        move.b  #8,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.b  #2,oRoutine(a0)

ObjBossForearm_0_Routine2:              ; CODE XREF: ObjBossForearm_0_Routine6:loc_20CC62↓j ...
        movea.w oVar2E(a0),a1
        move.w  8(a1),oX(a0)
        addi.w  #-$24,oX(a0)
        move.w  oVar34(a0),d0
        add.w   d0,oX(a0)
        move.w  $C(a1),oY(a0)
        addi.w  #0,oY(a0)
        btst    #7,oVar2C(a0)
        bne.s   loc_20CC38
        lea     ($FFD000).l,a1
        move.w  objPlayerSlot+oY-objPlayerSlot(a1),d1
        cmp.w   oY(a0),d1
        bgt.s   loc_20CC38
        cmpi.w  #$FFF8,oVar38(a0)
        ble.s   loc_20CC48
        subi.l  #$10000,oVar38(a0)
        bra.s   loc_20CC48
; ---------------------------------------------------------------------------

loc_20CC38:                             ; CODE XREF: ObjBossForearm_0_Routine0+4C↑j ...
        cmpi.w  #8,oVar38(a0)
        bge.s   loc_20CC48
        addi.l  #$10000,oVar38(a0)

loc_20CC48:                             ; CODE XREF: ObjBossForearm_0_Routine0+62↑j ...
        move.w  oVar38(a0),d0
        add.w   d0,oY(a0)
        rts
; End of function ObjBossForearm_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossForearm_0_Routine6:              ; DATA XREF: ROM:0020CBC4↑o
        cmpi.w  #0,oVar34(a0)
        ble.s   loc_20CC62
        subi.l  #$8000,oVar34(a0)

loc_20CC62:                             ; CODE XREF: ObjBossForearm_0_Routine6+6↑j
        bra.s   ObjBossForearm_0_Routine2
; End of function ObjBossForearm_0_Routine6


; =============== S U B R O U T I N E =======================================


ObjBossForearm_0_Routine8:              ; DATA XREF: ROM:0020CBC6↑o
        cmpi.w  #$10,oVar34(a0)
        bge.s   loc_20CC74
        addi.l  #$8000,oVar34(a0)

loc_20CC74:                             ; CODE XREF: ObjBossForearm_0_Routine8+6↑j
        bra.w   ObjBossForearm_0_Routine2
; End of function ObjBossForearm_0_Routine8


; =============== S U B R O U T I N E =======================================


ObjBossForearm_0_RoutineA:              ; DATA XREF: ROM:0020CBC8↑o
        cmpi.w  #8,oVar34(a0)
        bge.s   loc_20CC8A
        addi.l  #$8000,oVar34(a0)
        bra.s   loc_20CC90
; ---------------------------------------------------------------------------

loc_20CC8A:                             ; CODE XREF: ObjBossForearm_0_RoutineA+6↑j
        move.b  #1,oSprFrame(a0)

loc_20CC90:                             ; CODE XREF: ObjBossForearm_0_RoutineA+10↑j
        movea.w oVar2E(a0),a1
        move.w  oX(a1),oX(a0)
        addi.w  #-$24,oX(a0)
        move.w  oVar34(a0),d0
        add.w   d0,oX(a0)
        move.w  oY(a1),oY(a0)
        addi.w  #0,oY(a0)
        cmpi.w  #8,oVar38(a0)
        bge.s   loc_20CCC4
        addi.l  #$10000,oVar38(a0)

loc_20CCC4:                             ; CODE XREF: ObjBossForearm_0_RoutineA+42↑j
        move.w  oVar38(a0),d0
        add.w   d0,oY(a0)
        rts
; End of function ObjBossForearm_0_RoutineA


; =============== S U B R O U T I N E =======================================


ObjBossForearm_0_Routine4:              ; DATA XREF: ROM:0020CBC2↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        bset    #1,oVar2C(a0)
        bne.s   loc_20CCFC
        move.b  #1,oVar2B(a0)
        clr.b   oVar2A(a0)
        move.l  #0,oVar3C(a0)
        move.l  #$10000,oXVel(a0)
        movea.w oVar30(a0),a1
        move.b  #4,oRoutine(a1)
        bra.s   loc_20CD0C
; ---------------------------------------------------------------------------

loc_20CCFC:                             ; CODE XREF: ObjBossForearm_0_Routine4+6↑j
        addi.l  #-$620,oVar3C(a0)
        addi.l  #$1220,oXVel(a0)

loc_20CD0C:                             ; CODE XREF: ObjBossForearm_0_Routine4+2C↑j
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20CD2C
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20CD2C:                             ; CODE XREF: ObjBossForearm_0_Routine4+54↑j
        addq.b  #1,oVar2A(a0)
        moveq   #0,d2
        move.b  oVar2A(a0),d2
        divu.w  #7,d2
        swap    d2
        tst.w   d2
        bne.s   loc_20CD44
        bsr.w   sub_20C960

loc_20CD44:                             ; CODE XREF: ObjBossForearm_0_Routine4+70↑j
        bra.w   locret_20D7AE
; End of function ObjBossForearm_0_Routine4


; =============== S U B R O U T I N E =======================================


ObjBossBumper:                          ; DATA XREF: ROM:00203C42↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20CD5C(pc,d0.w),d0
        jsr     off_20CD5C(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossBumper

; ---------------------------------------------------------------------------
off_20CD5C:dc.w ObjBossBumper_0_Routine0-*
                                        ; CODE XREF: ObjBossBumper+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossBumper_0_Routine2-off_20CD5C
        dc.w ObjBossBumper_0_Routine4-off_20CD5C

; =============== S U B R O U T I N E =======================================


ObjBossBumper_0_Routine0:               ; DATA XREF: ROM:off_20CD5C↑o
        clr.b   oFlags(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #$C,oWidth(a0)
        move.b  #$10,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.l  #Spr_20D95A,oSprites(a0)
        move.b  #2,oRoutine(a0)

ObjBossBumper_0_Routine2:               ; DATA XREF: ROM:0020CD5E↑o
        movea.w oVar2E(a0),a1
        move.w  8(a1),oX(a0)
        addi.w  #-$C,oX(a0)
        move.w  $C(a1),oY(a0)
        tst.b   $1A(a1)
        beq.s   loc_20CDBC
        cmpi.b  #1,$1A(a1)
        bne.s   loc_20CDB6
        addq.w  #8,oX(a0)
        bra.s   loc_20CDBC
; ---------------------------------------------------------------------------

loc_20CDB6:                             ; CODE XREF: ObjBossBumper_0_Routine0+4C↑j
        addi.w  #$10,oX(a0)

loc_20CDBC:                             ; CODE XREF: ObjBossBumper_0_Routine0+44↑j ...
        bclr    #4,oVar2C(a0)
        beq.s   locret_20CDC8
        subq.w  #4,oX(a0)

locret_20CDC8:                          ; CODE XREF: ObjBossBumper_0_Routine0+60↑j
        rts
; End of function ObjBossBumper_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossBumper_0_Routine4:               ; DATA XREF: ROM:0020CD60↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        bset    #1,oVar2C(a0)
        bne.s   loc_20CDF2
        move.b  #0,oVar2B(a0)
        clr.b   oColType(a0)
        clr.b   oColStatus(a0)
        move.l  #0,oVar3C(a0)
        move.l  #$FFFE8000,oXVel(a0)
        bra.s   loc_20CE02
; ---------------------------------------------------------------------------

loc_20CDF2:                             ; CODE XREF: ObjBossBumper_0_Routine4+6↑j
        addi.l  #-$500,oVar3C(a0)
        addi.l  #$1800,oXVel(a0)

loc_20CE02:                             ; CODE XREF: ObjBossBumper_0_Routine4+26↑j
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20CE22
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20CE22:                             ; CODE XREF: ObjBossBumper_0_Routine4+4E↑j
        bra.w   locret_20D7AE
; End of function ObjBossBumper_0_Routine4


; =============== S U B R O U T I N E =======================================


ObjBossThigh:                           ; DATA XREF: ROM:00203C2A↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20CE3A(pc,d0.w),d0
        jsr     off_20CE3A(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossThigh

; ---------------------------------------------------------------------------
off_20CE3A:dc.w ObjBossThigh_0_Routine0-*
                                        ; CODE XREF: ObjBossThigh+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossThigh_0_Routine2-off_20CE3A
        dc.w ObjBossThigh_0_Routine4-off_20CE3A
        dc.w ObjBossThigh_0_Routine6-off_20CE3A
        dc.w ObjBossThigh_0_Routine8-off_20CE3A
        dc.w ObjBossThigh_0_RoutineA-off_20CE3A
        dc.w ObjBossThigh_0_RoutineC-off_20CE3A
        dc.w ObjBossThigh_0_RoutineE-off_20CE3A
        dc.w ObjBossThigh_0_Routine10-off_20CE3A
        dc.w ObjBossThigh_0_Routine12-off_20CE3A
        dc.w ObjBossThigh_0_Routine14-off_20CE3A
        dc.w ObjBossThigh_0_Routine16-off_20CE3A
        dc.w ObjBossThigh_0_Routine18-off_20CE3A

; =============== S U B R O U T I N E =======================================


ObjBossThigh_0_Routine0:                ; DATA XREF: ROM:off_20CE3A↑o
        clr.b   oFlags(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #8,oWidth(a0)
        move.b  #8,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.l  #Spr_20D8DA,oSprites(a0)
        move.b  #$C,oRoutine(a0)
        move.b  #$58,oVar2A(a0) ; 'X'
        move.b  #2,oVar3C(a0)
        rts
; End of function ObjBossThigh_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossThigh_0_Routine2:                ; DATA XREF: ROM:0020CE3C↑o
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        cmpi.b  #6,$24(a1)
        beq.s   loc_20CEB0
        cmpi.b  #8,$24(a1)
        beq.s   loc_20CEB0
        bclr    #0,$2C(a1)
        move.b  #6,$24(a1)

loc_20CEB0:                             ; CODE XREF: ObjBossThigh_0_Routine2+E↑j ...
        cmpi.b  #0,oVar2A(a0)
        ble.s   loc_20CEC8
        move.b  oVar3C(a0),d0
        sub.b   d0,oVar2A(a0)
        cmpi.b  #0,oVar2A(a0)
        bgt.s   loc_20CEE4

loc_20CEC8:                             ; CODE XREF: ObjBossThigh_0_Routine2+2A↑j
        move.b  #0,oVar2A(a0)
        cmpi.b  #8,$24(a1)
        beq.s   loc_20CEDE
        bclr    #0,$2C(a1)
        beq.s   loc_20CEE4

loc_20CEDE:                             ; CODE XREF: ObjBossThigh_0_Routine2+48↑j
        move.b  #4,oRoutine(a0)

loc_20CEE4:                             ; CODE XREF: ObjBossThigh_0_Routine2+3A↑j ...
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine4:                ; DATA XREF: ROM:0020CE3E↑o
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        move.b  oVar3C(a0),d0
        add.b   d0,oVar2A(a0)
        cmpi.b  #$58,oVar2A(a0) ; 'X'
        bcs.s   loc_20CF12
        move.b  #$58,oVar2A(a0) ; 'X'
        move.b  #6,oRoutine(a0)
        move.b  #2,$24(a1)

loc_20CF12:                             ; CODE XREF: ObjBossThigh_0_Routine2+72↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine6:                ; DATA XREF: ROM:0020CE40↑o
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        btst    #4,$2C(a1)
        beq.s   loc_20CF2C
        bset    #0,oVar2C(a0)

loc_20CF2C:                             ; CODE XREF: ObjBossThigh_0_Routine2+98↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine8:                ; DATA XREF: ROM:0020CE42↑o
        btst    #0,oVar2C(a0)
        bne.s   loc_20CF54
        move.b  oVar3C(a0),d0
        sub.b   d0,oVar2A(a0)
        cmpi.b  #$18,oVar2A(a0)
        bcc.s   loc_20CF54
        move.b  #$18,oVar2A(a0)
        bset    #0,oVar2C(a0)

loc_20CF54:                             ; CODE XREF: ObjBossThigh_0_Routine2+AA↑j ...
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_RoutineA:                ; CODE XREF: ObjBossThigh_0_Routine2+1BC↓j
                                        ; DATA XREF: ...
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        cmpi.b  #8,$24(a1)
        beq.s   loc_20CF70
        move.b  #6,$24(a1)
        bra.s   loc_20CF7A
; ---------------------------------------------------------------------------

loc_20CF70:                             ; CODE XREF: ObjBossThigh_0_Routine2+DA↑j
        cmpi.b  #0,oVar2A(a0)
        beq.w   loc_20CF90

loc_20CF7A:                             ; CODE XREF: ObjBossThigh_0_Routine2+E2↑j
        cmpi.b  #0,oVar2A(a0)
        beq.w   loc_20CF8C
        move.b  oVar3C(a0),d0
        sub.b   d0,oVar2A(a0)

loc_20CF8C:                             ; CODE XREF: ObjBossThigh_0_Routine2+F4↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

loc_20CF90:                             ; CODE XREF: ObjBossThigh_0_Routine2+EA↑j
        bclr    #0,$2C(a1)
        beq.s   loc_20CF9E
        bset    #0,oVar2C(a0)

loc_20CF9E:                             ; CODE XREF: ObjBossThigh_0_Routine2+10A↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_RoutineC:                ; CODE XREF: ObjBossThigh_0_Routine2+1B0↓j
                                        ; DATA XREF: ...
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        cmpi.b  #4,$24(a1)
        beq.s   loc_20CFBA
        move.b  #2,$24(a1)
        bra.s   loc_20CFC4
; ---------------------------------------------------------------------------

loc_20CFBA:                             ; CODE XREF: ObjBossThigh_0_Routine2+124↑j
        cmpi.b  #$58,oVar2A(a0) ; 'X'
        bge.w   loc_20CFDA

loc_20CFC4:                             ; CODE XREF: ObjBossThigh_0_Routine2+12C↑j
        cmpi.b  #$58,oVar2A(a0) ; 'X'
        bge.w   loc_20CFD6
        move.b  oVar3C(a0),d0
        add.b   d0,oVar2A(a0)

loc_20CFD6:                             ; CODE XREF: ObjBossThigh_0_Routine2+13E↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

loc_20CFDA:                             ; CODE XREF: ObjBossThigh_0_Routine2+134↑j
        bclr    #0,$2C(a1)
        beq.s   loc_20CFE8
        bset    #0,oVar2C(a0)

loc_20CFE8:                             ; CODE XREF: ObjBossThigh_0_Routine2+154↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_RoutineE:                ; DATA XREF: ROM:0020CE48↑o
        cmpi.b  #$18,oVar2A(a0)
        blt.s   loc_20D010
        bgt.s   loc_20D040
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        btst    #0,$2C(a1)
        beq.s   loc_20D00C
        bset    #0,oVar2C(a0)

loc_20D00C:                             ; CODE XREF: ObjBossThigh_0_Routine2+178↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

loc_20D010:                             ; CODE XREF: ObjBossThigh_0_Routine2+166↑j
        move.b  oVar3C(a0),d0
        add.b   d0,oVar2A(a0)
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        bset    #7,$2C(a1)
        movea.w oVar2E(a0),a1
        movea.w $32(a1),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        bset    #7,$2C(a1)
        bra.w   ObjBossThigh_0_RoutineC
; ---------------------------------------------------------------------------

loc_20D040:                             ; CODE XREF: ObjBossThigh_0_Routine2+168↑j
        move.b  oVar3C(a0),d0
        sub.b   d0,oVar2A(a0)
        bra.w   ObjBossThigh_0_RoutineA
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine10:               ; DATA XREF: ROM:0020CE4A↑o
        movea.w oVar2E(a0),a1
        movea.w $30(a1),a1
        move.w  8(a1),oX(a0)
        addi.w  #-$A,oX(a0)
        move.w  $C(a1),oY(a0)
        move.w  $2A(a1),oVar2A(a0)
        rts
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine12:               ; DATA XREF: ROM:0020CE4C↑o
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        cmpi.b  #6,$24(a1)
        beq.w   loc_20D0BC
        cmpi.b  #8,$24(a1)
        beq.s   loc_20D098
        bclr    #0,$2C(a1)
        move.b  #6,$24(a1)
        bra.w   loc_20D0BC
; ---------------------------------------------------------------------------

loc_20D098:                             ; CODE XREF: ObjBossThigh_0_Routine2+1FA↑j
        cmpi.b  #$20,oVar2A(a0) ; ' '
        beq.s   loc_20D0AA
        move.b  oVar3C(a0),d0
        sub.b   d0,oVar2A(a0)
        bgt.s   loc_20D0BC

loc_20D0AA:                             ; CODE XREF: ObjBossThigh_0_Routine2+212↑j
        move.b  #$20,oVar2A(a0) ; ' '
        bclr    #0,$2C(a1)
        move.b  #$14,oRoutine(a0)

loc_20D0BC:                             ; CODE XREF: ObjBossThigh_0_Routine2+1F0↑j ...
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine14:               ; DATA XREF: ROM:0020CE4E↑o
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        move.b  oVar3C(a0),d0
        add.b   d0,oVar2A(a0)
        cmpi.b  #$30,oVar2A(a0) ; '0'
        blt.s   loc_20D0EA
        move.b  #$30,oVar2A(a0) ; '0'
        move.b  #6,oRoutine(a0)
        move.b  #2,$24(a1)

loc_20D0EA:                             ; CODE XREF: ObjBossThigh_0_Routine2+24A↑j
        bra.w   loc_20D132
; ---------------------------------------------------------------------------

ObjBossThigh_0_Routine16:               ; DATA XREF: ROM:0020CE50↑o
        btst    #0,oVar2C(a0)
        bne.s   loc_20D12E
        movea.w oVar30(a0),a1
        movea.w $30(a1),a1
        cmpi.b  #2,$24(a1)
        beq.s   loc_20D114
        cmpi.b  #4,$24(a1)
        beq.s   loc_20D118
        move.b  #2,$24(a1)

loc_20D114:                             ; CODE XREF: ObjBossThigh_0_Routine2+278↑j
        bra.w   loc_20D12E
; ---------------------------------------------------------------------------

loc_20D118:                             ; CODE XREF: ObjBossThigh_0_Routine2+280↑j
        move.b  oVar3C(a0),d0
        add.b   d0,oVar2A(a0)
        cmpi.b  #$50,oVar2A(a0) ; 'P'
        blt.s   loc_20D12E
        bset    #0,oVar2C(a0)

loc_20D12E:                             ; CODE XREF: ObjBossThigh_0_Routine2+268↑j ...
        bra.w   *+4
; ---------------------------------------------------------------------------

loc_20D132:                             ; CODE XREF: ObjBossThigh_0_Routine2:loc_20CEE4↑j ...
        moveq   #0,d0
        move.b  oVar2A(a0),d0
        jsr     CalcSine
        moveq   #0,d2
        moveq   #0,d3
        asr.w   #4,d0
        asr.w   #4,d1
        btst    #4,oVar2C(a0)
        beq.w   loc_20D198
        btst    #5,oVar2C(a0)
        beq.w   loc_20D19E
        bset    #1,oVar2C(a0)
        bne.s   loc_20D16A
        move.w  d1,oVar34(a0)
        move.w  d0,oVar38(a0)

loc_20D16A:                             ; CODE XREF: ObjBossThigh_0_Routine2+2D4↑j
        move.w  d0,d2
        move.w  d1,d3
        sub.w   oVar34(a0),d3
        sub.w   oVar38(a0),d2
        move.w  d1,oVar34(a0)
        move.w  d0,oVar38(a0)
        movea.w oVar2E(a0),a1
        sub.w   d3,8(a1)
        sub.w   d2,$C(a1)
        movea.w $2E(a1),a1
        sub.w   d3,8(a1)
        sub.w   d2,$C(a1)
        rts
; ---------------------------------------------------------------------------

loc_20D198:                             ; CODE XREF: ObjBossThigh_0_Routine2+2C0↑j
        bclr    #1,oVar2C(a0)

loc_20D19E:                             ; CODE XREF: ObjBossThigh_0_Routine2+2CA↑j
        movea.w oVar2E(a0),a1
        move.w  8(a1),d2
        addi.w  #$C,d2
        add.w   d1,d2
        btst    #2,oVar2C(a0)
        beq.s   loc_20D1B8
        addi.w  #-$A,d2

loc_20D1B8:                             ; CODE XREF: ObjBossThigh_0_Routine2+326↑j
        move.w  d2,oX(a0)
        move.w  $C(a1),d2
        addi.w  #$14,d2
        add.w   d0,d2
        move.w  d2,oY(a0)
        rts
; End of function ObjBossThigh_0_Routine2


; =============== S U B R O U T I N E =======================================


ObjBossThigh_0_Routine18:               ; DATA XREF: ROM:0020CE52↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        bset    #1,oVar2C(a0)
        bne.s   loc_20D200
        btst    #4,oVar2C(a0)
        beq.s   loc_20D1EE
        move.l  #0,oVar3C(a0)
        move.l  #$FFFD8000,oXVel(a0)
        bra.s   loc_20D22A
; ---------------------------------------------------------------------------

loc_20D1EE:                             ; CODE XREF: ObjBossThigh_0_Routine18+E↑j
        move.l  #0,oVar3C(a0)
        move.l  #$FFFD8000,oXVel(a0)
        bra.s   loc_20D22A
; ---------------------------------------------------------------------------

loc_20D200:                             ; CODE XREF: ObjBossThigh_0_Routine18+6↑j
        btst    #4,oVar2C(a0)
        beq.s   loc_20D21A
        addi.l  #-$600,oVar3C(a0)
        addi.l  #$1860,oXVel(a0)
        bra.s   loc_20D22A
; ---------------------------------------------------------------------------

loc_20D21A:                             ; CODE XREF: ObjBossThigh_0_Routine18+3A↑j
        subi.l  #$FFFFFA00,oVar3C(a0)
        addi.l  #$1860,oXVel(a0)

loc_20D22A:                             ; CODE XREF: ObjBossThigh_0_Routine18+20↑j ...
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20D24A
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20D24A:                             ; CODE XREF: ObjBossThigh_0_Routine18+74↑j
        bra.w   locret_20D7AE
; End of function ObjBossThigh_0_Routine18


; =============== S U B R O U T I N E =======================================


ObjBossCalf:                            ; DATA XREF: ROM:00203C2E↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20D262(pc,d0.w),d0
        jsr     off_20D262(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossCalf

; ---------------------------------------------------------------------------
off_20D262:dc.w ObjBossCalf_0_Routine0-*
                                        ; CODE XREF: ObjBossCalf+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossCalf_0_Routine2-off_20D262
        dc.w ObjBossCalf_0_Routine4-off_20D262
        dc.w ObjBossCalf_0_Routine6-off_20D262
        dc.w ObjBossCalf_0_Routine8-off_20D262
        dc.w ObjBossCalf_0_RoutineA-off_20D262
        dc.w ObjBossCalf_0_RoutineC-off_20D262
        dc.w ObjBossCalf_0_RoutineE-off_20D262

; =============== S U B R O U T I N E =======================================


ObjBossCalf_0_Routine0:                 ; DATA XREF: ROM:off_20D262↑o
        clr.b   oFlags(a0)
        move.b  #2,oRoutine(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #8,oWidth(a0)
        move.b  #$14,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.l  #Spr_20D8E2,oSprites(a0)
        move.l  #$8000,oVar3C(a0)
        move.l  #$4000,oXVel(a0)
        rts
; End of function ObjBossCalf_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossCalf_0_Routine2:                 ; DATA XREF: ROM:0020D264↑o
        movea.w oVar2E(a0),a1
        move.w  8(a1),d2
        addq.w  #4,d2
        move.w  d2,oX(a0)
        move.w  $C(a1),d2
        addi.w  #$10,d2
        move.w  d2,oY(a0)
        rts
; End of function ObjBossCalf_0_Routine2


; =============== S U B R O U T I N E =======================================


ObjBossCalf_0_Routine4:                 ; DATA XREF: ROM:0020D266↑o
        movea.w oVar2E(a0),a1
        movea.w $2E(a1),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        move.w  8(a1),oX(a0)
        addi.w  #-$A,oX(a0)
        move.w  $C(a1),oY(a0)
        rts
; End of function ObjBossCalf_0_Routine4


; =============== S U B R O U T I N E =======================================


ObjBossCalf_0_Routine6:                 ; DATA XREF: ROM:0020D268↑o
        cmpi.w  #8,oVar34(a0)
        bge.s   loc_20D30E
        move.l  oVar3C(a0),d1
        add.l   d1,oVar34(a0)
        btst    #4,oVar2C(a0)
        beq.s   loc_20D30E
        neg.l   d1
        moveq   #0,d2
        bra.w   loc_20D3AC
; ---------------------------------------------------------------------------

loc_20D30E:                             ; CODE XREF: ObjBossCalf_0_Routine6+6↑j ...
        bra.w   loc_20D3DE
; ---------------------------------------------------------------------------

ObjBossCalf_0_Routine8:                 ; DATA XREF: ROM:0020D26A↑o
        move.w  #0,oVar38(a0)
        cmpi.w  #$FFF8,oVar34(a0)
        ble.s   loc_20D336
        move.l  oVar3C(a0),d1
        sub.l   d1,oVar34(a0)
        btst    #4,oVar2C(a0)
        beq.s   loc_20D336
        moveq   #0,d2
        bra.w   loc_20D3AC
; ---------------------------------------------------------------------------

loc_20D336:                             ; CODE XREF: ObjBossCalf_0_Routine6+30↑j ...
        bra.w   loc_20D3DE
; ---------------------------------------------------------------------------

ObjBossCalf_0_RoutineA:                 ; DATA XREF: ROM:0020D26C↑o
        cmpi.w  #$FFF8,oVar34(a0)
        ble.s   loc_20D34C
        move.l  oVar3C(a0),d1
        sub.l   d1,oVar34(a0)
        bra.s   loc_20D34E
; ---------------------------------------------------------------------------

loc_20D34C:                             ; CODE XREF: ObjBossCalf_0_Routine6+52↑j
        moveq   #0,d1

loc_20D34E:                             ; CODE XREF: ObjBossCalf_0_Routine6+5C↑j
        cmpi.w  #$FFFC,oVar38(a0)
        ble.s   loc_20D360
        move.l  oXVel(a0),d2
        sub.l   d2,oVar38(a0)
        bra.s   loc_20D362
; ---------------------------------------------------------------------------

loc_20D360:                             ; CODE XREF: ObjBossCalf_0_Routine6+66↑j
        moveq   #0,d2

loc_20D362:                             ; CODE XREF: ObjBossCalf_0_Routine6+70↑j
        btst    #4,oVar2C(a0)
        beq.s   loc_20D36E
        bra.w   loc_20D3AC
; ---------------------------------------------------------------------------

loc_20D36E:                             ; CODE XREF: ObjBossCalf_0_Routine6+7A↑j
        bra.w   loc_20D3DE
; ---------------------------------------------------------------------------

ObjBossCalf_0_RoutineC:                 ; DATA XREF: ROM:0020D26E↑o
        cmpi.w  #$FFF8,oVar34(a0)
        ble.s   loc_20D384
        move.l  oVar3C(a0),d1
        sub.l   d1,oVar34(a0)
        bra.s   loc_20D386
; ---------------------------------------------------------------------------

loc_20D384:                             ; CODE XREF: ObjBossCalf_0_Routine6+8A↑j
        moveq   #0,d1

loc_20D386:                             ; CODE XREF: ObjBossCalf_0_Routine6+94↑j
        cmpi.w  #4,oVar38(a0)
        bge.s   loc_20D398
        move.l  oXVel(a0),d2
        add.l   d2,oVar38(a0)
        bra.s   loc_20D39A
; ---------------------------------------------------------------------------

loc_20D398:                             ; CODE XREF: ObjBossCalf_0_Routine6+9E↑j
        moveq   #0,d2

loc_20D39A:                             ; CODE XREF: ObjBossCalf_0_Routine6+A8↑j
        btst    #4,oVar2C(a0)
        beq.s   loc_20D3A8
        neg.l   d2
        bra.w   loc_20D3AC
; ---------------------------------------------------------------------------

loc_20D3A8:                             ; CODE XREF: ObjBossCalf_0_Routine6+B2↑j
        bra.w   loc_20D3DE
; ---------------------------------------------------------------------------

loc_20D3AC:                             ; CODE XREF: ObjBossCalf_0_Routine6+1C↑j ...
        btst    #5,oVar2C(a0)
        bne.w   loc_20D3B8
        rts
; ---------------------------------------------------------------------------

loc_20D3B8:                             ; CODE XREF: ObjBossCalf_0_Routine6+C4↑j
        movea.w oVar2E(a0),a3
        add.l   d1,8(a3)
        add.l   d2,$C(a3)
        movea.w $2E(a3),a3
        add.l   d1,8(a3)
        add.l   d2,$C(a3)
        movea.w $2E(a3),a3
        add.l   d1,8(a3)
        add.l   d2,$C(a3)
        rts
; ---------------------------------------------------------------------------

loc_20D3DE:                             ; CODE XREF: ObjBossCalf_0_Routine6:loc_20D30E↑j ...
        movea.w oVar2E(a0),a1
        move.w  8(a1),d0
        addq.w  #4,d0
        move.w  d0,oX(a0)
        move.w  oVar34(a0),d0
        add.w   d0,oX(a0)
        move.w  $C(a1),d0
        addi.w  #$10,d0
        move.w  d0,oY(a0)
        move.w  oVar38(a0),d0
        add.w   d0,oY(a0)
        rts
; End of function ObjBossCalf_0_Routine6


; =============== S U B R O U T I N E =======================================


ObjBossCalf_0_RoutineE:                 ; DATA XREF: ROM:0020D270↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        bset    #1,oVar2C(a0)
        bne.s   loc_20D43E
        btst    #4,oVar2C(a0)
        bne.s   loc_20D42C
        move.l  #0,oVar3C(a0)
        move.l  #$FFFE0000,oXVel(a0)
        bra.s   loc_20D468
; ---------------------------------------------------------------------------

loc_20D42C:                             ; CODE XREF: ObjBossCalf_0_RoutineE+E↑j
        move.l  #0,oVar3C(a0)
        move.l  #$FFFE0000,oXVel(a0)
        bra.s   loc_20D468
; ---------------------------------------------------------------------------

loc_20D43E:                             ; CODE XREF: ObjBossCalf_0_RoutineE+6↑j
        btst    #4,oVar2C(a0)
        bne.s   loc_20D458
        addi.l  #-$600,oVar3C(a0)
        addi.l  #$1A60,oXVel(a0)
        bra.s   loc_20D468
; ---------------------------------------------------------------------------

loc_20D458:                             ; CODE XREF: ObjBossCalf_0_RoutineE+3A↑j
        subi.l  #$FFFFFA00,oVar3C(a0)
        addi.l  #$1A60,oXVel(a0)

loc_20D468:                             ; CODE XREF: ObjBossCalf_0_RoutineE+20↑j ...
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20D488
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20D488:                             ; CODE XREF: ObjBossCalf_0_RoutineE+74↑j
        bra.w   locret_20D7AE
; End of function ObjBossCalf_0_RoutineE


; =============== S U B R O U T I N E =======================================


ObjBossFoot:                            ; DATA XREF: ROM:00203C32↑o
        moveq   #0,d0
        move.b  oRoutine(a0),d0
        move.w  off_20D4A0(pc,d0.w),d0
        jsr     off_20D4A0(pc,d0.w)
        jmp     DrawObject
; End of function ObjBossFoot

; ---------------------------------------------------------------------------
off_20D4A0:dc.w ObjBossFoot_0_Routine0-*
                                        ; CODE XREF: ObjBossFoot+A↑p
                                        ; DATA XREF: ...
        dc.w ObjBossFoot_0_Routine2-off_20D4A0
        dc.w ObjBossFoot_0_Routine4-off_20D4A0
        dc.w ObjBossFoot_0_Routine6-off_20D4A0
        dc.w ObjBossFoot_0_Routine8-off_20D4A0
        dc.w ObjBossFoot_0_RoutineA-off_20D4A0
        dc.w ObjBossFoot_0_RoutineC-off_20D4A0

; =============== S U B R O U T I N E =======================================


ObjBossFoot_0_Routine0:                 ; DATA XREF: ROM:off_20D4A0↑o
        clr.b   oFlags(a0)
        move.b  #4,oSprFlags(a0)
        move.b  #$20,oWidth(a0) ; ' '
        move.b  #$14,oYRadius(a0)
        move.w  #$2359,oTile(a0)
        move.l  #Spr_20D8F0,oSprites(a0)
        move.l  #$4000,oVar3C(a0)
        move.l  #$8000,oXVel(a0)
        move.b  #4,oRoutine(a0)
        bset    #0,oVar2C(a0)
        move.w  #$FFF8,oVar34(a0)
        move.w  #$10,oVar38(a0)
        bra.w   loc_20D67A
; ---------------------------------------------------------------------------

ObjBossFoot_0_Routine2:                 ; DATA XREF: ROM:0020D4A2↑o
        move.l  oVar3C(a0),d0
        sub.l   d0,oVar34(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oVar38(a0)
        btst    #4,oVar2C(a0)
        beq.s   loc_20D52A
        btst    #7,oVar2C(a0)
        beq.s   loc_20D52A
        cmpi.w  #$C,oVar38(a0)
        blt.s   loc_20D536
        bra.w   loc_20D548
; ---------------------------------------------------------------------------

loc_20D52A:                             ; CODE XREF: ObjBossFoot_0_Routine0+66↑j ...
        cmpi.w  #$10,oVar38(a0)
        blt.s   loc_20D536
        bra.w   loc_20D548
; ---------------------------------------------------------------------------

loc_20D536:                             ; CODE XREF: ObjBossFoot_0_Routine0+76↑j ...
        bsr.w   loc_20D620
        jsr     CheckSolidDown
        tst.w   d1
        ble.w   loc_20D556
        rts
; ---------------------------------------------------------------------------

loc_20D548:                             ; CODE XREF: ObjBossFoot_0_Routine0+78↑j ...
        bset    #0,oVar2C(a0)
        move.b  #4,oRoutine(a0)
        rts
; ---------------------------------------------------------------------------

loc_20D556:                             ; CODE XREF: ObjBossFoot_0_Routine0+94↑j ...
        bset    #4,oVar2C(a0)
        movea.w oVar2E(a0),a3
        bset    #4,$2C(a3)
        movea.w $2E(a3),a3
        bset    #4,$2C(a3)
        movea.w $2E(a3),a3
        movea.w $2E(a3),a3
        move.b  #8,$35(a3)
        move.w  #$7E,d0 ; '~'
        jsr     SubCPUCmd
        rts
; ---------------------------------------------------------------------------

ObjBossFoot_0_Routine6:                 ; DATA XREF: ROM:0020D4A6↑o
        move.l  oVar3C(a0),d0
        add.l   d0,oVar34(a0)
        move.l  oXVel(a0),d0
        sub.l   d0,oVar38(a0)
        cmpi.w  #0,oVar38(a0)
        bgt.s   loc_20D5C2
        move.w  #0,oVar34(a0)
        clr.w   oVar36(a0)
        move.w  #0,oVar38(a0)
        clr.w   oVar3A(a0)
        bset    #0,oVar2C(a0)
        move.b  #8,oRoutine(a0)

loc_20D5C2:                             ; CODE XREF: ObjBossFoot_0_Routine0+F2↑j
        bra.w   loc_20D620
; ---------------------------------------------------------------------------

ObjBossFoot_0_Routine4:                 ; DATA XREF: ROM:0020D4A4↑o
        btst    #4,oVar2C(a0)
        bne.w   locret_20D5E0
        bsr.w   loc_20D67A
        jsr     CheckSolidDown
        tst.w   d1
        ble.w   loc_20D556

locret_20D5E0:                          ; CODE XREF: ObjBossFoot_0_Routine0+11E↑j
        rts
; ---------------------------------------------------------------------------

ObjBossFoot_0_Routine8:                 ; DATA XREF: ROM:0020D4A8↑o
        bsr.w   loc_20D67A
        rts
; ---------------------------------------------------------------------------

ObjBossFoot_0_RoutineA:                 ; DATA XREF: ROM:0020D4AA↑o
        movea.w oVar2E(a0),a1
        movea.w $2E(a1),a1
        movea.w $2E(a1),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        movea.w $30(a1),a1
        move.w  8(a1),oX(a0)
        addi.w  #-$A,oX(a0)
        move.w  $C(a1),oY(a0)
        move.w  $34(a1),oVar34(a0)
        move.w  $38(a1),oVar38(a0)
        rts
; ---------------------------------------------------------------------------

loc_20D620:                             ; CODE XREF: ObjBossFoot_0_Routine0:loc_20D536↑p ...
        btst    #4,oVar2C(a0)
        beq.s   loc_20D67A
        btst    #5,oVar2C(a0)
        bne.w   loc_20D634
        rts
; ---------------------------------------------------------------------------

loc_20D634:                             ; CODE XREF: ObjBossFoot_0_Routine0+180↑j
        move.l  oVar3C(a0),d1
        move.l  oXVel(a0),d2
        cmpi.b  #6,oRoutine(a0)
        beq.s   loc_20D648
        neg.l   d1
        neg.l   d2

loc_20D648:                             ; CODE XREF: ObjBossFoot_0_Routine0+194↑j
        movea.w oVar2E(a0),a3
        sub.l   d1,8(a3)
        add.l   d2,$C(a3)
        movea.w $2E(a3),a3
        sub.l   d1,8(a3)
        add.l   d2,$C(a3)
        movea.w $2E(a3),a3
        sub.l   d1,8(a3)
        add.l   d2,$C(a3)
        movea.w $2E(a3),a3
        sub.l   d1,8(a3)
        add.l   d2,$C(a3)
        rts
; ---------------------------------------------------------------------------

loc_20D67A:                             ; CODE XREF: ObjBossFoot_0_Routine0+4C↑j ...
        movea.w oVar2E(a0),a1
        move.w  8(a1),d0
        addi.w  #-$B,d0
        move.w  d0,oX(a0)
        move.w  oVar34(a0),d0
        add.w   d0,oX(a0)
        move.w  $C(a1),d0
        addi.w  #$E,d0
        move.w  d0,oY(a0)
        move.w  oVar38(a0),d0
        add.w   d0,oY(a0)
        rts
; End of function ObjBossFoot_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjBossFoot_0_RoutineC:                 ; DATA XREF: ROM:0020D4AC↑o

; FUNCTION CHUNK AT 0020D7AE SIZE 00000002 BYTES

        bset    #1,oVar2C(a0)
        bne.s   loc_20D6DC
        btst    #4,oVar2C(a0)
        beq.s   loc_20D6CA
        move.l  #0,oVar3C(a0)
        move.l  #$FFFDD000,oXVel(a0)
        bra.s   loc_20D706
; ---------------------------------------------------------------------------

loc_20D6CA:                             ; CODE XREF: ObjBossFoot_0_RoutineC+E↑j
        move.l  #0,oVar3C(a0)
        move.l  #$FFFDD000,oXVel(a0)
        bra.s   loc_20D706
; ---------------------------------------------------------------------------

loc_20D6DC:                             ; CODE XREF: ObjBossFoot_0_RoutineC+6↑j
        btst    #4,oVar2C(a0)
        bne.s   loc_20D6F6
        addi.l  #-$660,oVar3C(a0)
        addi.l  #$1660,oXVel(a0)
        bra.s   loc_20D706
; ---------------------------------------------------------------------------

loc_20D6F6:                             ; CODE XREF: ObjBossFoot_0_RoutineC+3A↑j
        subi.l  #$FFFFF9A0,oVar3C(a0)
        addi.l  #$1660,oXVel(a0)

loc_20D706:                             ; CODE XREF: ObjBossFoot_0_RoutineC+20↑j ...
        move.l  oVar3C(a0),d0
        add.l   d0,oX(a0)
        move.l  oXVel(a0),d0
        add.l   d0,oY(a0)
        cmpi.w  #$240,oY(a0)
        blt.s   loc_20D726
        addq.l  #4,sp
        jmp     DeleteObject
; ---------------------------------------------------------------------------

loc_20D726:                             ; CODE XREF: ObjBossFoot_0_RoutineC+74↑j
        bra.w   locret_20D7AE
; End of function ObjBossFoot_0_RoutineC


; =============== S U B R O U T I N E =======================================


sub_20D72A:                             ; CODE XREF: ObjBossEggman_0_Routine6+4↑p ...
        moveq   #0,d2
        move.b  oVar2B(a0),d2
        divu.w  #4,d2
        swap    d2
        tst.w   d2
        bne.s   locret_20D784
        clr.w   d2
        swap    d2
        divu.w  #$A,d2
        swap    d2
        add.w   d2,d2
        add.w   d2,d2
        jsr     FindObjSlot
        bne.s   locret_20D784
        st      oRoutine2(a1)
        lea     (unk_20D786).l,a2
        adda.w  d2,a2
        move.b  #$18,obj(a1)
        move.w  oX(a0),oX(a1)
        move.w  oY(a0),oY(a1)
        move.w  (a2)+,d0
        add.w   d0,oX(a1)
        move.w  (a2),d0
        add.w   d0,oY(a1)
        move.w  #sfx_explosion,d0
        jsr     PlayFMSound

locret_20D784:                          ; CODE XREF: sub_20D72A+E↑j ...
        rts
; End of function sub_20D72A

; ---------------------------------------------------------------------------
unk_20D786:dc.b $FF                     ; DATA XREF: sub_20D72A+2A↑o
        dc.b $D0
        dc.b $FF
        dc.b $F0
        dc.b   0
        dc.b $30 ; 0
        dc.b   0
        dc.b $10
        dc.b $FF
        dc.b $F0
        dc.b $FF
        dc.b $F0
        dc.b   0
        dc.b $10
        dc.b   0
        dc.b $10
        dc.b $FF
        dc.b $E0
        dc.b   0
        dc.b   0
        dc.b   0
        dc.b $30 ; 0
        dc.b $FF
        dc.b $F0
        dc.b $FF
        dc.b $D0
        dc.b   0
        dc.b $10
        dc.b $FF
        dc.b $F0
        dc.b   0
        dc.b $10
        dc.b   0
        dc.b $10
        dc.b $FF
        dc.b $F0
        dc.b   0
        dc.b $20
        dc.b   0
        dc.b   0
; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR ObjBossElbow_0_Routine4
;   ADDITIONAL PARENT FUNCTION ObjBossUpperArm_0_Routine0
;   ADDITIONAL PARENT FUNCTION ObjBossForearm_0_Routine4
;   ADDITIONAL PARENT FUNCTION ObjBossBumper_0_Routine4
;   ADDITIONAL PARENT FUNCTION ObjBossThigh_0_Routine18
;   ADDITIONAL PARENT FUNCTION ObjBossCalf_0_RoutineE
;   ADDITIONAL PARENT FUNCTION ObjBossFoot_0_RoutineC

locret_20D7AE:                          ; CODE XREF: ObjBossElbow_0_Routine4:loc_20CA74↑j ...
        rts
; END OF FUNCTION CHUNK FOR ObjBossElbow_0_Routine4

Ani_20D7BC:dc.w .Ani_20D7BC_0-*         ; DATA XREF: ObjBossEggman+1E↑o ...
        dc.w .Ani_20D7BC_1-Ani_20D7BC
        dc.w .Ani_20D7BC_2-Ani_20D7BC
        dc.w .Ani_20D7BC_3-Ani_20D7BC
        dc.w .Ani_20D7BC_4-Ani_20D7BC
.Ani_20D7BC_0:dc.b $3B                  ; DATA XREF: ROM:Ani_20D7BC↑o
        dc.b 0
        dc.b $FF
.Ani_20D7BC_1:dc.b 7                    ; DATA XREF: ROM:0020D7BE↑o
        dc.b 2, 3
        dc.b $FF
.Ani_20D7BC_2:dc.b 3                    ; DATA XREF: ROM:0020D7C0↑o
        dc.b 1, 5, 4, 6
        dc.b $FF
.Ani_20D7BC_3:dc.b 3                    ; DATA XREF: ROM:0020D7C2↑o
        dc.b 7, 8
        dc.b $FF
.Ani_20D7BC_4:dc.b 3                    ; DATA XREF: ROM:0020D7C4↑o
        dc.b 9, $A
        dc.b $FF
        dc.b   0

Spr_20D7DC:dc.w .Spr_20D7DC_0-*         ; DATA XREF: ROM:0020713E↑o ...
        dc.w .Spr_20D7DC_1-Spr_20D7DC
        dc.w .Spr_20D7DC_2-Spr_20D7DC
        dc.w .Spr_20D7DC_3-Spr_20D7DC
        dc.w .Spr_20D7DC_4-Spr_20D7DC
        dc.w .Spr_20D7DC_5-Spr_20D7DC
        dc.w .Spr_20D7DC_6-Spr_20D7DC
        dc.w .Spr_20D7DC_7-Spr_20D7DC
        dc.w .Spr_20D7DC_8-Spr_20D7DC
        dc.w .Spr_20D7DC_9-Spr_20D7DC
        dc.w .Spr_20D7DC_A-Spr_20D7DC
.Spr_20D7DC_0:dc.b 2                    ; DATA XREF: ROM:Spr_20D7DC↑o
        dc.b $E8, $D, 0, 0, $E4
        dc.b $E8, 1, 0, 8, 4
        dc.b   0
.Spr_20D7DC_1:dc.b 3                    ; DATA XREF: ROM:0020D7DE↑o
        dc.b $D8, 5, 8, $32, $E4
        dc.b $E8, $D, 0, $A, $E4
        dc.b $E8, 1, 0, $12, 4
.Spr_20D7DC_2:dc.b 2                    ; DATA XREF: ROM:0020D7E0↑o
        dc.b $E8, $D, 0, $14, $E4
        dc.b $E8, 1, 0, $1C, 4
        dc.b   0
.Spr_20D7DC_3:dc.b 2                    ; DATA XREF: ROM:0020D7E2↑o
        dc.b $E8, $D, 0, $1E, $E4
        dc.b $E8, 1, 0, $26, 4
        dc.b   0
.Spr_20D7DC_4:dc.b 3                    ; DATA XREF: ROM:0020D7E4↑o
        dc.b $D8, 5, 8, $36, $E4
        dc.b $E8, $D, 0, $28, $E4
        dc.b $E8, 1, 0, $30, 4
.Spr_20D7DC_5:dc.b 2                    ; DATA XREF: ROM:0020D7E6↑o
        dc.b $E8, $D, 0, $A, $E4
        dc.b $E8, 1, 0, $12, 4
        dc.b   0
.Spr_20D7DC_6:dc.b 2                    ; DATA XREF: ROM:0020D7E8↑o
        dc.b $E8, $D, 0, $28, $E4
        dc.b $E8, 1, 0, $30, 4
        dc.b   0
.Spr_20D7DC_7:dc.b 4                    ; DATA XREF: ROM:0020D7EA↑o
        dc.b $E8, $F, 0, $3A, $E8
        dc.b $E8, 7, 0, $4A, 8
        dc.b 8, $E, 0, $52, $F0
        dc.b 8, 1, 0, $6D, $E4
        dc.b   0
.Spr_20D7DC_8:dc.b 4                    ; DATA XREF: ROM:0020D7EC↑o
        dc.b $E8, $F, 0, $3A, $E8
        dc.b $E8, 7, 0, $4A, 8
        dc.b 8, $E, 0, $52, $F0
        dc.b 8, 0, 0, $6F, $E4
        dc.b   0
.Spr_20D7DC_9:dc.b 5                    ; DATA XREF: ROM:0020D7EE↑o
        dc.b $E8, $F, 0, $3A, $E8
        dc.b $E8, 7, 0, $4A, 8
        dc.b 8, $E, 0, $5E, $E8
        dc.b 8, 2, 0, $6A, 8
        dc.b 8, 1, 0, $6D, $E4
.Spr_20D7DC_A:dc.b 5                    ; DATA XREF: ROM:0020D7F0↑o
        dc.b $E8, $F, 0, $3A, $E8
        dc.b $E8, 7, 0, $4A, 8
        dc.b 8, $E, 0, $5E, $E8
        dc.b 8, 2, 0, $6A, 8
        dc.b 8, 0, 0, $6F, $E4        
Spr_20D918:dc.w .Spr_20D918_0-*         ; DATA XREF: sub_20BD36+14A↑o ...
        dc.w .Spr_20D918_1-Spr_20D918
        dc.w .Spr_20D918_2-Spr_20D918
.Spr_20D918_0:dc.b 2                    ; DATA XREF: ROM:Spr_20D918↑o
        dc.b $F8, $D, 0, $45, $F2
        dc.b $F8, 9, 0, $57, $A
        dc.b   0
.Spr_20D918_1:dc.b 2                    ; DATA XREF: ROM:0020D91A↑o
        dc.b $F8, 9, 0, $4D, $FA
        dc.b $F8, 9, 0, $57, $A
        dc.b   0
.Spr_20D918_2:dc.b 2                    ; DATA XREF: ROM:0020D91C↑o
        dc.b $F8, 5, 0, $53, 2
        dc.b $F8, 9, 0, $57, $A
        dc.b   0        

Spr_20D942:dc.w .Spr_20D942_0-*         ; DATA XREF: sub_20BD36+1C2↑o ...
        dc.w .Spr_20D942_1-Spr_20D942
        dc.w .Spr_20D942_2-Spr_20D942
.Spr_20D942_0:dc.b 1                    ; DATA XREF: ROM:Spr_20D942↑o
        dc.b $F8, $D, 0, $45, $F2
.Spr_20D942_1:dc.b 1                    ; DATA XREF: ROM:0020D944↑o
        dc.b $F8, 9, 0, $4D, $FA
.Spr_20D942_2:dc.b 1                    ; DATA XREF: ROM:0020D946↑o
        dc.b $F8, 5, 0, $53, 2        

Spr_20D8AE:dc.w .Spr_20D8AE_0-*         ; DATA XREF: ObjBossBody_0_Routine0+22↑o
.Spr_20D8AE_0:dc.b 8                    ; DATA XREF: ROM:Spr_20D8AE↑o
        dc.b 8, $A, $20, $69, 0
        dc.b $E0, 8, 0, 0, $F4
        dc.b $E0, $A, 0, 3, $C
        dc.b $F8, $F, 0, $C, $DC
        dc.b $F8, $E, 0, $1C, $FC
        dc.b $F8, 1, 0, $28, $1C
        dc.b $18, 8, 0, $2A, $E4
        dc.b $10, 9, 0, $2D, $FC
        dc.b   0        

Spr_20D902:dc.w .Spr_20D902_0-*         ; DATA XREF: ObjBossElbow_0_Routine0+1C↑o
.Spr_20D902_0:dc.b 2                    ; DATA XREF: ROM:Spr_20D902↑o
        dc.b $F4, $E, 0, $33, $E8
        dc.b $F4, 1, 0, $3F, 8
        dc.b   0    

Spr_20D910:dc.w .Spr_20D910_0-*         ; DATA XREF: ObjBossUpperArm_0_Routine0+1C↑o
.Spr_20D910_0:dc.b 1                    ; DATA XREF: ROM:Spr_20D910↑o
        dc.b $F8, 5, 0, $41, $F8            

Spr_20D95A:dc.w .Spr_20D95A_0-*         ; DATA XREF: ObjBossBumper_0_Routine0+1C↑o
.Spr_20D95A_0:dc.b 1                    ; DATA XREF: ROM:Spr_20D95A↑o
        dc.b $F0, $B, 0, $5D, $EC        

Spr_20D8DA:dc.w .Spr_20D8DA_0-*         ; DATA XREF: ObjBossThigh_0_Routine0+1C↑o
.Spr_20D8DA_0:dc.b 1                    ; DATA XREF: ROM:Spr_20D8DA↑o
        dc.b $F8, 5, 0, $72, $F8        

Spr_20D8E2:dc.w .Spr_20D8E2_0-*         ; DATA XREF: ObjBossCalf_0_Routine0+22↑o
.Spr_20D8E2_0:dc.b 2                    ; DATA XREF: ROM:Spr_20D8E2↑o
        dc.b $EC, $B, 0, $76, $F4
        dc.b $C, 4, 0, $82, $F4
        dc.b   0        

Spr_20D8F0:dc.w .Spr_20D8F0_0-*         ; DATA XREF: ObjBossFoot_0_Routine0+1C↑o
.Spr_20D8F0_0:dc.b 3                    ; DATA XREF: ROM:Spr_20D8F0↑o
        dc.b $F4, $F, 0, $84, $E0
        dc.b $EC, $B, 0, $94, 0
        dc.b $C, $C, 0, $A0, 0     