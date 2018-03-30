10 REM
20 REM Old Skool Test Harness
30 REM ----------------------
40 REM 
50 REM Load the program under test
60 REM 
70 CAT
80 INPUT "Which program to test? ", testprogram$
90 PRINT "Loading "; testprogram$
100 ON ERROR GOTO 500
110 CHAIN MERGE testprogram$, 150, DELETE 2000-
150 PRINT "Loading "; testprogram$ + "-ta"; " test adaptor"
160 LET testprogram$ = testprogram$ + "-ta"
170 CHAIN MERGE testprogram$, 200
200 PRINT "Test harness loaded"
210 PRINT "-------------------" 
220 GOTO 1000
500 REM 
510 REM couldn't load the program
520 REM
530 PRINT "Test "; testprogram$; " not found."
540 END


1000 REM 
1002 REM Run the tests
1006 REM 
1020 DEF FNtext(t$) = (t$ = "TEXT")

1030 REM 
1032 REM work out how many test cases there are 
1034 REM 
1040 GOSUB 1900

1050 REM
1052 REM read the name, input and output types, 
1054 REM and number of arguments
1056 REM
1070 RESTORE 2000
1080 READ testname$, inputtype$, outputtype$
1090 READ inputarity: LET inputarity = inputarity - 1
1100 READ outputarity: LET outputarity = outputarity - 1
1110 IF FNtext(inputtype$) THEN DIM arg$(inputarity) ELSE DIM arg(inputarity)
1120 IF FNtext(outputtype$) THEN DIM expected$(outputarity ) ELSE DIM expected(outputarity)
1130 IF FNtext(outputtype$) THEN DIM testresult$(outputarity) ELSE DIM testresult(outputarity)

1150 CLS
1160 LET testpasses = 0
1170 FOR testcase = 1 TO testcount

1200 REM 
1202 REM read test case input and expected outputs 
1204 REM
1210 GOSUB 1850

1300 REM 
1302 REM run the test
1304 REM
1310 GOSUB 2000

1400 REM
1402 REM check the result
1404 REM
1410 GOSUB 1800
1420 ON testexpectation GOSUB 1700, 1750
1430 NEXT testcase

1500 REM
1502 REM all done, print summary
1504 REM
1510 PRINT 
1520 PRINT "Ran "; testcount; " tests"
1530 PRINT "  "; testpasses; " passed"
1540 IF testpasses <> testcount THEN PRINT "  "; testcount-testpasses; " failed :("
1550 PRINT
1560 END

1700 REM Test passed
1705 PRINT " PASSED"
1710 LET testpasses = testpasses + 1
1715 RETURN

1750 REM Test failed
1755 PRINT " FAILED"
1760 PRINT "   expected (";
1765 FOR i = 0 TO outputarity-1: IF FNtext(outputtype$) THEN PRINT expected$(i); ELSE PRINT expected(i);: PRINT ",";: NEXT i: IF FNtext(outputtype$) THEN PRINT expected$(outputarity); ELSE PRINT expected(outputarity);
1770 PRINT ")" 
1775 PRINT "   actual   (";
1780 FOR i = 0 TO outputarity-1: IF FNtext(outputtype$) THEN PRINT testresult$(i); ELSE PRINT testresult(i);: PRINT ",";: NEXT i: IF FNtext(outputtype$) THEN PRINT testresult$(outputarity); ELSE PRINT testresult(outputarity);
1785 PRINT ")" 
1790 RETURN

1800 REM check the result
1805 PRINT testcase; testname$; "("; 
1810 FOR i = 0 TO inputarity-1: IF FNtext(inputtype$) THEN PRINT arg$(i) ELSE PRINT arg(i); ",": NEXT i: IF FNtext(inputtype$) THEN PRINT arg$(inputarity) ELSE PRINT arg(inputarity); ")";
1815 LET testexpectation = 1
1820 DEF FNneq(e$, t$, e, t) = (FNtext(outputtype$) AND (e$ <> t$)) OR ((NOT FNtext(outputtype$)) AND (e <> t))
1825 FOR i = 0 TO outputarity
1830 IF FNneq(expected$(i), testresult$(i), expected(i), testresult(i)) THEN LET testexpectation = 2
1835 NEXT i
1840 RETURN 

1850 REM read test case input and expected outputs 
1855 FOR i = 0 TO inputarity
1860 IF FNtext(inputtype$) THEN READ arg$(i) ELSE READ arg(i)
1865 NEXT i
1870 FOR i = 0 TO outputarity
1875 IF FNtext(outputtype$) THEN READ expected$(i) ELSE READ expected(i)
1880 NEXT i
1885 RETURN


1900 REM how many test cases are there
1905 RESTORE 2000
1905 READ testname$, inputtype$, outputtype$
1910 READ inputarity: LET inputarity = inputarity - 1
1915 READ outputarity: LET outputarity = outputarity - 1
1920 LET testcount = 0
1925 ON ERROR GOTO 1990
1930 IF FNtext(inputtype$) THEN READ dummy$ ELSE READ dummy
1935 REM line, looks good so let's proceed
1940 ON ERROR GOTO 0
1950 FOR i = 1 TO inputarity: IF FNtext(inputtype$) THEN READ dummy$ ELSE READ dummy: NEXT i
1960 FOR i = 0 TO outputarity: IF FNtext(outputtype$) THEN READ dummy$ ELSE READ dummy: NEXT i
1970 LET testcount = testcount + 1
1980 GOTO 1925
1990 RETURN 

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
2101 DATA 1, 1, 2, 3
2102 DATA 2, 2, 4, 6
2103 DATA 3, 3, 5, 9
2104 DATA 4, 4, 8, 12
2105 DATA 5, 5, 10, 15
