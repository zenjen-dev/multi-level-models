PROC IMPORT OUT= WORK.autismchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\SRS-2 r6 dis below 60 ageclass r2.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  SRS2TOTALdiffV1MBAS SRS2TOTALdiffV2MBAS SRS2TOTALdiffV3MBAS BASELINESRS2TOTAL;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)SRS2TOTALdiffV1MBAS--SRS2TOTALdiffV3MBAS;
  subject +1;
  do time=1 to 3;
        srstdf=A(time);
	output;
  end; 
drop SRS2TOTALdiffV1MBAS--SRS2TOTALdiffV3MBAS; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured srs total diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model srstdf= BASELINESRS2TOTAL DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures srs dis below 60 total diff  unstructured model baseline cov'; 
run;
