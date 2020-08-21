PROC IMPORT OUT= WORK.schizchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\sulferaphane panss 5factor1.sav"
 DBMS=SPSS REPLACE;
proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd  PANNSCogFactW6W2DIFF PANNSCogFactW12W2DIFF PANNSCogFactW24W2DIFF PANSSCog5FactW2	 SEXCODE YearsILLmonths ;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)PANNSCogFactW6W2DIFF--PANNSCogFactW24W2DIFF;
  subject +1;
  do time=1 to 3;
        pnscogdf=A(time);
	output;
  end; 
drop PANNSCogFactW6W2DIFF--PANNSCogFactW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;



  ****** Model1 --  osu  diff -measure model,  **********;
proc glimmix data=unidata method=laplace;
  class SubNo2 groupcd time ;
  model pnscogdf = PANSSCog5FactW2 groupcd time  time*groupcd/solution dist=binomial link=logit /*indication of BINOMIAL
distribution, transform goes in this statement */;
  random intercept /subject=SubNo2 type=un;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated pansscog 5factordiff diff  unstructured model with baseline  cov'; 
run;

