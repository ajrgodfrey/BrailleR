DataName.aov = aov(ResponseName ~ RowFactor+ColFactor+FactorName, data=DataName)
summary(DataName.aov)
par(mfrow=c(2,2))
plot((DataName.aov)
