; =============== S U B R O U T I N E =======================================


ObjMetalSonic:                          ; DATA XREF: ROM:00203E70↑o
        moveq   #0,d0
        move.b  obj.oRoutine(a0),d0
        move.w  off_20DE80(pc,d0.w),d0
        jsr     off_20DE80(pc,d0.w)
        bsr.w   sub_20E300
        cmpi.w  #$4C0,obj.oX(a1)
        bcc.w   loc_20E04A
        jmp     DrawObject
; End of function ObjMetalSonic

; ---------------------------------------------------------------------------
off_20DE80:dc.w ObjMetalSonic_0_Routine0-*
                                        ; CODE XREF: ObjMetalSonic+A↑p
                                        ; DATA XREF: ...
        dc.w ObjMetalSonic_0_Routine2-off_20DE80
        dc.w ObjMetalSonic_0_Routine4-off_20DE80
        dc.w ObjMetalSonic_0_Routine6-off_20DE80
        dc.w ObjMetalSonic_0_Routine8-off_20DE80
        dc.w ObjMetalSonic_0_RoutineA-off_20DE80

; =============== S U B R O U T I N E =======================================


ObjMetalSonic_0_Routine0:               ; DATA XREF: ROM:off_20DE80↑o
        addq.b  #2,obj.oRoutine(a0)
        ori.b   #4,obj.oSprFlags(a0)
        move.w  #$3D0,obj.oTile(a0)
        move.b  #2,obj.oPriority(a0)
        move.l  #Spr_23BC54,obj.oSprites(a0)
        move.b  #$E,obj.oSprFrame(a0)
        move.b  #$20,obj.oYRadius(a0) ; ' '
        move.b  #$3C,obj.oVar3A(a0) ; '<'
        move.b  #0,obj.oColType(a0)

ObjMetalSonic_0_Routine2:               ; DATA XREF: ROM:0020DE82↑o
        tst.b   obj.oVar3A(a0)
        beq.s   loc_20DECE
        subq.b  #1,obj.oVar3A(a0)
        bne.s   locret_20DEEE

loc_20DECE:                             ; CODE XREF: ObjMetalSonic_0_Routine0+3A↑j
        bsr.w   sub_20E254
        move.w  #$FFF0,obj.oVar3E(a0)
        addq.b  #2,obj.oRoutine(a0)
        btst    #7,obj.oSprFlags(a0)
        beq.s   locret_20DEEE
        rts
;        move.w  #$CA,d0
;        jsr     PlayFMSound

locret_20DEEE:                          ; CODE XREF: ObjMetalSonic_0_Routine0+40↑j ...
        rts
; End of function ObjMetalSonic_0_Routine0


; =============== S U B R O U T I N E =======================================


ObjMetalSonic_0_Routine4:               ; DATA XREF: ROM:0020DE84↑o
        bsr.w   sub_20E08C
        move.w  obj.oVar3E(a0),d0
        add.w   obj.oXVel(a0),d0
        cmpi.w  #$FD00,d0
        bgt.s   loc_20DF06
        move.w  #$FD00,d0

loc_20DF06:                             ; CODE XREF: ObjMetalSonic_0_Routine4+10↑j
        move.w  d0,obj.oXVel(a0)
        move.w  #$3E0,d0
        move.w  obj.oVar34(a0),d1
        beq.s   loc_20DF1E
        movea.w d1,a2
        move.w  8(a2),d0
        addi.w  #$20,d0 ; ' '

loc_20DF1E:                             ; CODE XREF: ObjMetalSonic_0_Routine4+22↑j
        cmp.w   obj.oX(a0),d0
        bcs.s   loc_20DF48
        clr.w   obj.oXVel(a0)
        clr.w   obj.oVar3E(a0)
        st      obj.oVar3D(a0)
        move.b  #2,obj.oAnim(a0)
        bsr.w   sub_20E00C
        clr.b   obj.oColType(a0)
        move.w  obj.oY(a0),obj.oVar32(a0)
        addq.b  #2,obj.oRoutine(a0)

