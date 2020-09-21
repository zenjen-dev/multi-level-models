* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
RECODE W2TMTT (39 thru Highest=0) (35 thru 38=1) (30 thru 34=2) (25 thru 29=3) (20 thru 24=4) 
    (Lowest thru 19=5) INTO W2TMTTCD.
VARIABLE LABELS  W2TMTTCD 'W2TMTT CODED'.
EXECUTE.
