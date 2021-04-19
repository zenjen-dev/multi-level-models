PROC IMPORT OUT= WORK.schizchina 
  /*change file name here */ DATAFILE= "/home/u41020973/sasuser.v94/data/sulforaphane matrics reasonps diff rev with panss sum pos negJD diff.sav"
            DBMS=SPSS REPLACE;


RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd PANNSNegFactJDaddW12W2DIFF PANNSNegFactJDaddW24W2DIFF MATRICSREASONPSW12W2DIFF MATRICSREASONPSW24W2DIFF W2MCCBReasoningandProblem;  
  run;

proc print data=multidata (obs=133); 
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


****** Model1 -- Unstructured matrics reasoningps  diff  ,  **********;
proc mixed data=unidata method=ml covtest;
  class  SubNo2 groupcd time ;
  model reasonpsdiff=  W2MCCBReasoningandProblem PANNSNegFactJDaddW12W2DIFF groupcd time  time*groupcd /solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures  matrics reasoningps diff baseline with panss neg 5fact JD w12w2 diff cov '; 
run;

****** Model1 -- Unstructured matrics reasoningps  diff  ,  **********;
proc mixed data=unidata method=ml covtest;
  class  SubNo2 groupcd time ;
  model reasonpsdiff=  W2MCCBReasoningandProblem PANNSNegFactJDaddW12W2DIFF groupcd time  time*groupcd /solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures  matrics reasoningps diff baseline with panss neg 5fact JD w24w2 diff cov '; 
run;
