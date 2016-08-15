VI.aov <- function(x)  # Last Edited: 18/02/15
    {
  GroupL <- interaction(x$model[, -1], sep = ":")
  FNames = attr(x$terms, 'term.labels')
  for (Factor in FNames) {
    cat("\nThe p value for", Factor, "is",
        round(anova(x)[which(FNames == Factor), 5], 4))
  }
  cat("\n\nThe ratios of the group standard deviations to the overall standard deviation \n",
      "(groups ordered by increasing mean) are:\n",
      round(tapply(x$residuals, GroupL, sd) /
            sqrt(sum(x$residuals ^ 2) / x$df.residual), 2))
  cat("\n  \n")
  return(invisible(NULL))
}

VI.summary.lm <- function(x) {
  CoeTable <- x$coe  # Gives us the table

  # Check if intercept has been fitted
  if (row.names(CoeTable)[1] == "(Intercept)") {
    IsInter = 1
  } else {
    IsInter = 0
  }

  # Determine the significance of each model term
  SigPValues <- numeric(nrow(CoeTable) - IsInter)
  for (Term in 1:length(SigPValues)) {
    if (CoeTable[Term + IsInter, 4] <= 0.01) {
      SigPValues[Term] = 0.01
    } else if (CoeTable[Term + IsInter, 4] <= 0.05) {
      SigPValues[Term] = 0.05
    } else if (CoeTable[Term + IsInter, 4] <= 0.1) {
      SigPValues[Term] = 0.1
    }
  }

  # For each significant term, make statement about it.
  for (SigLevel in c(0.01, 0.05, 0.1)) {
    SigTerms <- which(SigPValues == SigLevel)
    if (length(SigTerms) != 0) {
      cat('The', ifelse(length(SigTerms) == 1, " term which is ",
                        " terms which are;"), 'significant to ', SigLevel * 100,
          ifelse(length(SigTerms) == 1, "% is", "% are"), '\n', sep = "")
      for (Term in 1:length(SigTerms)) {
        Index = SigTerms[Term] + IsInter
        cat(row.names(CoeTable)[Index], 'with an estimate of',
            CoeTable[Index, 1], 'and P-Value of', CoeTable[Index, 4], '\n')
      }
      cat('\n')
    }
  }

  # State which terms are not significant to 10%.
  NonSigTerms <- which(SigPValues == 0)
  if (length(NonSigTerms) != 0) {
    if (length(NonSigTerms) == 1) {
      cat('The term', row.names(CoeTable)[NonSigTerms + IsInter],
          'is not significant to 10%.')
    } else {
      NoOfTerms <- length(NonSigTerms)
      cat('The terms',
          paste(row.names(CoeTable)[NonSigTerms[1:(NoOfTerms - 1)] + IsInter],
                collapse = ", "), 'and',
          row.names(CoeTable)[NonSigTerms[NoOfTerms] + IsInter],
          'are not significant to 10%.')
    }
  }
}



VI.TukeyHSD <- function(x)  # Last Edited: 25/02/15
    {
  CI <- attr(x, 'conf.level')
  for (Comparison in 1:length(x)) {
    CTable = x[[names(x)[Comparison]]]
    SignPValues = (CTable[, 4] <= (1 - CI))
    if (any(SignPValues == TRUE)) {
      cat("For term ", names(x)[Comparison],
          " the comparisons which are significant at ", (1 - CI) * 100,
          "% are:\n", sep = "")
      for (DRow in 1:length(SignPValues)) {
        if (SignPValues[DRow] == TRUE) {
          SComp = strsplit(rownames(CTable)[DRow], "-")[[1]]
          cat(SComp[1], "and", SComp[2], "with a difference of",
              round(CTable[DRow, 1], 2), "and P-value of",
              round(CTable[DRow, 4], 4), "\n")
        }
      }
    } else {
      cat("For term ", names(x)[Comparison],
          " there are no comparisons significant at ", (1 - CI) * 100, "%\n",
          sep = "")
    }
    cat("\n")
  }
  return(invisible(NULL))
}
