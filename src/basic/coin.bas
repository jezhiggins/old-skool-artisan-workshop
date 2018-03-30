9000 REM coins kata
9010 REM let target = <number>
9020 REM gosub 9000
9030 REM result is now in coins()

9050 IF coininit = 1 THEN GOTO 9100
9060 LET coininit = 1
9070 DIM coin(6)
9072 DIM coinvalue(6)
9075 coinvalue(0) = 50
9077 coinvalue(1) = 20
9079 coinvalue(2) = 10
9081 coinvalue(3) = 5
9083 coinvalue(4) = 2
9085 coinvalue(5) = 1

9100 LET amount = target

9110 FOR c = 0 TO 5
9115 coin(c) = 0

9120 IF amount < coinvalue(c) THEN GOTO 9200
9130 LET amount = amount - coinvalue(c)
9140 LET coin(c) = coin(c) + 1
9150 GOTO 9120

9200 NEXT c

9210 RETURN 