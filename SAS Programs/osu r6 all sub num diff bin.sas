PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\OSU r6 all sub_ageclass.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN ageclass numberdiffv1mb numberdiffv2mb numberdiffv3mb Baselinenumber;  
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)numberdiffv1mb--numberdiffv3mb;
  subject +1;
  do time=1 to 3;
        osunumdiff=A(time);
	output;
  end; 
drop numberdiffv1mb--numberdiffv3mb; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 --  osu  diff -measure model,  **********;
proc glimmix data=unidata method=laplace;
  class SUBNUM DRUGCODEN time;
  model osunumdiff = Baselinenumber DRUGCODEN time  time*DRUGCODEN/solution dist=binomial link=logit /*indication of BINOMIAL
distribution, transform goes in this statement */;
  random intercept /subject=SUBNUM type=ar(1);
  lsmeans time*DRUGCODEN/diffs;
ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop osu num diff model baseline cov and ageclass'; 
run;


