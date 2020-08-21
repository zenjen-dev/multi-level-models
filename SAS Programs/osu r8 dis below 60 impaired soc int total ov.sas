PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\OSU r8 below60.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;
proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN impairedsocialinteractionBaselin impairedsocialinteractionV1avera impairedsocialinteractionV2avera impairedsocialinteractionV3avera;
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)impairedsocialinteractionBaselin--impairedsocialinteractionV3avera;
  subject +1;
  do time=1 to 4;
        osuimpairedsoctot=A(time);
	output;
  end; 
drop impairedsocialinteractionBaselin--impairedsocialinteractionV3avera; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu r8 dis below 60 impaired social interaction total -measure model,  **********;
proc mixed data=unidata method=ml;
title "repeated measures osu r8 dis below 60 impaired social interaction tot ov unstructured model";
  class SUBNUM DRUGCODEN time;
  model osuimpairedsoctot= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
title;
