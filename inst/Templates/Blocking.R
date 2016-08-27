DataName.aov = aov(ResponseName~BlockingName+FactorName, data = DataName)
summary(DataName.aov)
par(mfrow=c(2,2))
plot(DataName.aov)

model.tables(DataName.aov)
model.tables(DataName.aov, type="means")

DataName.hsd = TukeyHSD(DataName.aov, "FactorName")
DataName.hsd
plot(DataName.hsd)
