woman := Array(25)

set date Italian

use STUD

DO WHILE !EOF()
	woman := IIF(gender, "Man", "Woman")
	
	if woman == "Woman" 
		? "FIO:", fio
		? "Gender:", IIF(gender, "Man", "Woman")
    		? "Birthday:", dr
    		? "Money:", stip
    		? "-------------------------"
	ENDIF
	skip
ENDDO

CLOSE
		