
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\cgi\OSU r6cr2 all sub.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  severitydiffv1mb severitydiffv2mb severitydiffv3mb severityBaseline IIDscoire;  
  run;

proc print data=multidata (obs=100); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)severitydiffv1mb--severitydiffv3mb;
  subject +1;
  do time=1 to 3;
        cgiseveritytotdiff=A(time);
	output;
  end; 
drop severitydiffv1mb--severitydiffv3mb; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured CGI-S diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model cgiseveritytotdiff= severityBaseline DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures CGI-S diff  unstructured model baseline cov'; 
run;
