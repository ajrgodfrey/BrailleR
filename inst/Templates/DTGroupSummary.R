require(data.table)
DataSummary = as.data.table(DataName)[, list(Mean = mean(ResponseName, na.rm=T), StdDev = sd(ResponseName, na.rm=T), N=sum(!is.na(ResponseName)) ), FactorSet] 
DataSummary$"Standard Error" =  DataSummary$StdDev/sqrt(DataSummary$N)

