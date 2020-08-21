PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulforaphane matrics spwm diff  r1.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd W2MCCBWorking	W12MCCBWorking W24MCCBWorking YearsILLmonths SEXCODE ;  

  run;

proc print data=multidata (obs= 61); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)W2MCCBWorking--W24MCCBWorking;
  subject +1;
  do time=1 to 3;
        spwmtot=A(time);
	output;
  end; 
drop W2MCCBWorking--W24MCCBWorking; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics spwm unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model spwmtot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures matrics spatial working mem total unstructured model '; 
run;


