PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulforaphane matrics verlearn diff  r1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd W2MCCBVerbalLearning	W12MCCBVerbalLearning W24MCCBVerbalLearning YearsILLmonths SEXCODE ;  

  run;

proc print data=multidata (obs= 61); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)W2MCCBVerbalLearning--W24MCCBVerbalLearning;
  subject +1;
  do time=1 to 3;
        verblearntot=A(time);
	output;
  end; 
drop W2MCCBVerbalLearning--W24MCCBVerbalLearning; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics verbal learning unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model verblearntot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures matrics verbal learning total unstructured model '; 
run;


