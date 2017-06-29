libname gwu "C:\Users\Public\Desktop";

/* Trout operations with at least 10000 dollars in annual sales ..*/

data mizz_dairy;
set  gwu.missouri_dairy;
if milk_sales > 0;
run;


proc iml;


 use mizz_dairy;
 read all var { poid county milk_sales } into mizz;
 call sort(mizz,3);

 /* Find the cumulative fraction of sales for the sorted matrix.*/


 SALES_TOTAL = sum(mizz[ ,3]);
 N_OPS = NROW(mizz);
 SALES_CUM = J(N_OPS,1,0);

 SALES_CUM[1] = mizz[1,3];
 do i = 2 to N_OPS;
 SALES_CUM[i] = SALES_CUM[i-1] + mizz[i,3];
 end;

 SALES_CUM = SALES_CUM/SALES_TOTAL;

 mizz = mizz||SALES_CUM;

 /* Classify operations into  NSTRATA groups ( strata ).*/


 NSTRATA = 4;

 STRATA = J(N_OPS,1,NSTRATA);

 do i = 1 to N_OPS;
 do j = 1 to NSTRATA;
 if mizz [i,4] < (NSTRATA - j)/NSTRATA then STRATA[i,1] = NSTRATA - j;
 end;
 end;

 mizz = mizz||strata;

 print mizz;

 /* OUTPUT matrix TROUT to a SAS data set trout_classify.*/


   cname = {  poid counties milk_sales cum strata_number};

      CREATE mizz_classify  FROM mizz[ colname = cname ];

      append from mizz; 
quit;

proc print data = mizz_classify;
run;


run;


