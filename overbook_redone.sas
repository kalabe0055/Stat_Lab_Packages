

proc iml;

start Expected_Revenue(T,W,S,M,p,R);

R=0;
do x=s+1 to M;
R=R+(x-S)*PDF('binomial',x,p,M);
end;

R=(P*T*M)-R*(T+W);

finish Expected_Revenue; 

final=J(15,2,-1);
do k=1 to 15;
final[k,1]=200+k;
call Expected_Revenue(100,250,200,200+k,0.95,rev);
final[k,2]=rev;
end;

print final;


MAX_REVENUE=final[<>,2];
MAX_COL2_WHERE=final[<:>,2];
BOOKED=MAX_COL2_WHERE +200;

print BOOKED MAX_REVENUE;

quit;






ODS RTF FILE='F:\sas\overbooking_output.RTF';
proc print data=gwu.binomial;
run;
ODS RTF CLOSE;





















