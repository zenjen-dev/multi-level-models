PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r7 over60_ageclass_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN Baselineaverage V1average V2average V3average IIDscoire;
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)Baselineaverage--V3average;
  subject +1;
  do time=1 to 4;
        osutot=A(time);
	output;
  end; 
drop Baselineaverage--V3average;
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu dis over 60 tot ov-measure model,  **********;
proc mixed data=unidata method=ml covtest;
title "repeated measures osu dis over 60 tot ov unstructured model";
  class SUBNUM DRUGCODEN time;
  model osutot= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
title;
