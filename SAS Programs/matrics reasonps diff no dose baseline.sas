PROC IMPORT OUT= WORK.schizchina 
  /*change file name here */ DATAFILE= "/home/u41020973/sasuser.v94/data/sulforaphane matrics verlearn diff  r1 (1).sav"
            DBMS=SPSS REPLACE;


RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd2 YearsILLmonths SEXCODE MATRICSVERLEARNW12W2DIFF MATRICSVERLEARNW24W2DIFF AGE;  
  run;

proc print data=multidata (obs=133); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSVERLEARNW12W2DIFF--MATRICSVERLEARNW24W2DIFF;
  subject +1;
  do time=1 to 2;
        verlearndiff=A(time);
	output;
  end; 
drop  MATRICSVERLEARNW12W2DIFF--MATRICSVERLEARNW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics verlearn total  diff with age cov,  **********;
proc mixed data=unidata method=ml covtest;
  class  SubNo2 groupcd time;
  model verlearndiff = AGE  groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures  matrics  verlearn diff  with AGE cov '; 
run;
