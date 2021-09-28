DataName.lm = lm(ResponseName~BlockingName+FactorName, data = DataName)
anova(DataName.lm)
library(ggfortify)
autoplot(DataName.lm)
