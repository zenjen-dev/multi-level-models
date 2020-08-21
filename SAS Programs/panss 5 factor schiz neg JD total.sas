PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulferaphane panss 5factor1 rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd PANSSNeg5FactJDaddW2 PANSSNeg5FactJDaddW6	PANSSNeg5FactJDaddW12 PANSSNeg5FactJDaddW24 SEXCODE YearsILLmonths;  

  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)PANSSNeg5FactJDaddW2--PANSSNeg5FactJDaddW24;
  subject +1;
  do time=1 to 4;
        pnsnegjdtot=A(time);
	output;
  end; 
drop PANSSNeg5FactJDaddW2--PANSSNeg5FactJDaddW24; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured panss negative JD total unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model pnsnegjdtot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures panss negative JD total unstructured model '; 
run;


