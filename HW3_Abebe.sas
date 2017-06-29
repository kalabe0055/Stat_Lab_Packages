
libname GWU 'C:\Users\danielareeve\Desktop';



proc sql;
 create table troutcall
 as
 select *
 from Tmp1.trout_operations o
 where not exists
 (select poId
 from Tmp1.trout_disqualify d
 where o.poId=d.poId);
quit;

proc print data = troutcall;
run;
