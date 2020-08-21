PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\ovschiz\sulforaphane matrics  reasonips diff r1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;
title;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd YearsILLmonths sitecode MATRICSREASONPSW12W2DIFF MATRICSREASONPSW24W2DIFF W2MCCBReasoningandProblem;  
  run;

proc print data=multidata (obs=151); 
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

****** Model1 -- Unstructured matrics reasonps total  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time;
  model reasonpsdiff = W2MCCBReasoningandProblem  groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure   matrics reasonps diff  with baseline cov '; 
run;
title;

****** Model1 -- Unstructur  matrics reasonps diff with site  codee with bas cov  model,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time sitecode;
  model reasonpsdiff = W2MCCBReasoningandProblem groupcd time sitecode  groupcd*sitecode  time*groupcd sitecode*time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  lsmeans  sitecode*time*groupcd/diffs;
    ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure matric reasonps diff with site code with bas cov'; 
run;
title;

