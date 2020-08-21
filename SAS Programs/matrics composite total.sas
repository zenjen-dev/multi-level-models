PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\original values schiz\sulforaphane matrics compos diff rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd matricsovcompsitew2	matricsovcompsitew12 matricsovcompsitew24 YearsILLmonths SEXCODE ;  

  run;

proc print data=multidata (obs= 61); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)matricsovcompsitew2--matricsovcompsitew24;
  subject +1;
  do time=1 to 3;
        reasonpstot=A(time);
	output;
  end; 
drop matricsovcompsitew2--matricsovcompsitew24; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics overall comp unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model reasonpstot= groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures matrics overall composite total unstructured model '; 
run;


