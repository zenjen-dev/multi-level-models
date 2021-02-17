PROC IMPORT OUT= WORK.autismchina 
            DATAFILE= "C:\SAS data files\SAS DATA\autism sulferaphane\srs\SRS-2 r5 noid.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;

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

****** Model1 -- Unstructured bh  srs total  diff-measure model,  **********;
proc mixed data=unidata method=ml;
  class  SUBNUM DRUGCODEN time;
  model srstdf= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs adjust=dunnett;
  ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measure  srs total  no cov '; 
run;

****** Model1 -- Unstructur srs totoal diff-measure model,  **********;
proc mixed data=unidata method=ml;
  class  SUBNUM DRUGCODEN time;
  model srstdf= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measure srs total diff  unstructured modelno cov'; 
run;


****** Model1 -- Unstructured srs totoal diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model srstdf= BASELINESRS2TOTAL DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs adjust=dunnett;;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  srs totoal diff  unstructured model baseline  cov'; 
run;
