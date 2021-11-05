```{r DataNameResponseNameNormality}
library(nortest)
Results = matrix(0, nrow=6, ncol=2)
dimnames(Results) = list(c("Shapiro-Wilk", "Anderson-Darling", "Cramer-von Mises",
"Lilliefors (Kolmogorov-Smirnov)", "Pearson chi-square", "Shapiro-Francia"), c("Statistic", "P Value"))
 SW =shapiro.test(ResponseName)
Results[1,] = c(SW$statistic, SW$p.value)
AD = ad.test(ResponseName)
Results[2,] = c(AD$statistic, AD$p.value)
CV = cvm.test(ResponseName)
Results[3,] = c(CV$statistic, CV$p.value)
LI = lillie.test(ResponseName)
Results[4,] = c(LI$statistic, LI$p.value)
PE = pearson.test(ResponseName)
Results[5,] = c(PE$statistic, PE$p.value)
SF = sf.test(ResponseName)
Results[6,] = c(SF$statistic, SF$p.value)
Results %>% kable(caption="Normality tests for ResponseName.")
```
