DataName.aov1 <- aov(ResponseName ~ SubjectName + PeriodName + TreatmentName, data=DataName)
summary(DataName.aov <- aov(ResponseName ~ GroupName + PeriodName + TreatmentName + Error(SubjectName), data=DataName))
par(mfrow=c(2,2))
plot(DataName.aov1)
