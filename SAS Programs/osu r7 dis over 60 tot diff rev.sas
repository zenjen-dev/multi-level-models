PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r7 over60_ageclass_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN averagediffv1mb averagediffV2mb averagediffV3mb Baselineaverage;  
  run;

proc print data=multidata (obs=45); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)averagediffv1mb--averagediffV3mb;
  subject +1;
  do time=1 to 3;
        osutotavdiff=A(time);
	output;
  end; 
drop averagediffv1mb--averagediffV3mb; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu all sub totaldiff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
title "repeated measures osu over60 totalav diff unstructured model baseline cov";
  class SUBNUM DRUGCODEN time;
  model osutotavdiff= Baselineaverage DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
title;
