PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r6 all sub_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN Stereotypesmodelnumdiffv1mb Stereotypesmodelnumdiffv2mb Stereotypesmodelnumdiffv3mb StereotypesmodelBaselineaverage;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)Stereotypesmodelnumdiffv1mb--Stereotypesmodelnumdiffv3mb;
  subject +1;
  do time=1 to 3;
        osustereotypdiff=A(time);
	output;
  end; 
drop Stereotypesmodelnumdiffv1mb--Stereotypesmodelnumdiffv3mb; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu all sub diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
title "repeated measures osu all sub stereotype diff unstructured model baseline cov";
  class SUBNUM DRUGCODEN time;
  model osustereotypdiff= StereotypesmodelBaselineaverage DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
title;
