PROC IMPORT OUT= WORK.autismchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\SRS-2 r5 noid-ageclass_1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  V1SRS2Stereotypedbehavior V2SRS2Stereotypedbehavior V3SRS2Stereotypedbehavior BASELINESRS2Stereotypedbehavior;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)V1SRS2Stereotypedbehavior--V3SRS2Stereotypedbehavior;
  subject +1;
  do time=1 to 3;
        srs2stereotybehavdiff=A(time);
	output;
  end; 
drop V1SRS2Stereotypedbehavior--V3SRS2Stereotypedbehavior; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured bh  srs total  diff-measure model,  **********;
proc mixed data=unidata method=ml;
  class  SUBNUM DRUGCODEN time;
  model srs2stereotybehavdiff= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs adjust=dunnett;
  ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measure  srs total  no cov '; 
run;

****** Model1 -- Unstructur srs totoal diff-measure model,  **********;
proc mixed data=unidata method=ml;
  class  SUBNUM DRUGCODEN time;
  model srs2stereotybehavdiff= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measure srs total diff  unstructured modelno cov'; 
run;


****** Model1 -- Unstructured srs totoal diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model srs2stereotybehavdiff= BASELINESRS2Stereotypedbehavior DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  srs totoal diff  unstructured model baseline  cov'; 
run;
