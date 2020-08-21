*FILE NAME: OSU r6 allsub_ageclass;
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\ABC all sub_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  ABCDIFFTOTELV1 ABCDIFFTOTELV2 ABCDIFFTOTELV3 BASELINEABCTOTEL IIDscoire;  
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



****** Model1 -- Unstructured abc total  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model abctotdiff=BASELINEABCTOTEL  DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop abc total   diff  unstructured model baseline  cov'; 
run;


****** Model1 -- Unstructured abc total  diff -measure model with iq factgor,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN IIDscoire time;
  model abctotdiff=BASELINEABCTOTEL IIDscoire DRUGCODEN time  time*DRUGCODEN  DRUGCODEN*IIDscoire time*DRUGCODEN*IIDscoire /solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
 lsmeans time*DRUGCODEN*IIDscoire/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop abc total   diff  ewith iq factor unstructured model baseline  cov'; 
run;

