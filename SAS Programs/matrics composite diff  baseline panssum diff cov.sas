PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "/home/u41020973/sasuser.v94/data/sulforaphane matrics compos diff rev with panss sum pos negJD diff.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd matricsovcompsitew2 W12PANSSSUMdiff W24PANSSSUMdiff MATRICSCOMPOSITEW12W2DIFF MATRICSCOMPOSITEW24W2DIFF  ;  

  run;

proc print data=multidata (obs=134); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSCOMPOSITEW12W2DIFF--MATRICSCOMPOSITEW24W2DIFF;
  subject +1;
  do time=1 to 2;
        matricsovcompdiff=A(time);
	output;
  end; 
drop MATRICSCOMPOSITEW12W2DIFF--MATRICSCOMPOSITEW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics overall comp unstructured model  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model matricsovcompdiff= matricsovcompsitew2 W12PANSSSUMdiff groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures matrics overall composite diff with baseline and pansssum w12w2 diff cov'; 
run;


****** Model1 -- Unstructured matrics overall comp unstructured model  **********;
proc mixed data=unidata method=ml covtest;
class SubNo2 groupcd time;
model matricsovcompdiff = matricsovcompsitew2 W24PANSSSUMdiff groupcd time time*groupcd/solution;
repeated time /subject=SubNo2 type=un r rcorr;
lsmeans time*groupcd/diffs;
ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
title 'repeated measures matriucs overall composite diff with baseline and pansssum w24w2 diff cov';
run;


