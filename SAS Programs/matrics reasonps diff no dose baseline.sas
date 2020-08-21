PROC IMPORT OUT= WORK.schizchina 
  /*change file name here */ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\sulforaphane matrics  reasonips diff r1.sav"
            DBMS=SPSS REPLACE;


RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd2 YearsILLmonths SEXCODE MATRICSREASONPSW12W2DIFF MATRICSREASONPSW24W2DIFF W2MCCBReasoningandProblem;  
  run;

proc print data=multidata (obs=150); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSREASONPSW12W2DIFF--MATRICSREASONPSW24W2DIFF;
  subject +1;
  do time=1 to 2;
        reasonpsdiff=A(time);
	output;
  end; 
drop  MATRICSREASONPSW12W2DIFF--MATRICSREASONPSW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics reasoningps total  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd2 time;
  model reasonpsdiff = W2MCCBReasoningandProblem  groupcd2 time  time*groupcd2/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd2/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure   matrics  reasoningps diff  with baseline cov '; 
run;
