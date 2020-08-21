PROC IMPORT OUT= WORK.autismchina 
 /*change file name here*/DATAFILE= "C:\SAS Files\Data\OSU r6 all sub.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN AGE SEXCODE V1average V2average V3average Baselineaverage;  
  run;


proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)Baselineaverage--V3average;
  subject +1;
  do time=1 to 4;
        osutotav=A(time);
	output;
  end; 
drop Baselineaverage--V3average; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured srs osu toal av  -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model osutotav= age age*DRUGCODEN DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  *setup to test specific values of the cov if interaction significant;
  lsmeans DRUGCODEN/diffs at age=4;
  lsmeans DRUGCODEN/diffs at age=8;
  lsmeans DRUGCODEN/diffs at age=12;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  osu unstructured model baseline with age cov'; 
run;

****** Model1 -- Unstructured srs osu toal av  -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time SEXCODE;
  model osutotav= SEXCODE SEXCODE*DRUGCODEN DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans SEXCODE*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  osu unstructured model baseline  cov and sex code'; 
run;