loc_20DF48:                             ; CODE XREF: ObjMetalSonic_0_Routine4+32↑j
        lea     unk_20E062(pc),a1
        bra.w   sub_20E262
; End of function ObjMetalSonic_0_Routine4


; =============== S U B R O U T I N E =======================================


ObjMetalSonic_0_Routine6:               ; DATA XREF: ROM:0020DE86↑o
        bsr.w   sub_20E300
        bsr.w   sub_20E236
        bsr.w   sub_20DF86
        addq.b  #4,obj.oVar3A(a0)
        bcc.s   loc_20DF7E
        addq.b  #2,obj.oRoutine(a0)
        move.w  #$FD40,obj.oYVel(a0)
        move.w  #$B,obj.oVar3E(a0)
        move.b  #$40,obj.oVar3B(a0) ; '@'
        move.b  #$50,obj.oVar30(a0) ; 'P'

loc_20DF7E:                             ; CODE XREF: ObjMetalSonic_0_Routine6+10↑j
        lea     unk_20E062(pc),a1
        bra.w   sub_20E262
; End of function ObjMetalSonic_0_Routine6


; =============== S U B R O U T I N E =======================================


sub_20DF86:                             ; CODE XREF: ObjMetalSonic_0_Routine6+8↑p ...
        moveq   #0,d0
        move.b  obj.oVar3A(a0),d0
        jsr     CalcSine
        add.w   d0,d0
        add.w   d0,d0
        ext.l   d0
        asl.l   #8,d0
        add.l   obj.oVar32(a0),d0
        move.l  d0,obj.oY(a0)
        rts
; End of function sub_20DF86


; =============== S U B R O U T I N E =======================================


ObjMetalSonic_0_Routine8:               ; DATA XREF: ROM:0020DE88↑o
        lea     (objPlayerSlot).w,a1
        bsr.w   sub_20E236
        tst.b   obj.oVar3B(a0)
        beq.s   loc_20DFD2
        bsr.w   sub_20E07C
        move.w  obj.oVar3E(a0),d0
        add.w   d0,obj.oYVel(a0)
        subq.b  #1,obj.oVar3B(a0)
        bne.s   loc_20E004
        clr.w   obj.oVar3E(a0)
        clr.w   obj.oYVel(a0)
        move.w  obj.oY(a0),obj.oVar32(a0)

loc_20DFD2:                             ; CODE XREF: ObjMetalSonic_0_Routine8+C↑j
        bsr.w   sub_20DF86
        addq.b  #4,obj.oVar3A(a0)
        move.w  obj.oX(a0),d0
        sub.w   obj.oX(a1),d0
        bcs.s   loc_20DFEA
        cmpi.b  #$A0,d0
        bcc.s   loc_20E004

loc_20DFEA:                             ; CODE XREF: ObjMetalSonic_0_Routine8+3E↑j
        subq.b  #1,obj.oVar30(a0)
        bne.s   loc_20E004
        bsr.w   sub_20E246
        move.w  #0,obj.oXVel(a0)
        move.w  #$60,obj.oVar3E(a0) ; '`'
        addq.b  #2,obj.oRoutine(a0)

loc_20E004:                             ; CODE XREF: ObjMetalSonic_0_Routine8+1E↑j ...
        lea     unk_20E062(pc),a1
        bra.w   sub_20E262
; End of function ObjMetalSonic_0_Routine8


; =============== S U B R O U T I N E =======================================


sub_20E00C:                             ; CODE XREF: ObjMetalSonic_0_Routine4+46↑p
        jsr     FindObjSlot
        bne.s   locret_20E01E
;        move.b  #$34,obj(a1) ; '4'
        move.w  a0,obj.oVar34(a1)

locret_20E01E:                          ; CODE XREF: sub_20E00C+6↑j
        rts
; End of function sub_20E00C


; =============== S U B R O U T I N E =======================================


