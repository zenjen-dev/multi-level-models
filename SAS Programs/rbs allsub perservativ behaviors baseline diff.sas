
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\RBS  r3 all sub 2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;
proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  Totalbaselineperseverativebehavi Totalbaselineperseverativebehav1 Totalbaselineperseverativebehav2 Perseverativebehaviortotalbaseli IIDscoire;  
  run;

proc print data=multidata (obs=90); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)Totalbaselineperseverativebehavi--Totalbaselineperseverativebehav2;
  subject +1;
  do time=1 to 3;
        rbspersdiff=A(time);
	output;
  end; 
drop Totalbaselineperseverativebehavi--Totalbaselineperseverativebehav2; 
run;

data unidata;
  set unidata;
  
run;



****** Model1 -- Unstructured rbs  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model rbspersdiff=Perseverativebehaviortotalbaseli  DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop rbs all sub perservative behavior diff  unstructured model baseline  cov'; 
run;

