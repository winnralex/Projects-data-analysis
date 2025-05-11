SET DATE ITALIAN      
USE STUD              

INDEX ON MONTH(dr) + stip TO month_stip_order

GO TOP                

DO WHILE !EOF()       
    ? "FIO:", fio
    ? "Gender:", IIF(gender, "Man", "Woman")
    ? "Birthday:", DTOC(dr)
    ? "Money:", stip
    ? "-------------------------"
    SKIP
ENDDO

CLOSE DATABASES       
