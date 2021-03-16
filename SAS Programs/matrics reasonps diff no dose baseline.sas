PROC IMPORT OUT= WORK.schizchina 
  /*change file name here */ DATAFILE= "/home/u41020973/sasuser.v94/data/sulforaphane matrics composite diff  r1 (1).sav"
            DBMS=SPSS REPLACE;


RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd2 YearsILLmonths SEXCODE MATRICSCOMPOSITEW12W2DIFF MATRICSCOMPOSITEW24W2DIFF AGE;  
  run;

proc print data=multidata (obs=133); 
run;f
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSCOMPOSITEW12W2DIFF--MATRICSCOMPOSITEW24W2DIFF;
  subject +1;
  do time=1 to 2;
        compositediff=A(time);
	output;
  end; 
drop  MATRICSCOMPOSITEW12W2DIFF--MATRICSCOMPOSITEW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics composite total  diff with age cov,  **********;
proc mixed data=unidata method=ml covtest;
  class  SubNo2 groupcd time;
  model compositediff = AGE  groupcd time  time*groupcd/solution;
  repeated time /subjct=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures  matrics composite diff  with AGE cov '; 
run;
