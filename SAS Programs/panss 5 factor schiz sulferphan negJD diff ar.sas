PROC IMPORT OUT= WORK.schizchina 
/*change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\sulferaphane panss 5factor1.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd  PANNSNegFactJDaddW6W2DIFF PANNSNegFactJDaddW12W2DIFF PANNSNegFactJDaddW24W2DIFF PANSSNeg5FactJDaddW2 SEXCODE YearsILLmonths;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)PANNSNegFactJDaddW6W2DIFF--PANNSNegFactJDaddW24W2DIFF;
  subject +1;
  do time=1 to 3;
        pnsnegdf=A(time);
	output;
  end; 
drop PANNSNegFactJDaddW6W2DIFF--PANNSNegFactJDaddW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 --  pansneg  5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time ;
  model pnsnegdf=PANSSNeg5FactJDaddW2 groupcd  time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=ar(1) r rcorr;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated panss 5factor neg JD diff ar  unstructured model with baseline  cov'; 
run;


****** Model2 --  panssneg  5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time SEXCODE;
  model pnsnegdf=PANSSNeg5FactJDaddW2 groupcd  time  SEXCODE time*groupcd SEXCODE*groupcd  SEXCODE*time*groupcd /solution;
  repeated time /subject=SubNo2 type=ar(1) r rcorr;
  lsmeans time*groupcd/diffs;
 lsmeans SEXCODE*time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated panss neg 5factor neg JD diff ar model with baseline  cov and sex code'; 
run;

****** Model2 --  panssneg 5factor diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SubNo2 groupcd time ;
  model pnsnegdf=PANSSNeg5FactJDaddW2 YearsILLmonths groupcd  time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=ar(1) r rcorr;
  lsmeans time*groupcd/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated panss 5factor neg JD diff ar model with baseline  cov with months ill cov'; 
run;

