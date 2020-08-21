
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\RBS  r3 all sub 2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;
proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  TotalbaselineceremonialbehaviorV Totalbaselineceremonialbehavior1 Totalbaselineceremonialbehavior2 Ceremonialbehaviortotalbaseline IIDscoire;  
  run;

proc print data=multidata (obs=95); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)TotalbaselineceremonialbehaviorV--Totalbaselineceremonialbehavior2;
  subject +1;
  do time=1 to 3;
        rbsceremdiff=A(time);
	output;
  end; 
drop TotalbaselineceremonialbehaviorV--Totalbaselineceremonialbehavior2; 
run;

data unidata;
  set unidata;
  
run;



****** Model1 -- Unstructured rbs total  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model rbsceremdiff=Ceremonialbehaviortotalbaseline  DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop rbs ceremonial behavior diff  unstructured model baseline  cov'; 
run;

