with(DataName, tapply(ResponseName, list(PeriodName, GroupName), mean))

summary(ResponseName.aov <- aov(ResponseName ~ GroupName + PeriodName + TreatName + Carry1Name + Error(SubjectName), data=DataName))
summary(ResponseName.aov <- aov(ResponseName ~ GroupName + PeriodName + Carry1Name + TreatName + Error(SubjectName), data=DataName))



