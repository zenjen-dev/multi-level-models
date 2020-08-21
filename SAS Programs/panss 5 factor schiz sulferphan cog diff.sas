PROC IMPORT OUT= WORK.schizchina 
/*change file name here*/ DATAFILE= "\\Mac\Home\Desktop\SAS Files\sulferaphane panss 5factor1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

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

****** Model1 -- Unstructured pansscog  5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time ;
  model pnscogdf=PANSSCog5FactW2 groupcd  time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated pansscog 5factordiff diff  unstructured model with baseline  cov'; 
run;


****** Model2 -- Unstructured panssdep  5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time SEXCODE;
  model pnscogdf=PANSSCog5FactW2 groupcd  time  SEXCODE time*groupcd SEXCODE*groupcd  SEXCODE*time*groupcd /solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
 lsmeans SEXCODE*time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated pansscog 5factordiff diff  unstructured model with baseline  cov and sex code'; 
run;

****** Model2 -- Unstructured panssdep 5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time ;
  model pnscogdf=PANSSCog5FactW2 YearsILLmonths groupcd  time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated pansscog 5factordiff diff  unstructured model with baseline  cov with months ill cov'; 
run;
