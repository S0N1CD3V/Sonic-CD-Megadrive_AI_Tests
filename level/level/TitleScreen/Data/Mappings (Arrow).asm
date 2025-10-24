; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

SME__8trp:	
		dc.w SME__8trp_E-SME__8trp, SME__8trp_F-SME__8trp	
		dc.w SME__8trp_15-SME__8trp, SME__8trp_1B-SME__8trp	
		dc.w SME__8trp_21-SME__8trp, SME__8trp_27-SME__8trp	
		dc.w SME__8trp_2D-SME__8trp	
SME__8trp_E:	dc.b 0	
SME__8trp_F:	dc.b 1	
		dc.b 0, 5, $20, 0, 0	
SME__8trp_15:	dc.b 1	
		dc.b 0, 5, $20, 0, $FE	
SME__8trp_1B:	dc.b 1	
		dc.b 0, 5, $20, 0, $FC	
SME__8trp_21:	dc.b 1	
		dc.b 0, 5, $28, 0, 0	
SME__8trp_27:	dc.b 1	
		dc.b 0, 5, $28, 0, 2	
SME__8trp_2D:	dc.b 1	
		dc.b 0, 5, $28, 0, 4	
		even