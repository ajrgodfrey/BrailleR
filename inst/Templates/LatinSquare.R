DataName.lm = lm(ResponseName ~ RowFactor+ColFactor+FactorName, data=DataName)
anova(DataName.lm)
library(ggfortify)
autoplot((DataName.lm)
