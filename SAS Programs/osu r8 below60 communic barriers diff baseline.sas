PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\OSU r8 below60_ageclass.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN communicationbarriersavdiffv1mb communicationbarriersavdiffv2mb communicationbarriersavdiffv3mb communicationbarriersBaselineave;  
  run;

proc print data=multidata (obs=49); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)communicationbarriersavdiffv1mb--communicationbarriersavdiffv3mb;
  subject +1;
  do time=1 to 3;
        osucommudiff=A(time);
	output;
  end; 
drop communicationbarriersavdiffv1mb--communicationbarriersavdiffv3mb; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu all sub diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
title "repeated measures osu below60 communication barriers diff unstructured model baseline cov";
  class SUBNUM DRUGCODEN time;
  model osucommudiff= communicationbarriersBaselineave DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
title;
