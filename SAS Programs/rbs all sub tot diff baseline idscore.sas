
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\RBS  r3 all sub ageclass2.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  TotalscoreV1Baselinediff TotalscoreV2Baselinediff TotalscoreV3Baselinediff Baselinetotalscore IIDscoire ;  
  run;

proc print data=multidata (obs=92); 
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


  ****** Model1 -- Unstructured rbs diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time IIDscoire;
  model rbstotdiff= Baselinetotalscore DRUGCODEN time  IIDscoire time*DRUGCODEN IIDscoire*DRUGCODEN IIDscoire*time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans time*DRUGCODEN/diffs;
  lsmeans IIDscoire*DRUGCODEN*time/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measures rbs all sub tot diff unstructured model with baseline idscore cov'; 
run;
