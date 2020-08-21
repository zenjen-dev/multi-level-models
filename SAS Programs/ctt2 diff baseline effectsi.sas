PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\ctt2 diff (2).sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;
proc contents data=schizchina;
run;
title;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd YearsILLmonths SEXCODE MATRICSCTT2TSCOREW12W2DIFF MATRICSCTT2TSCOREW24W2DIFF W2CTT2secsT;  
  run;

proc print data=multidata (obs= 151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)MATRICSCTT2TSCOREW12W2DIFF--MATRICSCTT2TSCOREW24W2DIFF;
  subject +1;
  do time=1 to 2;
        ctt2diff=A(time);
	output;
  end; 
drop MATRICSCTT2TSCOREW12W2DIFF--MATRICSCTT2TSCOREW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured matrics ctt2 diff total  diff with bas cov,  **********;
**** MACRO for Mixed Model Analysis with Effect Size ****;
%macro effectsize_rep(file=,y=,class=, fixed = );
TITLE1 "repeated measures matrics color trails 2 unstructured model with effectsize";
PROC MIXED DATA = &file
METHOD=ML COVTEST;
CLASS &class;
MODEL &y =&fixed / outpm=outpm1 solution
ddfm=betwithin;

repeated time /subject=SubNo2 type=un r rcorr;
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
%effectsize_rep(file=unidata,y=ctt2diff,class= SubNo2 groupcd time, fixed =W2CTT2secsT groupcd time  time*groupcd);
/* above line specifies file and model components/interaction in mixed model */
proc print data=sasuser.ctt2diff; run;

