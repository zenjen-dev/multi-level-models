
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\RBS r5 dis below 60.sav"
 
            DBMS=SPSS REPLACE;

RUN;
proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  TotalscoreV1Baselinediff TotalscoreV2Baselinediff TotalscoreV3Baselinediff Baselinetotalscore IIDscoire;  
  run;

proc print data=multidata (obs=50); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)TotalscoreV1Baselinediff--TotalscoreV3Baselinediff;
  subject +1;
  do time=1 to 3;
        rbstotdiff=A(time);
	output;
  end; 
drop TotalscoreV1Baselinediff--TotalscoreV3Baselinediff; 
run;

data unidata;
  set unidata;
  
run;



****** Model1 -- Unstructured rbs total  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model rbstotdiff=Baselinetotalscore  DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop rbs total diff dis below 60 unstructured model baseline  cov'; 
run;

