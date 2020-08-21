PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r6 all sub_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina;
run;


data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN StereotypesmodelBaselineaverage StereotypesmodelV1average StereotypesmodelV2average StereotypesmodelV3average;
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)StereotypesmodelBaselineaverage--StereotypesmodelV3average;
  subject +1;
  do time=1 to 4;
        osustereotyptot=A(time);
	output;
  end; 
drop StereotypesmodelBaselineaverage--StereotypesmodelV3average; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu all sub stereotypes model total -measure model,  **********;
proc mixed data=unidata method=ml;
title "repeated measures osu all sub stereotypes model totalav unstructured model baseline no cov";
  class SUBNUM DRUGCODEN time;
  model osustereotyptot= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
