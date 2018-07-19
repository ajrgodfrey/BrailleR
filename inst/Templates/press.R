


PRESS <- function(LinearModel) {
    return(sum((residuals(LinearModel)/(1 - lm.influence(LinearModel)$hat))^2))
}



PredRSquared <- function(LinearModel) {
    TSS <- sum(anova(LinearModel)$"Sum Sq")
return(1 - PRESS(LinearModel)/TSS)
}

