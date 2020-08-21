PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulferaphane panss rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;
title;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd W2PANSSSUM W6PANSSSUM	W12PANSSSUM W24PANSSSUM SEXCODE YearsILLmonths;  

  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)W2PANSSSUM--W24PANSSSUM;
  subject +1;
  do time=1 to 4;
        pansstot=A(time);
	output;
  end; 
drop W2PANSSSUM--W24PANSSSUM; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured panss total unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model pansstot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures panss total unstructured model '; 
run;


