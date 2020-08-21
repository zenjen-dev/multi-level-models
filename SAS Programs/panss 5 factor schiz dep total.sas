PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulferaphane panss 5factor1 rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd PANSSDepress5FactW2 PANSSDepress5FactW6	PANSSDepress5FactW12 PANSSDepress5FactW24 SEXCODE YearsILLmonths;  

  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)PANSSDepress5FactW2--PANSSDepress5FactW24;
  subject +1;
  do time=1 to 4;
        pnsdeptot=A(time);
	output;
  end; 
drop PANSSDepress5FactW2--PANSSDepress5FactW24; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured panss 5 factor total unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model pnsdeptot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures panss 5factor depression total unstructured model '; 
run;


