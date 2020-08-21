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
        cgi_improvement=A(time);
	output;
  end; 
drop degreeofimprovementV1--degreeofimprovementV3; 
run;

data unidata;
  set unidata;
  
run;


**** MACRO for Mixed Model Analysis with Effect Size ****;
%macro effectsize_rep(file=,y=,class=, fixed = );
TITLE1 "repeated measures CGI-Improvement unstructured model with effectsize";
PROC MIXED DATA = &file
METHOD=ML COVTEST;
CLASS &class;
MODEL &y =&fixed / outpm=outpm1 solution
ddfm=betwithin;
repeated time /subject=SUBNUM type=un r rcorr;
ods output tests3=tests3;
RUN; QUIT;

%_eg_conditional_dropds(var2);
PROC MEANS DATA=WORK.outpm1 nonobs noprint
FW=12
PRINTALLTYPES
CHARTYPE
VARDEF=N
VAR
N ;
VAR &y Resid;
OUTPUT OUT=var3
VAR()=
N()=
/ ;
RUN;
data var4;
set var3;
id=_n_;
run;
data test_eta;
set tests3;
id=_n_;
Run;
%_eg_conditional_dropds(SASUSER.QUERY_FOR_TEST_ETA);
%_eg_conditional_dropds(SASUSER.test_eta_2);
PROC SQL;
 CREATE TABLE SASUSER.test_eta_2 AS
 SELECT t1.*,
 t2.*

 FROM WORK.TEST_ETA t1
 , WORK.VAR4 t2 ;
quit;
data sasuser.&y;
set sasuser.test_eta_2;
mse =resid*(_freq_-1)/_freq_;
ss_effect = numdf*Fvalue*mse;
ss_total = (_freq_ -1)*&y;
ss_error = mse*(_freq_-numdf);
eta_2=ss_effect/ss_total;
omega_2 = (ss_effect-(numdf*mse))/(ss_total+mse);
partial_eta_2=ss_effect/(ss_effect+ss_error);
run;
%mend;
%effectsize_rep(file=unidata,y=cgi_improvement,class= DRUGCODEN time, fixed =DRUGCODEN time  time*DRUGCODEN);
/* above line specifies file and model components/interaction in mixed model */
proc print data=sasuser.cgi_improvement; run;
