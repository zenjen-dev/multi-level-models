PROC IMPORT OUT= WORK.schizchina 
            DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\ovschiz\sulforapne schiz cdss diff.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=schizchina;
run;

data multidata ;
  set schizchina;
  keep SubjectNo_2 groupcd W6W2SUMDIFF W12W2SUMDIFF W24W2SUMDIFF W2CDSSSUM SiteCode YearsILLmonths;  

  run;

proc print data=multidata (obs=151); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(3)W6W2SUMDIFF--W24W2SUMDIFF;
  subject +1;
  do time=1 to 3;
        cdsstotdiff=A(time);
	output;
  end; 
drop W6W2SUMDIFF--W24W2SUMDIFF; 
run;

data unidata;
  set unidata;
  
run;


****** Model1 -- Unstructured  cdss  diff with bas cov,  **********;
proc mixed data=unidata method=ml;
  class  SubjectNo_2 groupcd time;
  model cdsstotdiff = W2CDSSSUM  groupcd time  time*groupcd/solution;
  repeated time /subject=SubjectNo_2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure cdss diff with baseline cov '; 
run;
title;

****** Model1 -- Unstructur cdss diff with site  code with bas cov  model,  **********;
proc mixed data=unidata method=ml;
  class  SubjectNo_2 groupcd time SiteCode;
  model cdsstotdiff = W2CDSSSUM groupcd time SiteCode  groupcd*SiteCode  time*groupcd SiteCode*time*groupcd/solution;
  repeated time /subject=SubjectNo_2 type=un r rcorr;
  lsmeans time*groupcd/diffs;
  lsmeans  sitecode*time*groupcd/diffs;
    ods output diffs=groupcdiffs lsmeans=groupcdlsmeans;
  title 'repeated measure cdss diff with site code with bas cov'; 
run;
title;



