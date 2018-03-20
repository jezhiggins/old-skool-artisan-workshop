10 FOR target = 1 TO 50 STEP 3
20 GOSUB 9000
30 PRINT target " = " roman$
40 NEXT target
100 END
9000 REM roman numerals subroutine
9010 REM let target = <number>
9020 REM gosub 9000
9030 REM result is now in roman$
9040 IF target <= 0 OR target > 255 THEN LET roman$ = "ERR": RETURN 
9050 IF matchcount = 0 THEN GOSUB 9500
9060 LET roman$ = ""
9070 FOR i = 1 TO target
9080 LET roman$ = roman$ + "I"
9090 NEXT i
9100 LET romanlen = target
9110 FOR activematch = 1 TO matchcount
9120 LET slice = 1 
9130 IF MID$(roman$, slice, matchlen(activematch)) <> match$(activematch) THEN GOTO 9180
9140 LET original$ = roman$
9150 LET roman$ = MID$(original$, 1, slice-1) + replace$(activematch) + MID$(original$, slice+matchlen(activematch))
9160 LET romanlen = romanlen-matchlen(activematch)+replacelen(activematch)
9170 GOTO 9130
9180 LET slice = slice + 1
9190 IF slice <= romanlen-matchlen(activematch)+1 THEN GOTO 9130
9200 NEXT activematch 
9210 RETURN
9500 RESTORE 9500
9510 READ matchcount
9520 DIM matchlen(matchcount)
9530 DIM match$(matchcount)
9540 DIM replace$(matchcount)
9550 DIM replacelen(matchcount)
9560 FOR i = 1 TO matchcount
9570 READ matchlen(i)
9580 READ match$(i)
9590 READ replacelen(i)
9600 READ replace$(i)
9610 NEXT i
9620 RETURN 
9630 DATA 4
9640 DATA 5, "IIIII", 1, "V"
9650 DATA 4, "IIII", 2, "IV"
9660 DATA 2, "VV", 1, "X"
9670 DATA 3, "VIV", 2, "IX"