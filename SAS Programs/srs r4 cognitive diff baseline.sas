PROC IMPORT OUT= WORK.autismchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\SRS-2 r4 noid-ageclass r2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  SRS2CognitivediffV1MBAS SRS2CognitivediffV2MBAS SRS2CognitivediffV3MBAS BASELINESRS2Cognitive;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)SRS2CognitivediffV1MBAS--SRS2CognitivediffV3MBAS;
  subject +1;
  do time=1 to 3;
        srscogndiff=A(time);
	output;
  end; 
drop SRS2CognitivediffV1MBAS--SRS2CognitivediffV3MBAS; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured srs  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model srscogndiff= BASELINESRS2Cognitive DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  srs cognitive diff  unstructured model baseline  cov'; 
run;
