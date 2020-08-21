PROC IMPORT OUT= WORK.schizchina 
  /*change file name here */ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\sulforaphane matrics verlearn diff  r1.sav"
            DBMS=SPSS REPLACE;


RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd2 YearsILLmonths SEXCODE MATRICSVERLEARNW12W2DIFF MATRICSVERLEARNW24W2DIFF W2MCCBVerbalLearning;  
  run;

proc print data=multidata (obs=150); 
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
drop  MATRICSPATWMW12W2DIFF--MATRICSVERLEARNW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics verlearn total  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd2 time;
  model verlearndiff = W2MCCBVerbalLearning  groupcd2 time  time*groupcd2/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd2/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure   matrics verb learning diff  with baseline cov '; 
run;
