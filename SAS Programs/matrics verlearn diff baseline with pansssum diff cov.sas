PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "/home/u41020973/sasuser.v94/data/sulforaphane matrics verlearn diff rev with panss sum pos negJD diff.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;


proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd W2MCCBVerbalLearning W12PANSSSUMdiff W24PANSSSUMdiff MATRICSVERLEARNW12W2DIFF MATRICSVERLEARNW24W2DIFF ;  
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

****** Model1 -- Unstructured matrics verlearn total  diff with  cov,  **********;
proc mixed data=unidata method=ml covtest;
  class  SubNo2 groupcd time;
  model verlearndiff = W2MCCBVerbalLearning W12PANSSSUMdiff groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures  matrics  verlearn diff baseline with pansssum w12w2 diff cov '; 
run;


****** Model1 -- Unstructured matrics verlearn total  diff with  cov,  **********;
proc mixed data=unidata method=ml covtest;
  class  SubNo2 groupcd time;
  model verlearndiff = W2MCCBVerbalLearning W24PANSSSUMdiff groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures  matrics  verlearn diff baseline with pansssum w24w2 diff cov '; 
run;