ObjMetalSonic_0_RoutineA:               ; DATA XREF: ROM:0020DE8A↑o
        bsr.w   sub_20E08C
        move.w  obj.oVar3E(a0),d0
        add.w   obj.oXVel(a0),d0
        cmpi.w  #$400,d0
        bcs.s   loc_20E036
        move.w  #$400,d0

loc_20E036:                             ; CODE XREF: ObjMetalSonic_0_RoutineA+10↑j
        move.w  d0,obj.oXVel(a0)
        cmpi.w  #$528,obj.oX(a0)
        bcc.s   loc_20E04A
        lea     unk_20E062(pc),a1
        bra.w   sub_20E262
; ---------------------------------------------------------------------------

loc_20E04A:                             ; CODE XREF: ObjMetalSonic+18↑j ...
        move.b  #$FF,(amyCaptured).l
        lea     (Pal_Stage).l,a3
        bsr.w   sub_20E2C8
        jmp     DeleteObject
; End of function ObjMetalSonic_0_RoutineA

; ---------------------------------------------------------------------------
unk_20E062:dc.b   0                     ; DATA XREF: ObjMetalSonic_0_Routine4:loc_20DF48↑o ...
        dc.b   6
        dc.b   0
        dc.b  $C
        dc.b   0
        dc.b $16
        dc.b   0
        dc.b   0
        dc.b   1
        dc.b   0
        dc.b $FF
        dc.b   0
        dc.b   6
        dc.b   1
        dc.b   7
        dc.b   1
        dc.b   8
        dc.b   1
        dc.b   9
        dc.b   1
        dc.b $FF
        dc.b   0
        dc.b  $F
        dc.b   1
        dc.b $FF
        dc.b   0

; =============== S U B R O U T I N E =======================================


sub_20E07C:                             ; CODE XREF: ObjMetalSonic_0_Routine8+E↑p ...
        bsr.s   sub_20E08C
        move.w  obj.oYVel(a0),d0
        ext.l   d0
        asl.l   #8,d0
        add.l   d0,obj.oY(a0)
        rts
; End of function sub_20E07C


; =============== S U B R O U T I N E =======================================


sub_20E08C:                             ; CODE XREF: ObjMetalSonic_0_Routine4↑p ...
        move.w  obj.oXVel(a0),d0
        ext.l   d0
        asl.l   #8,d0
        add.l   d0,obj.oX(a0)
        rts
; End of function sub_20E08C
; =============== S U B R O U T I N E =======================================


ObjAmyRose:                             ; DATA XREF: ROM:00203E74↑o
        tst.b   (timeAttackMode).l
        bne.w   loc_20E04A
        tst.b   (amyCaptured).l
        bne.w   loc_20E04A
        moveq   #0,d0
        move.b  obj.oRoutine(a0),d0
        move.w  off_20E0D0(pc,d0.w),d0
        jsr     off_20E0D0(pc,d0.w)
        bsr.w   sub_20E300
        cmpi.w  #$4C0,obj.oX(a1)
        bcc.w   loc_20E04A
        jmp     DrawObject
; End of function ObjAmyRose

; ---------------------------------------------------------------------------
off_20E0D0:dc.w ObjAmyRose_0_Routine0-* ; CODE XREF: ObjAmyRose+1E↑p
                                        ; DATA XREF: ...
        dc.w ObjAmyRose_0_Routine2-off_20E0D0
        dc.w ObjAmyRose_0_Routine4-off_20E0D0

; =============== S U B R O U T I N E =======================================


ObjAmyRose_0_Routine0:                  ; DATA XREF: ROM:off_20E0D0↑o
        tst.b   obj.oVar3E(a0)
        bmi.s   loc_20E0E8
        moveq   #$B,d0
        jsr     AddPLCs
        st      obj.oVar3E(a0)

