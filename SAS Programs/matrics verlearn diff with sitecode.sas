PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\ovschiz\sulforaphane matrics verlearn diff  r1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;
title;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd YearsILLmonths sitecode MATRICSVERLEARNW12W2DIFF MATRICSVERLEARNW24W2DIFF W2MCCBVerbalLearning;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSVERLEARNW12W2DIFF--MATRICSVERLEARNW24W2DIFF;
  subject +1;
  do time=1 to 2;
        verlearndiff=A(time);
	output;
  end; 
drop  MATRICSVERLEARNW12W2DIFF--MATRICSVERLEARNW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics verlearn total  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time;
  model verlearndiff = W2MCCBVerbalLearning  groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure   matrics verlearn diff  with baseline cov '; 
run;
title;

****** Model1 -- Unstructur  matrics verlearn diff with site  codee with bas cov  model,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time sitecode;
  model verlearndiff = W2MCCBVerbalLearning groupcd time sitecode  groupcd*sitecode  time*groupcd sitecode*time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  lsmeans  sitecode*time*groupcd/diffs;
    ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure matric verlearn diff with site code with bas cov'; 
run;
title;

