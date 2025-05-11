set date Italian

use STUD 

DO WHILE !EOF() 
    ? "FIO:", fio
    ? "Gender:", IIF(gender, "Man", "Woman")
    ? "Birthday:", DTOC(dr)
    ? "Money:", stip
    ? "-------------------------"
    SKIP 
ENDDO

CLOSE 