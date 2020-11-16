* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.

* OSU SUBSCALE IMPAIRED SOCIAL. 
COMPUTE osuimpairsoctotavimpperv1=impaieedsocialinteractionavdiffv1mb / impairedsocialinteractionBaselineaverage.
EXECUTE.

COMPUTE osuimpairsoctotavimpperv2=impaieedsocialinteractionavdiffV2mb / impairedsocialinteractionBaselineaverage.
EXECUTE.

COMPUTE osuimpairsoctotavimpperv3=impaieedsocialinteractionavdiffV3mb / impairedsocialinteractionBaselineaverage.
EXECUTE.

RECODE osuimpairsoctotavimpperv1 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osuimpsocav30pcv1.
VARIABLE LABELS  osuimpsocav30pcv1 'osu imp soc av 30 per dec'.
EXECUTE.

RECODE osuimpairsoctotavimpperv2 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osuimpsocav30imv2.
VARIABLE LABELS  osuimpsocav30imv2 'osu imp soc 30 pc imporv v2'.
EXECUTE.

RECODE osuimpairsoctotavimpperv3 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osuimpsocav30impvecdv3.
VARIABLE LABELS  osuimpsocav30impvecdv3 'osu imp soc av 30 imp cd v3'.
EXECUTE.

* OSU SUBSCALE STEREOTYPED BEHAVIORS, 5 subjects with zero (.00) baseline average.
COMPUTE osustereotypavimpperv1=Stereotypesmodelavdiffv1mb / StereotypesmodelBaselineaverage.
EXECUTE.

COMPUTE osustereotypavimpperv2=StereotypesmodelavdiffV2mb / StereotypesmodelBaselineaverage.
EXECUTE.

COMPUTE osustereotypavimpperv3=StereotypesmodelavdiffV3mb / StereotypesmodelBaselineaverage.
EXECUTE.

RECODE osuimpairsoctotavimpperv1 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osustereotypav30pcv1.
VARIABLE LABELS  osustereotypav30pcv1 'osu stereotyp behaviors av 30 per dec'.
EXECUTE.

RECODE osuimpairsoctotavimpperv2 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osustereotypav30imv2.
VARIABLE LABELS  osustereotypav30imv2 'osu stereotyp behaviors 30 pc imporv v2'.
EXECUTE.

RECODE osuimpairsoctotavimpperv3 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osustereotypav30impvecdv3.
VARIABLE LABELS  osustereotypav30impvecdv3 'stereotyp behaviors soc av 30 imp cd v3'.
EXECUTE.

* OSU SUBSCALE COMMUNICATION BARRIERS.
COMPUTE osucommbarriersavimpperv1=communicationbarriersavdiffv1mb / communicationbarriersBaselineaverage.
EXECUTE.

COMPUTE osucommbarriersavimpperv2=communicationbarriersavdiffv2mb / communicationbarriersBaselineaverage.
EXECUTE.

COMPUTE osucommbarrierspavimpperv3=communicationbarriersavdiffv3mb / communicationbarriersBaselineaverage.
EXECUTE.

RECODE osucommbarriersavimpperv1 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osucommbarrav30pcv1.
VARIABLE LABELS  osucommbarrav30pcv1 'osu comm barriers av 30 per dec'.
EXECUTE.

RECODE osucommbarriersavimpperv2 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osucommbarrav30imv2.
VARIABLE LABELS  osucommbarrav30imv2 'osu comm barriers 30 pc imporv v2'.
EXECUTE.

RECODE osucommbarrierspavimpperv3 (Lowest thru -.30=1) (-.29 thru Highest=0) INTO osucommbarrav30impvecdv3.
VARIABLE LABELS  osucommbarrav30impvecdv3 'osu comm barriers av 30 imp cd v3'.
EXECUTE.