loc_20E0E8:                             ; CODE XREF: ObjAmyRose_0_Routine0+4↑j
        ori.b   #4,obj.oSprFlags(a0)
        move.w  #$235E,obj.oTile(a0)
        move.b  #1,obj.oPriority(a0)
        move.l  #Spr_23BDB2,obj.oSprites(a0)
        bsr.w   sub_20E2C4
        bsr.w   sub_20E300
        bsr.w   sub_20E236
        move.w  8(a1),d0
        cmp.w   obj.oX(a0),d0
        bcs.s   loc_20E11C
        addq.b  #2,obj.oRoutine(a0)

loc_20E11C:                             ; CODE XREF: ObjAmyRose_0_Routine0+40↑j
        lea     (Padding3).l,a1
        bra.w   sub_20E262
; End of function ObjAmyRose_0_Routine0

; ---------------------------------------------------------------------------
        rts

; =============== S U B R O U T I N E =======================================


ObjAmyRose_0_Routine2:                  ; DATA XREF: ROM:0020E0D2↑o

; FUNCTION CHUNK AT 0020E306 SIZE 0000003A BYTES

        bsr.w   sub_20E300
        move.w  obj.oVar34(a0),d0
        beq.s   loc_20E14E
        movea.w d0,a2
        tst.b   $3D(a2)
        beq.s   loc_20E14E
        move.b  #4,obj.oRoutine(a0)
;        move.w  #$7D,d0 ; '}'
;        jsr     SubCPUCmd
        bra.w   loc_20E1E0
; ---------------------------------------------------------------------------

loc_20E14E:                             ; CODE XREF: ObjAmyRose_0_Routine2+8↑j ...
        bsr.w   sub_20E236
        btst    #0,obj.oFlags(a0)
        beq.s   loc_20E16E
        cmpi.w  #$80,obj.oX(a0)
        bcc.s   loc_20E16E
        clr.b   obj.oAnim(a0)
        clr.w   obj.oXVel(a0)
        bra.w   loc_20E1E0
; ---------------------------------------------------------------------------

loc_20E16E:                             ; CODE XREF: ObjAmyRose_0_Routine2+30↑j ...
        cmpi.w  #$3C0,obj.oX(a0)
        bcc.s   loc_20E1B4
        move.w  #$FFE0,d0
        btst    #0,obj.oFlags(a0)
        bne.s   loc_20E184
        neg.w   d0

loc_20E184:                             ; CODE XREF: ObjAmyRose_0_Routine2+58↑j
        add.w   obj.oXVel(a0),d0
        move.w  d0,d1
        move.w  #$200,d2
        tst.w   d1
        bpl.s   loc_20E196
        neg.w   d1
        neg.w   d2

loc_20E196:                             ; CODE XREF: ObjAmyRose_0_Routine2+68↑j
        cmpi.w  #$200,d1
        bcs.s   loc_20E19E
        move.w  d2,d0

loc_20E19E:                             ; CODE XREF: ObjAmyRose_0_Routine2+72↑j
        move.w  d0,obj.oXVel(a0)
        bsr.w   sub_20E08C
        move.b  #1,obj.oAnim(a0)
        cmpi.w  #$3C0,obj.oX(a0)
        bcs.s   loc_20E1E0

loc_20E1B4:                             ; CODE XREF: ObjAmyRose_0_Routine2+4C↑j
        clr.b   obj.oAnim(a0)
        tst.w   obj.oVar34(a0)
        bne.s   loc_20E1E0
        jsr     FindObjSlot
        bne.s   loc_20E1E0
;        move.b  #$31,obj(a1) ; '1'
        move.w  #$500,obj.oX(a1)
        move.w  #$3E8,obj.oY(a1)
        move.w  a0,obj.oVar34(a1)
        move.w  a1,obj.oVar34(a0)

loc_20E1E0:                             ; CODE XREF: ObjAmyRose_0_Routine2+22↑j ...
        lea     (Padding3).l,a1
        bsr.w   sub_20E262
        bra.w   loc_20E306
; End of function ObjAmyRose_0_Routine2


; =============== S U B R O U T I N E =======================================


