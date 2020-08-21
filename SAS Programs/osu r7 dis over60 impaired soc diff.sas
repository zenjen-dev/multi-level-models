*FILE NAME: OSU r6 allsub_ageclass;
PROC IMPORT OUT= WORK.autismchina 
 /*change file location here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\OSU r7 over60_ageclass.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=autismchina; 
run;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN ageclass impaieedsocialinteractionavdiffv impaieedsocialinteractionavdiff1 impaieedsocialinteractionavdiff2 impairedsocialinteractionBaselin;  
  run;

proc print data=multidata (obs=45); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)impaieedsocialinteractionavdiffv--impaieedsocialinteractionavdiff2;
  subject +1;
  do time=1 to 3;
        osuimpsocialavdiff=A(time);
	output;
  end; 
drop impaieedsocialinteractionavdiffv--impaieedsocialinteractionavdiff2; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu diff -measure model,  **********;
proc mixed data=unidata method=ml covtest;
  class SUBNUM DRUGCODEN time;
  model osuimpsocialavdiff= impairedsocialinteractionBaselin DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
  title 'repeated measuresop osu totoal  av diff  unstructured model baseline  cov'; 
run;
