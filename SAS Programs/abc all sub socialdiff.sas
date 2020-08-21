PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\ABC all sub_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN  ABCSODIFFV1B ABCSODIFFV2B ABCSODIFFV3B BASELINEABCSO IIDscoire;  
  run;

proc print data=multidata (obs=95); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)ABCSODIFFV1B--ABCSODIFFV3B;
  subject +1;
  do time=1 to 3;
        abcsocdiff=A(time);
	output;
  end; 
drop ABCSODIFFV1B--ABCSODIFFV3B; 
run;

data unidata;
  set unidata;
  
run;



****** Model1 -- Unstructured abc soc  diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model abcsocdiff=BASELINEABCSO  DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop abc soc diff with iq factor unstructured model baseline  cov'; 
run;


****** Model1 -- Unstructured abc soc  diff -measure model with iq factor,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN IIDscoire time;
  model abcsocdiff=BASELINEABCSO IIDscoire DRUGCODEN time  time*DRUGCODEN  DRUGCODEN*IIDscoire time*DRUGCODEN*IIDscoire /solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
 lsmeans time*DRUGCODEN*IIDscoire/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop abc soc diff with iq factor unstructured model baseline  cov'; 
run;

