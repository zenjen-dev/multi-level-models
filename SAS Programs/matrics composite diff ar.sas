PROC IMPORT OUT= WORK.schizchina 
/*change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\sulforaphane matrics compos diff.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd YearsILLmonths SEXCODE MATRICSCOMPOSITEW12W2DIFF MATRICSCOMPOSITEW24W2DIFF matricsovcompsitew2;  
  run;

proc print data=multidata (obs=120); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSCOMPOSITEW12W2DIFF--MATRICSCOMPOSITEW24W2DIFF;
  subject +1;
  do time=1 to 2;
        compdiff=A(time);
	output;
  end; 
drop MATRICSCOMPOSITEW12W2DIFF--MATRICSCOMPOSITEW24W2DIFF ; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 --  bh comidff total  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time;
  model compdiff= matricsovcompsitew2 groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=ar(1) r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure   matrics comp diff baseline cov '; 
run;
title;

****** Model1 --  matrics comp diff with sex with bas cov  model,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time SEXCODE;
  model compdiff= matricsovcompsitew2 groupcd time SEXCODE  groupcd*SEXCODE  time*groupcd SEXCODE*time*groupcd/solution;
  repeated time /subject=SubNo2 type=ar(1) r rcorr;
  lsmeans time*groupcd/diffs;
  lsmeans  SEXCODE*time*groupcd/diffs;
    ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure matric comp diff with sex with bas cov'; 
run;
title;


****** Model1 matrics   comp diff  with bas cov and years of ill cov -- ,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time;
  model compdiff= matricsovcompsitew2 YearsILLmonths groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=ar(1) r rcorr;
  lsmeans time*groupcd/diffs;
	ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measures matrcis comp diff with bas cov and years ill cov'; 
run;
title;
