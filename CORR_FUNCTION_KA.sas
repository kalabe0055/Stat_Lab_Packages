proc iml;

U = { 2.4 1  2, 5.8 3 6.9, 4 7.7 5, 9.1 6 21.1};

start CORRELATION(X,R);
Y = J(NROW(X),NCOL(X),0);
do k = 1 to NCOL(X);
MEAN = SUM(X[ ,k])/NROW(X);
XBAR = J(NROW(X),1,MEAN);
Z = X[ ,k] - XBAR;
STD = SQRT((Z`*Z)/(NROW(X) - 1));
Z = Z/STD;
Y[ ,k] = Z;;
end;

R = (Y`*Y)/(NROW(X) - 1);
finish CORRELATION;

call CORRELATION(U,CORR);

print CORR;

quit;
run;
