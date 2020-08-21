*FILE NAME: OSU r7 dis over 60_ageclass;
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r7 over60_ageclass_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN ageclass averagediffv1mb averagediffV2mb averagediffV3mb Baselineaverage;  
  run;

proc print data=multidata (obs=50); 
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


****** Model1 -- Unstructured osu totoal diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time ageclass;
  model osutotavdiff= Baselineaverage DRUGCODEN time  ageclass time*DRUGCODEN ageclass*DRUGCODEN ageclass*time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans ageclass*DRUGCODEN*time/diffs;
ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures osu unstructured model baseline cov and ageclass'; 
run;
