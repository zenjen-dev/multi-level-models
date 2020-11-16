* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
COMPUTE matricsovcompsitew2=(W2TMTT + W2BACSSCT + W2HVLTTSUM + W2WMSIIISST + W2NAWT +W2BVMTTSUM + 
    W2MSCEITT + W2CPTIPTMEAN + W2CategoryFluencyAnimalnamingT)/9.
EXECUTE.


COMPUTE NPsCOREW2=(W2TMTT + W2BACSSCT + W2HVLTTSUM + W2CPTIPTMEAN + W2GPT（seconds）HandednessT + 
    W2CTT1（seconds）T + W2CTT2（seconds）T + W2PASATCorrectNumbersT)/8.
EXECUTE.


DATASET ACTIVATE DataSet1.
COMPUTE matricsovcompsitew12=(W12TMTT + W12BACSSCT + W12HVLTTSUM + W12WMSIIISST + W12NABT +W12BVMTTSUM + 
    W12MSCEITT + W12CPTIPTMEAN + W12CategoryFluencyAnimalnamingT)/9.
EXECUTE.

COMPUTE NPsCOREW12=(W12TMTT + W12BACSSCT + W12HVLTTSUM + W12CPTIPTMEAN + W12GPT（seconds）HandednessT + 
    W12CTT1（seconds）T + W12CTT2（seconds）T + W12PASATCorrectNumbersT)/8.
EXECUTE.


DATASET ACTIVATE DataSet1.
COMPUTE matricsovcompsitew24=(W24TMTT + W24BACSSCT + W24HVLTTSUM + W24WMSIIISST + W24NABT +W24BVMTTSUM + 
    W24MSCEITT + W24CPTIPTMEAN + W24CategoryFluencyAnimalnamingT)/9.
EXECUTE.

COMPUTE NPsCOREW24=(W24TMTT + W24BACSSCT + W24HVLTTSUM + W24CPTIPTMEAN + W24GPT（seconds）HandednessT + 
    W24CTT1（seconds）T + W24CTT2（seconds）T + W24PASATCorrectNumbersT)/8.
EXECUTE.



DATASET ACTIVATE DataSet2.
RECODE W2TMTT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 19=5) 
    (35 thru 39=1) INTO W2TMTTCD.
VARIABLE LABELS  W2TMTTCD 'W2TMTT CODED'.
EXECUTE.

RECODE W2BACSSCT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W2BACSSCTCD.
VARIABLE LABELS  W2BACSSCTCD 'W2BACSSCT CODED'.
EXECUTE.

RECODE W2HVLTTSUM (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W2HVLTTSUMCD.
VARIABLE LABELS  W2HVLTTSUMCD 'W2HVLTTSUM CODED'.
EXECUTE.

RECODE W2CPTIPTMEAN (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W2CPTIPTMEANCD.
VARIABLE LABELS  W2CPTIPTMEANCD 'W2CPTIPTMEAN CODED'.
EXECUTE.

RECODE W2GPT（seconds）HandednessT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) (35 thru 39=1) INTO W2GPTTCD.
VARIABLE LABELS  W2GPTTCD 'W2GPTT CODED'.
EXECUTE.

RECODE W2CTT1（seconds）T (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest 
    thru 19=5) (35 thru 39=1) INTO W2CTT1TCD.
VARIABLE LABELS  W2CTT1TCD 'W2CTT1T CODED '.
EXECUTE.

RECODE W2CTT2（seconds）T (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest 
    thru 19=5) (35 thru 39=1) INTO W2CTT2TCD.
VARIABLE LABELS  W2CTT2TCD 'W2CTT2T CODED'.
EXECUTE.

RECODE W2PASATCorrectNumbersT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) (35 thru 39=1) INTO W2PASATCorrectNumbersTCD.
VARIABLE LABELS  W2PASATCorrectNumbersTCD 'W2PASATCorrectNumbersT CODED'.
EXECUTE.

RECODE W12TMTT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 19=5) 
    (35 thru 39=1) INTO W12TMTTCD.
VARIABLE LABELS  W12TMTTCD 'W12TMTT CODED'.
EXECUTE.

RECODE W12BACSSCT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W12BACSSCTCD.
VARIABLE LABELS  W12BACSSCTCD 'W12BACSSCT CODED'.
EXECUTE.

RECODE W12HVLTTSUM (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W12HVLTTSUMCD.
VARIABLE LABELS  W12HVLTTSUMCD 'W12HVLTTSUM CODED'.
EXECUTE.

RECODE W12CPTIPTMEAN (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W12CPTIPTMEANCD.
VARIABLE LABELS  W12CPTIPTMEANCD 'W12CPTIPTMEAN CODED'.
EXECUTE.

RECODE W12GPT（seconds）HandednessT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) (35 thru 39=1) INTO W12GPTTCD.
VARIABLE LABELS  W12GPTTCD 'W12GPTT (seconds) Handedness CODED'.
EXECUTE.

RECODE W12CTT1（seconds）T (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest 
    thru 19=5) (35 thru 39=1) INTO W12CTT1TCD.
VARIABLE LABELS  W12CTT1TCD 'W12CTT1T CODED'.
EXECUTE.

RECODE W12CTT2（seconds）T (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest 
    thru 19=5) (35 thru 39=1) INTO W12CTT2TCD.
VARIABLE LABELS  W12CTT2TCD 'W12CTT2T CODED'.
EXECUTE.

RECODE W12PASATCorrectNumbersT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) (35 thru 39=1) INTO W12PASATCorrectedNumbrsTCD.
VARIABLE LABELS  W12PASATCorrectedNumbrsTCD 'W12PASATCorrectedNumbersT Coded'.
EXECUTE.

RECODE W24TMTT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 19=5) 
    (35 thru 39=1) INTO W24TMTTCD.
VARIABLE LABELS  W24TMTTCD 'W24TMTT CODED'.
EXECUTE.

RECODE W24BACSSCT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W24BACSSCTCD.
VARIABLE LABELS  W24BACSSCTCD 'W24BACSSCT CODED'.
EXECUTE.

RECODE W24HVLTTSUM (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W24HVLTTSUMCD.
VARIABLE LABELS  W24HVLTTSUMCD 'W24HVLTTSUM CODED'.
EXECUTE.

RECODE W24CPTIPTMEAN (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest thru 
    19=5) (35 thru 39=1) INTO W24CPTIPTMEANDC.
VARIABLE LABELS  W24CPTIPTMEANDC 'W24CPTIPTMEAN CODED'.
EXECUTE.

RECODE W24GPT（seconds）HandednessT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) (35 thru 39=1) INTO W24GPTTCD.
VARIABLE LABELS  W24GPTTCD 'W24GPTT (seconds) Handedness Coded'.
EXECUTE.

RECODE W24CTT1（seconds）T (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest 
    thru 19=5) (35 thru 39=1) INTO W24CTT1TCD.
VARIABLE LABELS  W24CTT1TCD 'W24CTT1T CODED'.
EXECUTE.

RECODE W24CTT2（seconds）T (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) (Lowest 
    thru 19=5) (35 thru 39=1) INTO W24CTT2TCD.
VARIABLE LABELS  W24CTT2TCD 'W24CTT2T CODED'.
EXECUTE.

RECODE W24PASATCorrectNumbersT (39 thru Highest=0) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) (35 thru 39=1) INTO W24PASATCorrectNumbersTCD.
VARIABLE LABELS  W24PASATCorrectNumbersTCD 'W24PASATCorrectedNumbersT'.
EXECUTE.


