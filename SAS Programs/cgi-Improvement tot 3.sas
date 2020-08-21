PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\cgi\OSU r6cr2 all sub one post baseline CGI-I .sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN degreeofimprovementV1 degreeofimprovementV2 degreeofimprovementV3 IIDscoire;
  run;

proc print data=multidata (obs=100); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)degreeofimprovementV1--degreeofimprovementV3;
  subject +1;
  do time=1 to 3;
        cgimprovetotdiff=A(time);
	output;
  end; 
drop degreeofimprovementV1--degreeofimprovementV3; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured CGI-I diff -measure model,  **********;
proc mixed data=unidata method=ml plots=all;
  class SUBNUM DRUGCODEN time;
  model cgimprovetotdiff=  DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures CGI-Improvement  unstructured model no cov'; 
run;
