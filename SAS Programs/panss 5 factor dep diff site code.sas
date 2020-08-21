PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\ovschiz\sulferaphane panss 5factor1 rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;
title;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd YearsILLmonths sitecode PANNSDepressFactW6W2DIFF PANNSDepressFactW12W2DIFF PANNSDepressFactW24W2DIFF PANSSDepress5FactW2;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)PANNSDepressFactW6W2DIFF--PANNSDepressFactW24W2DIFF;
  subject +1;
  do time=1 to 3;
        pnsdepdiff=A(time);
	output;
  end; 
drop  PANNSDepressFactW6W2DIFF--PANNSDepressFactW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured  panss 5faact depession  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time;
  model pnsdepdiff = PANSSDepress5FactW2  groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure panss 5fact depression with baseline cov '; 
run;
title;

****** Model1 -- Unstructur panss 5fact depression diff with site  codee with bas cov  model,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time sitecode;
  model pnsdepdiff = PANSSDepress5FactW2 groupcd time sitecode  groupcd*sitecode  time*groupcd sitecode*time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  lsmeans  sitecode*time*groupcd/diffs;
    ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure panss 5fact depression diff with site code with bas cov'; 
run;
title;

