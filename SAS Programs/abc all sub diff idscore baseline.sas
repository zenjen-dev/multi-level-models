PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\ABC all sub_rev2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;
proc contents data=autismchina; 
run;
data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN ABCDIFFTOTELV1 ABCDIFFTOTELV2 ABCDIFFTOTELV3 BASELINEABCTOTEL IIDscoire;  
  run;

proc print data=multidata (obs=92); 
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


****** Model1 -- Unstructured abc total  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time IIDscoire;
  model abctotdiff=BASELINEABCTOTEL  DRUGCODEN time  IIDscoire time*DRUGCODEN IIDscoire*DRUGCODEN IIDscoire*time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans IIDscoire*DRUGCODEN*time/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures abc total diff unstructured model baseline IDscore cov'; 
run;


