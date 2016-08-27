plot(ResponseName ~ PredictorName, data = DataName, xlab = "Year", ylab = "Speed")
DataName.poly1  <- lm(ResponseName ~ PredictorName, data = DataName)
DataName.poly2 <- lm(ResponseName ~ poly(PredictorName, 2, raw=TRUE), data = DataName)
DataName.poly3 <- lm(ResponseName ~ poly(PredictorName, 3, raw=TRUE), data = DataName)
DataName.poly4 <- lm(ResponseName ~ poly(PredictorName, 4, raw=TRUE), data = DataName)
anova(DataName.poly1, DataName.poly2, DataName.poly3, DataName.poly4)

