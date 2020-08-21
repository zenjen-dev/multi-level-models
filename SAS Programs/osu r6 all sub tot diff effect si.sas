PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r6 all sub_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;
proc contents data=autismchina;
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN averagediffv1mb averagediffV2mb averagediffV3mb Baselineaverage;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)averagediffv1mb--averagediffV3mb;
  subject +1;
  do time=1 to 3;
        osutotavdiff=A(time);
	output;
  end; 
drop averagediffv1mb--averagediffV3mb; 
run;

data unidata;
  set unidata;
  
run;

**** MACRO for Mixed Model Analysis with Effect Size ****;
%macro effectsize_rep(file=,y=,class=, fixed = );
TITLE1 "repeated measures osu all sub total av diff  unstructured model";
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
%effectsize_rep(file=unidata,y=osutotavdiff,class= SUBNUM DRUGCODEN time, fixed = Baselineaverage DRUGCODEN time  time*DRUGCODEN);
/* above line specifies file and model components/interaction in mixed model */
proc print data=sasuser.osutotavdiff; run;
