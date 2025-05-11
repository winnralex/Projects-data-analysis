list_for_fio := Array(25)
list_for_gender := Array(25)
list_for_dr := Array(25)
list_for_stip := Array(25)
list_for_group := Array(25)

list_for_fio[1] := 'Oganisian'
list_for_fio[2] := 'Korolev'
list_for_fio[3] := 'Judraliev'
list_for_fio[4] := 'Kudriashev'
list_for_fio[5] := 'Gorodyanski'
list_for_fio[6] := 'Schecvchenko'
list_for_fio[7] := 'Schecvchenko'
list_for_fio[8] := 'Karpenko'
list_for_fio[9] := 'Anukou'
list_for_fio[10] := 'Schecvchenko'
list_for_fio[11] := 'Amaryan'
list_for_fio[12] := 'Bublikov'
list_for_fio[13] := 'Schecvchenko'
list_for_fio[14] := 'Bublikov'
list_for_fio[15] := 'Schecvchenko'
list_for_fio[16] := 'Bublikov'
list_for_fio[17] := 'Schecvchenko'
list_for_fio[18] := 'Schecvchenko'
list_for_fio[19] := 'Schecvchenko'
list_for_fio[20] := 'Schecvchenko'
list_for_fio[21] := 'Bublikov'
list_for_fio[22] := 'Schecvchenko'
list_for_fio[23] := 'Bublikov'
list_for_fio[24] := 'Schecvchenko'
list_for_fio[25] := 'Schecvchenko'

list_for_gender[1] := .t.
list_for_gender[2] := .f.
list_for_gender[3] := .t.
list_for_gender[4] := .t.
list_for_gender[5] := .t.
list_for_gender[6] := .f.
list_for_gender[7] := .f.
list_for_gender[8] := .f. 
list_for_gender[9] := .t.
list_for_gender[10] := .f.
list_for_gender[11] := .f.
list_for_gender[12] := .t.
list_for_gender[13] := .f.
list_for_gender[14] := .t.
list_for_gender[15] := .f.
list_for_gender[16] := .t.
list_for_gender[17] := .f.
list_for_gender[18] := .f.
list_for_gender[19] := .f.
list_for_gender[20] := .f.
list_for_gender[21] := .t.
list_for_gender[22] := .f.
list_for_gender[23] := .t.
list_for_gender[24] := .f.
list_for_gender[25] := .f.

list_for_dr[1] := ctod('10-09-1999')
list_for_dr[2] := ctod('06-27-1984')
list_for_dr[3] := ctod('10-27-1984')
list_for_dr[4] := ctod('06-27-1984')
list_for_dr[5] := ctod('06-09-1999')
list_for_dr[6] := ctod('09-12-2007')
list_for_dr[7] := ctod('06-27-1984')
list_for_dr[8] := ctod('06-27-1984')
list_for_dr[9] := ctod('09-27-1984')
list_for_dr[10] := ctod('04-12-2007')
list_for_dr[11] := ctod('09-12-2007')
list_for_dr[12] := ctod('06-27-1984')
list_for_dr[13] := ctod('04-12-2007')
list_for_dr[14] := ctod('06-27-1984')
list_for_dr[15] := ctod('04-12-2007')
list_for_dr[16] := ctod('06-09-1999')
list_for_dr[17] := ctod('04-12-2007')
list_for_dr[18] := ctod('06-27-1984')
list_for_dr[19] := ctod('05-12-2007')
list_for_dr[20] := ctod('04-12-2007')
list_for_dr[21] := ctod('05-09-1999')
list_for_dr[22] := ctod('04-12-2007')
list_for_dr[23] := ctod('04-12-2007')
list_for_dr[24] := ctod('04-12-2007')
list_for_dr[25] := ctod('06-09-1999')

list_for_stip[1] := 123
list_for_stip[2] := 124
list_for_stip[3] := 552
list_for_stip[4] := 525
list_for_stip[5] := 2452
list_for_stip[6] := 232
list_for_stip[7] := 241
list_for_stip[8] := 2512
list_for_stip[9] := 251
list_for_stip[10] := 2152
list_for_stip[11] := 2899
list_for_stip[12] := 3421
list_for_stip[13] := 8658
list_for_stip[14] := 865
list_for_stip[15] := 8685
list_for_stip[16] := 22
list_for_stip[17] := 4634
list_for_stip[18] := 8658
list_for_stip[19] := 4216
list_for_stip[20] := 241
list_for_stip[21] := 6632
list_for_stip[22] := 222
list_for_stip[23] := 634
list_for_stip[24] := 6653
list_for_stip[25] := 1

list_for_group[1] := '101'
list_for_group[2] := '102'
list_for_group[3] := '103'
list_for_group[4] := '104'
list_for_group[5] := '101'
list_for_group[6] := '101'
list_for_group[7] := '102'
list_for_group[8] := '103'
list_for_group[9] := '104'
list_for_group[10] := '101'
list_for_group[11] := '101'
list_for_group[12] := '102'
list_for_group[13] := '103'
list_for_group[14] := '104'
list_for_group[15] := '101'
list_for_group[16] := '101'
list_for_group[17] := '102'
list_for_group[18] := '103'
list_for_group[19] := '104'
list_for_group[20] := '101'
list_for_group[21] := '101'
list_for_group[22] := '102'
list_for_group[23] := '103'
list_for_group[24] := '104'
list_for_group[25] := '101'

set date Italian
st := { {'fio','C',15,0}, {'gender','L',1,0}, {'dr','D',8,0}, {'stip','N',8,2}, {'Ngr','C',3,0} }
dbcreate('STUD', st)
use STUD new  


for i := 1 to Len(list_for_stip)
    append blank 
    replace fio with list_for_fio[i], ;
            gender with list_for_gender[i], ;
            dr with list_for_dr[i], ;
            stip with list_for_stip[i], ;
            Ngr with list_for_group[i]
    ? "Record added: " + list_for_fio[i]  
next

use  


gr_schema := { {'Ng', 'C', 3, 0}, {'Spec', 'C', 20, 0} }
dbcreate('GR', gr_schema)
use GR new


list_for_groups := {'101', '102', '103', '104', '105', '106'}
list_for_spec := {'Engineering', 'Mathematics', 'Physics', 'Computer Science', 'Biology', 'Chemistry'}  

for i := 1 to Len(list_for_groups)
    append blank
    replace Ng with list_for_groups[i], Spec with list_for_spec[i]
next

index on Ng to GR_Ng

use
QUIT
