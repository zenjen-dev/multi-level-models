PROC IMPORT OUT= WORK.autismchina 
 /*change file name here*/DATAFILE= "C:\SAS Files\Data\OSU r7 over60.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN AGE SEXCODE averagediffv1mb averagediffV2mb averagediffV3mb Baselineaverage;  
  run;

proc print data=multidata (obs=92); 
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



****** Model1 -- Unstructured srs osu toal av diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model osutotavdiff= age age*DRUGCODEN DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  *setup to test specific values of the cov if interaction significant;
  lsmeans DRUGCODEN/diffs at age=4;
  lsmeans DRUGCODEN/diffs at age=8;
  lsmeans DRUGCODEN/diffs at age=12;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  osu toal av diff unstructured model baseline with age cov'; 
run;

****** Model1 -- Unstructured srs osu toal av diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time SEXCODE;
  model osutotavdiff= SEXCODE SEXCODE*DRUGCODEN DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans SEXCODE*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  osu toal av diff unstructured model baseline  cov and sex code'; 
run;


