PROC IMPORT OUT= WORK.schizchina 
/*change file name here*/ DATAFILE= "\\Mac\Home\Desktop\SAS Files\sulferaphane panss 5factor1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd  PANNSNegFactW6W2DIFF PANNSNegFactW12W2DIFF PANNSNegFactW24W2DIFF PANSSNeg5FactW2 SEXCODE YearsILLmonths ;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)PANNSNegFactW6W2DIFF--PANNSNegFactW24W2DIFF;
  subject +1;
  do time=1 to 3;
        pnsnegdf=A(time);
	output;
  end; 
drop PANNSNegFactW6W2DIFF--PANNSNegFactW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured pansneg  5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time ;
  model pnsnegdf=PANSSNeg5FactW2 groupcd  time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated pansspos 5factordiff diff  unstructured model with baseline  cov'; 
run;


****** Model2 -- Unstructured panssneg  5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time SEXCODE;
  model pnsnegdf=PANSSNeg5FactW2 groupcd  time  SEXCODE time*groupcd SEXCODE*groupcd  SEXCODE*time*groupcd /solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
 lsmeans SEXCODE*time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated panss neg 5factordiff diff  unstructured model with baseline  cov and sex code'; 
run;

****** Model2 -- Unstructured panssneg 5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time ;
  model pnsnegdf=PANSSNeg5FactW2 YearsILLmonths groupcd  time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated panssneg 5factordiff diff  unstructured model with baseline  cov with months ill cov'; 
run;

