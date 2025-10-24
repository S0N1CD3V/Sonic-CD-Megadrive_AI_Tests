; ---------------------------------------------------------------------------
; Level Headers
; ---------------------------------------------------------------------------


LevelArtAddress:
	            dc.l Kos_PPZ_Past ;Past Act 1
                dc.l Kos_PPZ ;Present Act 1
                dc.l Kos_PPZ_BF ;Future Act 1
                dc.l Kos_PPZ_GF ;Good Future Act 1
                dc.l Kos_PPZ ;Past Act 2
                dc.l Kos_PPZ_2 ;Present Act 2
                dc.l Kos_PPZ ;Future Act 2
                dc.l Kos_PPZ ;Good Future Act 2
                dc.l Kos_PPZ ;Past Act 3
                dc.l Kos_PPZ ;Present Act 3
                dc.l Kos_PPZ ;Future Act 3
                dc.l Kos_PPZ ;Good Future Act 3
                dc.l Kos_PPZ ;Past Act 4
                dc.l Kos_PPZ ;Present Act 4
                dc.l Kos_PPZ ;Future Act 4
                dc.l Kos_PPZ ;Good Future Act 4
	            dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
                dc.l Kos_LZ
	            dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
                dc.l Kos_MZ
	            dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
                dc.l Kos_SLZ
	            dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
                dc.l Kos_SYZ
	            dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                dc.l Kos_SBZ
                even                                 
LevelChunkAndBlockAddress:
	            dc.l   Blk16_PPZ_Past,Blk256_PPZ_Past ;Past Act 1
                dc.l   Blk16_PPZ,Blk256_PPZ ;Present Act 1
                dc.l   Blk16_PPZ_BF,Blk256_PPZ_BF ;Future Act 1
                dc.l   Blk16_PPZ_GF,Blk256_PPZ_GF ;Good Future Act 1
                dc.l   Blk16_PPZ,Blk256_PPZ ;Past Act 2
                dc.l   Blk16_PPZ_2,Blk256_PPZ_2 ;Present Act 2
                dc.l   Blk16_PPZ,Blk256_PPZ ;Future Act 2
                dc.l   Blk16_PPZ,Blk256_PPZ ;Good Future Act 2
                dc.l   Blk16_PPZ,Blk256_PPZ ;Past Act 3
                dc.l   Blk16_PPZ,Blk256_PPZ ;Present Act 3
                dc.l   Blk16_PPZ,Blk256_PPZ ;Future Act 3
                dc.l   Blk16_PPZ,Blk256_PPZ ;Good Future Act 3
                dc.l   Blk16_PPZ,Blk256_PPZ ;Past Act 4
                dc.l   Blk16_PPZ,Blk256_PPZ ;Present Act 4
                dc.l   Blk16_PPZ,Blk256_PPZ ;Future Act 4
                dc.l   Blk16_PPZ,Blk256_PPZ ;Good Future Act 4
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_LZ,Blk256_LZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_MZ,Blk256_MZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SLZ,Blk256_SLZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SYZ,Blk256_SYZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                dc.l   Blk16_SBZ,Blk256_SBZ
                even                                                                        
Level_PalleteID: 
                dc.b  palid_R11B
                dc.b  palid_GHZ
                dc.b  palid_R11D
                dc.b  palid_R11C
                dc.b  palid_LZ
                dc.b  palid_LZ
                dc.b  palid_LZ
                dc.b  palid_LZ
                dc.b  palid_MZ
                dc.b  palid_MZ
                dc.b  palid_MZ
                dc.b  palid_MZ
                dc.b  palid_MZ
                dc.b  palid_SLZ
                dc.b  palid_SLZ
                dc.b  palid_SLZ
                dc.b  palid_SLZ
                dc.b  palid_SLZ
                dc.b  palid_SYZ
                dc.b  palid_SYZ
                dc.b  palid_SYZ
                dc.b  palid_SYZ
                dc.b  palid_SBZ1
                dc.b  palid_SBZ1
                dc.b  palid_SBZ1
                dc.b  palid_SBZ1
                even
LevelPLCID:
                dc.b plcid_GHZ
                dc.b plcid_LZ
                dc.b plcid_MZ
                dc.b plcid_SLZ
                dc.b plcid_SYZ
                dc.b plcid_SBZ
                even
LevelPLCID2:     
                dc.b plcid_GHZ2
                dc.b plcid_LZ2
                dc.b plcid_MZ2
                dc.b plcid_SLZ2
                dc.b plcid_SYZ2
                dc.b plcid_SBZ2
                even   
LevelmusicID: 
                dc.b bgm_GHZ
                dc.b bgm_LZ
                dc.b bgm_SLZ
                dc.b bgm_SYZ
                dc.b bgm_SBZ
                even
;	* music and level gfx are actually set elsewhere, so these values are useless

