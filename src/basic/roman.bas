10 FOR target = 1 TO 160 STEP 7
20 GOSUB 9000
30 PRINT target " = " roman$
40 NEXT target
100 END
9000 REM roman numerals subroutine
9010 REM let target = <number>
9020 REM gosub 9000
9030 REM result is now in roman$
9035 DEF FNreplace$(source$, position, positionlen, target$) = MID$(source$, 1, position-1) + target$ + MID$(source$, position+positionlen)
9040 IF target <= 0 OR target > 255 THEN LET roman$ = "ERR": RETURN 
9050 IF matchcount = 0 THEN GOSUB 9500
9080 LET roman$ = STRING$(target, "I")
9100 FOR activematch = 1 TO matchcount
9110 LET matchlen = LEN (match$(activematch))
9120 LET slice = 1 
9130 IF MID$(roman$, slice, matchlen) <> match$(activematch) THEN GOTO 9180
9150 LET roman$ = FNreplace$(roman$, slice, matchlen, replace$(activematch))
9170 GOTO 9130
9180 LET slice = slice + 1
9190 IF slice <= LEN (roman$) - matchlen + 1 THEN GOTO 9130
9200 NEXT activematch 
9210 RETURN
9500 RESTORE 9500
9510 LET matchcount = 0
9520 READ a$
9530 IF a$ = "END" GOTO 9570
9540 LET matchcount = matchcount + 1
9550 READ a$
9560 GOTO 9520
9570 RESTORE 9500
9580 DIM match$(matchcount)
9590 DIM replace$(matchcount)
9600 FOR i = 1 TO matchcount
9610 READ match$(i)
9620 READ replace$(i)
9630 NEXT i
9640 RETURN
9650 DATA "IIIII", "V"
9660 DATA "IIII", "IV"
9670 DATA "VV", "X"
9680 DATA "VIV", "IX"
9690 DATA "XXXXX", "L"
9700 DATA "XXXX", "XL"
9710 DATA "LL", "C"
9720 DATA "LXL", "XC"
9800 DATA "END"