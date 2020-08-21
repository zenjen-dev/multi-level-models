PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\cgi\OSU r6cr2 all sub.sav"
 
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


****** Model1 generalized mixed - unstructured total -measure model  **********;

proc glimmix data=unidata;
  class SUBNUM DRUGCODEN time ;
    /*distribution lognormal transform/DF syntax indicated in MODEL line */
  model cgimprovetotdiff = DRUGCODEN time  time*DRUGCODEN / ddf=89,89,89 solution;
  random intercept / subject=SUBNUM type=un;
  random _residual_;
  lsmeans time*DRUGCODEN/diffs ilink;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated CGI-Improvement total unstructured model no cov'; 
run;
