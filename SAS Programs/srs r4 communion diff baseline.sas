PROC IMPORT OUT= WORK.autismchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\SRS-2 r4 noid-ageclass r2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  SRS2CommuniondiffV1MBAS SRS2CommuniondiffV2MBAS SRS2CommuniondiffV3MBAS BASELINESRS2Communion;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)SRS2CommuniondiffV1MBAS--SRS2CommuniondiffV3MBAS;
  subject +1;
  do time=1 to 3;
        srscommudiff=A(time);
	output;
  end; 
drop SRS2CommuniondiffV1MBAS--SRS2CommuniondiffV3MBAS; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured srs  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model srscommudiff= BASELINESRS2Communion DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  srs communion diff  unstructured model baseline  cov'; 
run;
