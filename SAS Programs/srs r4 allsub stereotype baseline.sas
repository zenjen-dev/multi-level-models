PROC IMPORT OUT= WORK.autismchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\SRS-2 r4 noid-ageclass r2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  SRS2StereotypedBehaviordiffV1MBA SRS2StereotypedBehaviordiffV2MBA SRS2StereotypedBehaviordiffV3MBA BASELINESRS2Stereotypedbehavior;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)SRS2StereotypedBehaviordiffV1MBA--SRS2StereotypedBehaviordiffV3MBA;
  subject +1;
  do time=1 to 3;
        srsstereotypdiff=A(time);
	output;
  end; 
drop SRS2StereotypedBehaviordiffV1MBA--SRS2StereotypedBehaviordiffV3MBA; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured srs  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model srsstereotypdiff= BASELINESRS2Stereotypedbehavior DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  srs stereotyped behavior diff  unstructured model baseline  cov'; 
run;

