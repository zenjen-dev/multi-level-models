* Encoding: UTF-8.

DATASET ACTIVATE DataSet36.
COMPUTE StroopWordTW12W2DIFF=W12StroopWordT - W2StroopWordT.
EXECUTE.

COMPUTE StroopWordTW24W2DIFF=W24StroopWordT - W2StroopWordT.
EXECUTE.

COMPUTE StroopColorTW12W2DIFF=W12StroopColorT - W2StroopColorT.
EXECUTE.

COMPUTE StroopColorTW24W2DIFF=W24StroopColorT - W2StroopColorT.
EXECUTE.

COMPUTE WCST_RawscoresTotalErrorsTW12W2DIFF=
    W12WCST_RawscoresTotalerrorsT-W2_WCST_RawscoresTotalErrorsT.
EXECUTE.

COMPUTE WCST_RawscoresTotalErrorsTW24W2DIFF=
    W24_WCST_RawscoresTotalErrorsT-W2_WCST_RawscoresTotalErrorsT.
EXECUTE.

COMPUTE WCST_RawscoresPerseverativeResponsesTW12W2DIFF=
    W12WCST_RawscoresPerseverativeResponsesT-W2_WCST_RawscoresPerseverativeResponsesT.
EXECUTE.


COMPUTE WCST_RawscoresPerseverativeResponsesTW24W2DIFF=
    W24_WCST_RawscoresPerseverativeResponsesT-W2_WCST_RawscoresPerseverativeResponsesT.
EXECUTE.


COMPUTE WCST_RawscoresPerseverativeErrorsTW12W2DIFF=
    W12_WCST_RawscoresPerseverativeErrorsT-W2_WCST_RawscoresPerseverativeErrorsT.
EXECUTE.

COMPUTE WCST_RawscoresPerseverativeErrorsTW24W2DIFF=
    W24_WCST_RawscoresPerseverativeErrorsT-W2_WCST_RawscoresPerseverativeErrorsT.
EXECUTE.

COMPUTE GPTsecondsNonHandednessTW12W2DIFF=
    W12GPT（seconds）NonHandednessT-W2GPT（seconds）NonHandednessT.
EXECUTE.

COMPUTE GPTsecondsNonHandednessTW24W2DIFF=W24GPTsecondsNonHandednessT-W2GPT（seconds）NonHandednessT.
EXECUTE.

COMPUTE CategoryFluencyActionNamingTW12W2DIFF=
    W12CategoryFluencyactionnamingT-W2CategoryFluencyactionnamingT.
EXECUTE.

COMPUTE CategoryFluencyActionNamingTW24W2DIFF=
    W24CategoryFluencyactionnamingT-W2CategoryFluencyactionnamingT.
EXECUTE.


