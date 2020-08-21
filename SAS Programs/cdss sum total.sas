PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulforapne schiz cdss diff.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubjectNo_2 groupcd W2CDSSSUM W6CDSSSUM W12CDSSSUM W24CDSSSUM SEXCODE YearsILLmonths;  

  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)W2CDSSSUM--W24CDSSSUM;
  subject +1;
  do time=1 to 4;
        cdsstot=A(time);
	output;
  end; 
drop W2CDSSSUM--W24CDSSSUM; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured cdss total unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubjectNo_2 groupcd time;
  model cdsstot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubjectNo_2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures cdss total unstructured model '; 
run;


