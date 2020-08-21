
PROC IMPORT OUT= WORK.schizchina 
/* change file name here */DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\sulferaphane panss 5factor1.sav"
 DBMS=SPSS REPLACE;
proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd  PANNSExcitFactW6W2DIFF PANNSExcitFactW12W2DIFF PANNSExcitFactW24W2DIFF PANSSExcit5FactW2	 SEXCODE YearsILLmonths ;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)PANNSExcitFactW6W2DIFF--PANNSExcitFactW24W2DIFF;
  subject +1;
  do time=1 to 3;
        pnsexcdf=A(time);
	output;
  end; 
drop PANNSExcitFactW6W2DIFF--PANNSExcitFactW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Model1 generalized mixed - unstructured panss diff -measure model,   **********;

proc glimmix data=unidata;
  class SubNo2 groupcd time ;
  /*distribution/link (transform)/DF syntax indicated in below line */
  model pnsexcdf =PANSSExcit5FactW2 YearsILLmonths groupcd time  time*groupcd / dist=poisson link=log ddf=145,145,145,145,145 solution;
  random intercept / subject=SubNo2 type=un;
  random _residual_;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated panss excitement 5factor diff  unstructured model with baseline cov months ill'; 
run;
