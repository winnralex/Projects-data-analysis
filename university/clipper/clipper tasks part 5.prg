a := Array(25)

set date Italian 

use STUD

DO WHILE !EOF()
	a := IIF(gender, "Man", "Woman")

	IF a == "Man"
		? "FIO:", fio
		? "Gender:", IIF(gender, "Man", "Woman")
    		? "Birthday:", DTOC(dr)
    		? "Money:", stip
    		? "-------------------------"
	ENDIF
	skip
ENDDO

CLOSE