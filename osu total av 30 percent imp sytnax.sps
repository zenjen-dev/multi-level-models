* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
COMPUTE osutotavimpperv1=averagediffv1mb / Baselineaverage.
EXECUTE.

COMPUTE osutotavimpperv2=averagediffV2mb / Baselineaverage.
EXECUTE.

COMPUTE osutotavimpperv3=averagediffV3mb / Baselineaverage.
EXECUTE.

RECODE osutotavimpperv1 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osuav30pcv1.
VARIABLE LABELS  osuav30pcv1 'osu av 30 per dec'.
EXECUTE.

RECODE osutotavimpperv2 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osu30imv2.
VARIABLE LABELS  osu30imv2 'osu 30 pc imporv v2'.
EXECUTE.

RECODE osutotavimpperv3 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osutotav30impvecdv3.
VARIABLE LABELS  osutotav30impvecdv3 'osu tot av 30 imp cd v3'.
EXECUTE.
