
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\ABC  iq60_rev2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  ABCDIFFTOTELV1 ABCDIFFTOTELV2 ABCDIFFTOTELV3 BASELINEABCTOTEL IIDscoire ageclass2;  
  run;

proc print data=multidata (obs=95); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)ABCDIFFTOTELV1--ABCDIFFTOTELV3;
  subject +1;
  do time=1 to 3;
        abctotdiff=A(time);
	output;
  end; 
drop ABCDIFFTOTELV1--ABCDIFFTOTELV3; 
run;

data unidata;
  set unidata;
  
run;


  ****** Model1 -- Unstructured abc total diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time ageclass2;
  model abctotdiff= BASELINEABCTOTEL DRUGCODEN time ageclass2 time*DRUGCODEN ageclass2*DRUGCODEN ageclass2*time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans ageclass2*DRUGCODEN*time/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures abc dis over 60 total diff unstructured model ageclass2 with baseline cov'; 
run;
