10 CAT
20 INPUT "Which program to test? ", testprogram$
30 PRINT "Loading "; testprogram$
35 ON ERROR GOTO 1500
40 CHAIN MERGE testprogram$, 100, DELETE 2000-
100 PRINT "Loading test adaptor"
110 LET testprogram$ = testprogram$ + "-ta"
120 CHAIN MERGE testprogram$, 200
200 PRINT "Test harness loaded"
210 PRINT "-------------------" 
1000 RESTORE 1000
1005 DEF FNtext(t$) = (t$ = "TEXT")
1010 READ name$, inputtype$, outputtype$
1020 READ inputarity: LET inputarity = inputarity - 1
1030 READ outputarity: LET outputarity = outputarity - 1
1040 IF FNtext(inputtype$) THEN DIM arg$(inputarity) ELSE DIM arg(inputarity)
1050 IF FNtext(outputtype$) THEN DIM expected$(outputarity ) ELSE DIM expected(outputarity)
1060 IF FNtext(outputtype$) THEN DIM testresult$(outputarity) ELSE DIM testresult(outputarity)
1080 FOR i = 0 TO inputarity
1090 IF FNtext(inputtype$) THEN READ arg$(i) ELSE READ arg(i)
1100 NEXT i
1110 FOR i = 0 TO outputarity
1120 IF FNtext(outputtype$) THEN READ expected$(i) ELSE READ expected(i)
1130 NEXT i
1200 GOSUB 2000
1210 PRINT name$; "("; 
1220 FOR i = 0 TO inputarity-1: IF FNtext(inputtype$) THEN PRINT arg$(i) ELSE PRINT arg(i); ",": NEXT i: IF FNtext(inputtype$) THEN PRINT arg$(inputarity) ELSE PRINT arg(inputarity); ")";
1260 LET ok = 1
1265 DEF FNneq(e$, t$, e, t) = (FNtext(outputtype$) AND (e$ <> t$)) OR ((NOT FNtext(outputtype$)) AND (e <> t))
1270 FOR i = 0 TO outputarity
1280 IF FNneq(expected$(i), testresult$(i), expected(i), testresult(i)) THEN LET ok = 0
1290 NEXT i
1300 ON ok GOTO 1400
1305 REM Test failed
1350 PRINT " FAILED"
1355 PRINT "  expected (";
1360 FOR i = 0 TO outputarity-1: IF FNtext(outputtype$) THEN PRINT expected$(i); ELSE PRINT expected(i);: PRINT ",";: NEXT i: IF FNtext(outputtype$) THEN PRINT expected$(outputarity); ELSE PRINT expected(outputarity);
1365 PRINT ")" 
1370 PRINT "  actual   (";
1375 FOR i = 0 TO outputarity-1: IF FNtext(outputtype$) THEN PRINT testresult$(i); ELSE PRINT testresult(i);: PRINT ",";: NEXT i: IF FNtext(outputtype$) THEN PRINT testresult$(outputarity); ELSE PRINT testresult(outputarity);
1380 PRINT ")" 
1390 END
1400 REM Test passed
1410 PRINT " PASSED"
1499 END
1500 REM It's all gone Pete Tong
1510 PRINT "Test "; testprogram$; " not found."
1520 END
2000 REM expect to find the test adaptor here
2010 REM test adaptor should include the test data
2020 REM and adapt the testdata/testdata$ input array 
2030 REM and place the out into testresult/testresult$ output array
2050 LET arg0 = arg(0)
2060 LET testresult(0) = arg0
2070 LET testresult(1) = arg0*2
2080 LET testresult(2) = arg0*3
2090 RETURN
2100 DATA "Sample", "INT", "INT", 1, 3
2101 DATA 5, 5, 11, 15