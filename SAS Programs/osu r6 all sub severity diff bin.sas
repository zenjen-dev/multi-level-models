
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\OSU r7 over60_ageclass.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN ageclass severitydiffv1mb severitydiffv2mb severitydiffv3mb severityBaseline;  
  run;

proc print data=multidata (obs=45); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)severitydiffv1mb--severitydiffv3mb;
  subject +1;
  do time=1 to 3;
        osusevdiff=A(time);
	output;
  end; 
drop severitydiffv1mb--severitydiffv3mb; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 --  osu  diff -measure model,  **********;
proc glimmix data=unidata method=laplace;
  class SUBNUM DRUGCODEN time;
  model osusevdiff = severityBaseline DRUGCODEN time  time*DRUGCODEN/solution dist=binomial link=logit /*indication of BINOMIAL
distribution, transform goes in this statement */;
  random intercept /subject=SUBNUM type=ar(1);
  lsmeans time*DRUGCODEN/diffs;
ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop osu severity model baseline cov'; 
run;


