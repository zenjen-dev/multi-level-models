PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulforaphane matrics  reasonips diff r1.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd W2MCCBReasoningandProblem	W12MCCBReasoningandProblem	W24MCCBReasoningandProblem YearsILLmonths SEXCODE ;  

  run;

proc print data=multidata (obs= 61); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)W2MCCBReasoningandProblem--W24MCCBReasoningandProblem;
  subject +1;
  do time=1 to 3;
        reasonpstot=A(time);
	output;
  end; 
drop W2MCCBReasoningandProblem--W24MCCBReasoningandProblem; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics reasonps total unstructured model  **********;
proc mixed data=unidata method=ml covtest; ***covtest ?;
  class SubNo2 groupcd time;
  model reasonpstot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures matrics reasonps total unstructured model '; 
run;


