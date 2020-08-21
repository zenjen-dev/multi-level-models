PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\ovschiz\sulforaphae matrics  ngds diff.sav"
 
            DBMS=SPSS REPLACE;

RUN;

proc contents data=schizchina;
run;
title;

data multidata ;
  set schizchina;
  keep SubNo2 groupcd YearsILLmonths sitecode NPGDSW12W2DIFF NPGDSW24W2DIFF W2NPSGDS;  
  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(2)NPGDSW12W2DIFF--NPGDSW24W2DIFF;
  subject +1;
  do time=1 to 2;
        npgdsdiff=A(time);
	output;
  end; 
drop  NPGDSW12W2DIFF--NPGDSW24W2DIFF; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured  npgds total  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time;
  model npgdsdiff = W2NPSGDS  groupcd time  time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure npgds diff  with baseline cov '; 
run;
title;

****** Model1 -- Unstructur   npgds diff with site  codee with bas cov  model,  **********;
proc mixed data=unidata method=ml;
  class  SubNo2 groupcd time sitecode;
  model npgdsdiff = W2NPSGDS groupcd time sitecode  groupcd*sitecode  time*groupcd sitecode*time*groupcd/solution;
  repeated time /subject=SubNo2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  lsmeans  sitecode*time*groupcd/diffs;
    ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure npgds diff with site code with bas cov'; 
run;
title;