ObjAmyRose_0_Routine4:                  ; DATA XREF: ROM:0020E0D4↑o
        movea.w obj.oVar34(a0),a1
        cmpi.b  #$31,obj(a1) ; '1'
        bne.s   loc_20E230
        moveq   #8,d0
        bsr.w   sub_20E254
        btst    #0,obj.oFlags(a1)
        beq.s   loc_20E20E
        neg.w   d0
        bsr.w   sub_20E246

loc_20E20E:                             ; CODE XREF: ObjAmyRose_0_Routine4+18↑j
        add.w   obj.oX(a1),d0
        move.w  d0,obj.oX(a0)
        move.w  obj.oY(a1),d0
        addq.w  #4,d0
        move.w  d0,obj.oY(a0)
        move.b  #2,obj.oAnim(a0)
        lea     (Padding3).l,a1
        bra.w   sub_20E262
; ---------------------------------------------------------------------------

loc_20E230:                             ; CODE XREF: ObjAmyRose_0_Routine4+A↑j
        jmp     DeleteObject
; End of function ObjAmyRose_0_Routine4


; =============== S U B R O U T I N E =======================================


sub_20E236:                             ; CODE XREF: ObjMetalSonic_0_Routine6+4↑p ...
        bsr.s   sub_20E246
        move.w  obj.oX(a0),d0
        sub.w   obj.oX(a1),d0
        bcs.s   locret_20E244
        bsr.s   sub_20E254

locret_20E244:                          ; CODE XREF: sub_20E236+A↑j
        rts
; End of function sub_20E236


; =============== S U B R O U T I N E =======================================


sub_20E246:                             ; CODE XREF: ObjMetalSonic_0_Routine8+4C↑p ...
        bclr    #0,obj.oFlags(a0)
        bclr    #0,obj.oSprFlags(a0)
        rts
; End of function sub_20E246


; =============== S U B R O U T I N E =======================================


sub_20E254:                             ; CODE XREF: ObjMetalSonic_0_Routine0:loc_20DECE↑p ...
        bset    #0,obj.oFlags(a0)
        bset    #0,obj.oSprFlags(a0)
        rts
; End of function sub_20E254


; =============== S U B R O U T I N E =======================================


sub_20E262:                             ; CODE XREF: ObjMetalSonic_0_Routine4+5C↑j ...
        moveq   #0,d0
        move.b  obj.oAnim(a0),d0
        cmp.b   obj.oPrevAnim(a0),d0
        beq.s   loc_20E27A
        move.b  d0,obj.oPrevAnim(a0)
        clr.b   obj.oAnimFrame(a0)
        clr.b   obj.oAnimTime(a0)

loc_20E27A:                             ; CODE XREF: sub_20E262+A↑j
        subq.b  #1,obj.oAnimTime(a0)
        bpl.s   locret_20E2C2
        add.w   d0,d0
        adda.w  (a1,d0.w),a1

loc_20E286:                             ; CODE XREF: sub_20E262+34↓j
        move.b  obj.oAnimFrame(a0),d0
        lea     (a1,d0.w),a2
        move.b  (a2),d0
        bpl.s   loc_20E298
        clr.b   obj.oAnimFrame(a0)
        bra.s   loc_20E286
; ---------------------------------------------------------------------------

loc_20E298:                             ; CODE XREF: sub_20E262+2E↑j
        move.b  d0,d1
        andi.b  #$1F,d0
        move.b  d0,obj.oSprFrame(a0)
        move.b  obj.oFlags(a0),d0
        rol.b   #3,d1
        eor.b   d0,d1
        andi.b  #3,d1
        andi.b  #$FC,obj.oSprFlags(a0)
        or.b    d1,obj.oSprFlags(a0)
        move.b  1(a2),obj.oAnimTime(a0)
        addq.b  #2,obj.oAnimFrame(a0)

locret_20E2C2:                          ; CODE XREF: sub_20E262+1C↑j
        rts
; End of function sub_20E262


; =============== S U B R O U T I N E =======================================


sub_20E2C4:                             ; CODE XREF: ObjAmyRose_0_Routine0+2C↑p
        lea     unk_20E2E0(pc),a3
