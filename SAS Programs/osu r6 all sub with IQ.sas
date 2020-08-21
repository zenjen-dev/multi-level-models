
*FILE NAME: OSU r6 allsub_ageclass;
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\OSU r6 all sub_ageclass.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN IIDscoire ageclass severitydiffv1mb severitydiffv2mb severitydiffv3mb severityBaseline;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)severitydiffv1mb--severitydiffv3mb;
  subject +1;
  do time=1 to 3;
        osusevtotdiff=A(time);
	output;
  end; 
drop severitydiffv1mb--severitydiffv3mb; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu totoal diff -measure model,  **********;
proc glimmix data=unidata method=laplace;
  class SUBNUM DRUGCODEN time ageclass IIDscoire;
  model osusevtotdiff /* BINOMIAL VARIABLE HERE */= severityBaseline DRUGCODEN time  IIDscoire
ageclass time*DRUGCODEN IIDscoire*DRUGCODEN /solution dist=binomial link=logit /*transformation*/;
  random intercept /subject=SUBNUM type=ar(1);
    lsmeans DRUGCODEN ageclass IIDscoire|DRUGCODEN/diff=all ilink;
	/* relates to prev transformation to make output more readable*/
ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop  osu ar model baseline cov and ageclass'; 
run;