; End of function sub_20E2C4


; =============== S U B R O U T I N E =======================================


sub_20E2C8:                             ; CODE XREF: ObjMetalSonic_0_RoutineA+38↑p
        lea     ($FFFFFB20).w,a4
        movem.l (a3)+,d0-d3
        movem.l d0-d3,(a4)
        movem.l (a3)+,d0-d3
        movem.l d0-d3,$10(a4)
        rts
; End of function sub_20E2C8

; ---------------------------------------------------------------------------
unk_20E2E0:dc.b   0                     ; DATA XREF: sub_20E2C4↑o
        dc.b   0
        dc.b   0
        dc.b   0
        dc.b   6
        dc.b $28 ; (
        dc.b   8
        dc.b $4A ; J
        dc.b  $E
        dc.b $6E ; n
        dc.b  $E
        dc.b $AE
        dc.b  $E
        dc.b $EE
        dc.b  $A
        dc.b $AA
        dc.b   8
        dc.b $88
        dc.b   4
        dc.b $44 ; D
        dc.b   8
        dc.b $AE
        dc.b   0
        dc.b $6C ; l
        dc.b   0
        dc.b $C2
        dc.b   0
        dc.b $80
        dc.b   8
        dc.b   6
        dc.b   0
        dc.b  $E

; =============== S U B R O U T I N E =======================================


sub_20E300:                             ; CODE XREF: ObjMetalSonic+E↑p ...
        lea     (objPlayerSlot).w,a1
        rts
; End of function sub_20E300

; ---------------------------------------------------------------------------
; START OF FUNCTION CHUNK FOR ObjAmyRose_0_Routine2

loc_20E306:                             ; CODE XREF: ObjAmyRose_0_Routine2+C2↑j
        addq.b  #8,obj.oVar3B(a0)
        bcc.s   locret_20E33E
        jsr     FindObjSlot
        bne.s   locret_20E33E
;        move.b  #$33,obj(a1) ; '3'
        moveq   #$C,d1
        btst    #0,obj.oFlags(a0)
        beq.s   loc_20E328
        move.w  #$FFF2,d1

loc_20E328:                             ; CODE XREF: ObjAmyRose_0_Routine2+1FA↑j
        move.w  obj.oX(a0),d0
        add.w   d1,d0
        move.w  d0,obj.oX(a1)
        move.w  obj.oY(a0),d0
        subi.w  #$C,d0
        move.w  d0,obj.oY(a1)

locret_20E33E:                          ; CODE XREF: ObjAmyRose_0_Routine2+1E2↑j ...
        rts
; END OF FUNCTION CHUNK FOR ObjAmyRose_0_Routine2

; =============== S U B R O U T I N E =======================================
SubCPUCmd: 
playfmsound:
       rts
Spr_23BDB2:dc.w @Spr_23BDB2_0-*         ; DATA XREF: ObjAmyRose_0_Routine0+24↑o ...
        dc.w @Spr_23BDB2_1-Spr_23BDB2
        dc.w @Spr_23BDB2_2-Spr_23BDB2
        dc.w @Spr_23BDB2_3-Spr_23BDB2
        dc.w @Spr_23BDB2_4-Spr_23BDB2
        dc.w @Spr_23BDB2_5-Spr_23BDB2
        dc.w @Spr_23BDB2_6-Spr_23BDB2
        dc.w @Spr_23BDB2_7-Spr_23BDB2
        dc.w @Spr_23BDB2_8-Spr_23BDB2
        dc.w @Spr_23BDB2_8-Spr_23BDB2
        dc.w @Spr_23BDB2_A-Spr_23BDB2
        dc.w @Spr_23BDB2_B-Spr_23BDB2
        dc.w @Spr_23BDB2_C-Spr_23BDB2
        dc.w @Spr_23BDB2_8-Spr_23BDB2
@Spr_23BDB2_0:dc.b 4                    ; DATA XREF: ROM:Spr_23BDB2↑o
        dc.b $EC, $D, 0, $28, $F0
        dc.b $FC, $C, 0, $30, $F0
        dc.b 4, 8, 0, $34, $F0
        dc.b $C, $C, 0, $37, $F0
        dc.b   0
@Spr_23BDB2_1:dc.b 2                    ; DATA XREF: ROM:0023BDB4↑o
        dc.b $EC, 9, 0, 0, $F4
        dc.b $FC, $A, 0, $1F, $F4
        dc.b   0
@Spr_23BDB2_2:dc.b 2                    ; DATA XREF: ROM:0023BDB6↑o
        dc.b $EC, $D, 0, $28, $F0
        dc.b $FC, $E, 0, $3B, $F0
        dc.b   0
@Spr_23BDB2_3:dc.b 4                    ; DATA XREF: ROM:0023BDB8↑o
        dc.b $EC, 9, 0, 0, $F4
        dc.b $FC, 8, 0, 6, $F4
        dc.b 4, 4, 0, 9, $FC
        dc.b $C, 8, 0, $B, $F4
        dc.b   0
@Spr_23BDB2_4:dc.b 4                    ; DATA XREF: ROM:0023BDBA↑o
        dc.b $EC, 9, 0, 0, $F4
        dc.b $FC, 8, 0, $E, $F4
        dc.b 4, 4, 0, $11, $FC
        dc.b $C, 8, 0, $13, $F4
        dc.b   0
@Spr_23BDB2_5:dc.b 2                    ; DATA XREF: ROM:0023BDBC↑o
        dc.b $EC, 9, 0, 0, $F4
        dc.b $FC, $A, 0, $16, $F4
        dc.b   0
@Spr_23BDB2_6:dc.b 2                    ; DATA XREF: ROM:0023BDBE↑o
        dc.b $EC, 9, 0, $47, $F4
        dc.b $FC, $A, 0, $4D, $F4
        dc.b   0
@Spr_23BDB2_7:dc.b 2                    ; DATA XREF: ROM:0023BDC0↑o
        dc.b $EC, 9, 0, $56, $F4
        dc.b $FC, $A, 0, $5C, $F4
        dc.b   0
@Spr_23BDB2_8:dc.b 0                    ; DATA XREF: ROM:0023BDC2↑o ...
        dc.b   0
@Spr_23BDB2_A:dc.b 1                    ; DATA XREF: ROM:0023BDC6↑o
        dc.b $F8, 5, 0, $65, $F8
@Spr_23BDB2_B:dc.b 1                    ; DATA XREF: ROM:0023BDC8↑o
        dc.b $F8, 5, 0, $69, $F8
@Spr_23BDB2_C:dc.b 1                    ; DATA XREF: ROM:0023BDCA↑o
        dc.b $F8, 5, 0, $6D, $F8
Spr_23BC54:dc.w @Spr_23BC54_0-*         ; DATA XREF: ROM:002077B4↑o ...
        dc.w @Spr_23BC54_1-Spr_23BC54
        dc.w @Spr_23BC54_2-Spr_23BC54
        dc.w @Spr_23BC54_3-Spr_23BC54
        dc.w @Spr_23BC54_4-Spr_23BC54
        dc.w @Spr_23BC54_5-Spr_23BC54
        dc.w @Spr_23BC54_6-Spr_23BC54
        dc.w @Spr_23BC54_7-Spr_23BC54
        dc.w @Spr_23BC54_8-Spr_23BC54
        dc.w @Spr_23BC54_9-Spr_23BC54
        dc.w @Spr_23BC54_A-Spr_23BC54
        dc.w @Spr_23BC54_B-Spr_23BC54
        dc.w @Spr_23BC54_C-Spr_23BC54
        dc.w @Spr_23BC54_D-Spr_23BC54
        dc.w @Spr_23BC54_E-Spr_23BC54
        dc.w @Spr_23BC54_F-Spr_23BC54
@Spr_23BC54_0:dc.b 2                    ; DATA XREF: ROM:Spr_23BC54↑o
        dc.b $F4, $B, 0, 0, $E8
        dc.b $F4, $B, 0, $C, 0
        dc.b   0
@Spr_23BC54_1:dc.b 2                    ; DATA XREF: ROM:0023BC56↑o
        dc.b $F4, $B, 0, $18, $E8
        dc.b $F4, $B, 0, $24, 0
        dc.b   0
@Spr_23BC54_2:dc.b 6                    ; DATA XREF: ROM:0023BC58↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E8, $A, 0, $5C, $E0
        dc.b 0, $A, 0, $65, $E0
        dc.b $E8, $A, $18, $5C, 8
        dc.b 0, $A, $18, $65, 8
        dc.b   0
@Spr_23BC54_3:dc.b 6                    ; DATA XREF: ROM:0023BC5A↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E8, $A, $18, $65, 8
        dc.b 0, $A, $18, $5C, 8
        dc.b $E8, $A, 0, $65, $E0
        dc.b 0, $A, 0, $5C, $E0
        dc.b   0
@Spr_23BC54_4:dc.b 6                    ; DATA XREF: ROM:0023BC5C↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E8, $A, $10, $65, $E0
        dc.b 0, $A, $10, $5C, $E0
        dc.b $E8, $A, 8, $65, 8
        dc.b 0, $A, 8, $5C, 8
        dc.b   0
@Spr_23BC54_5:dc.b 6                    ; DATA XREF: ROM:0023BC5E↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E8, $A, 8, $5C, 8
        dc.b 0, $A, 8, $65, 8
        dc.b $E8, $A, $10, $5C, $E0
        dc.b 0, $A, $10, $65, $E0
        dc.b   0
@Spr_23BC54_6:dc.b 6                    ; DATA XREF: ROM:0023BC60↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E8, $A, 0, $5C, $E0
        dc.b 0, $A, 0, $65, $E0
        dc.b $E8, $A, $10, $5C, 8
        dc.b 0, $A, $10, $65, 8
        dc.b   0
@Spr_23BC54_7:dc.b 6                    ; DATA XREF: ROM:0023BC62↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E8, $A, $18, $65, $10
        dc.b 0, $A, $18, $5C, $10
        dc.b $E8, $A, 8, $65, $D8
        dc.b 0, $A, 8, $5C, $D8
        dc.b   0
@Spr_23BC54_8:dc.b 6                    ; DATA XREF: ROM:0023BC64↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E0, $A, $10, $65, $D8
        dc.b 8, $A, $10, $5C, $D8
        dc.b $E0, $A, 0, $65, $10
        dc.b 8, $A, 0, $5C, $10
        dc.b   0
@Spr_23BC54_9:dc.b 6                    ; DATA XREF: ROM:0023BC66↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b $E0, $A, 8, $5C, $18
        dc.b 8, $A, 8, $65, $18
        dc.b $E0, $A, $18, $5C, $D0
        dc.b 8, $A, $18, $65, $D0
        dc.b   0
@Spr_23BC54_A:dc.b 1                    ; DATA XREF: ROM:0023BC68↑o
        dc.b $F8, 5, 0, $6E, $F8
@Spr_23BC54_B:dc.b 1                    ; DATA XREF: ROM:0023BC6A↑o
        dc.b $F8, 5, 0, $72, $F8
@Spr_23BC54_C:dc.b 1                    ; DATA XREF: ROM:0023BC6C↑o
        dc.b $F4, $A, 0, $76, $F4
@Spr_23BC54_D:dc.b 1                    ; DATA XREF: ROM:0023BC6E↑o
        dc.b $F0, $F, 0, $7F, $F0
@Spr_23BC54_E:dc.b 0                    ; DATA XREF: ROM:0023BC70↑o
        dc.b   0
@Spr_23BC54_F:dc.b 2                    ; DATA XREF: ROM:0023BC72↑o
        dc.b $E8, $F, 0, $30, $EC
        dc.b 8, 9, 0, $40, $F4
        dc.b   0        