
VI = function(x, Describe=FALSE, ...) {
       UseMethod("VI")
     }

print.VI = function(x, ...){
cat(x, sep="\n")
return(invisible(x))
}


VI.default =
    function(x, Describe=FALSE, ...) {
      message("There is no specific method written for  this type of object.\n")
      message("You might try to use the print() function on the object or the str() command to investigate its contents.\n")
      print(x)
    }



VI.boxplot =
    function(x, Describe=FALSE, ...) {
x=Augment(x)
      cat(paste0(
              'This graph has ', x$Boxplots, ' printed ', x$VertHorz,
              '\n', ifelse(length(x$ExtraArgs$main) > 0, 'with the title: ',
                           'but has no title'), x$ExtraArgs$main, '\n',
              ifelse(length(x$ExtraArgs$xlab) > 0, InQuotes(x$ExtraArgs$xlab), 'No label'),
              ' appears on the x-axis.\n',
              ifelse(length(x$ExtraArgs$ylab) > 0, paste0('"', x$ExtraArgs$ylab, '"'), 'No label'),
              ' appears on the y-axis.\n'))
      if (x$horizontal) {
        cat("Tick marks for the x-axis are at:", .GetAxisTicks(x$par$xaxp), "\n")
      } else {
        cat("Tick marks for the y-axis are at:", .GetAxisTicks(x$par$yaxp), "\n")
      }
      for (i in 1:x$NBox) {
        cat(x$VarGroupUpp, x$names[i], 'has', x$n[i], 'values.\n')
        if (any(x$group == i)) {
          cat('An outlier is marked at:', x$out[which(x$group == i)], '\n')
        } else {
          cat('There are no outliers marked for this', x$VarGroup, '\n')
        }
        cat('The whiskers extend to', x$stats[1, i], 'and', x$stats[5, i],
            'from the ends of the box, \nwhich are at', x$stats[2, i], 'and',
            x$stats[4, i], '\n')
        BoxLength = x$stats[4, i] - x$stats[2, i]
        cat('The median,', x$stats[3, i], 'is',
            round(100 * (x$stats[3, i] - x$stats[2, i]) / BoxLength, 0),
            '% from the', ifelse(x$horizontal, 'left', 'lower'),
            'end of the box to the', ifelse(x$horizontal, 'right', 'upper'),
            'end.\n')
        cat('The', ifelse(x$horizontal, 'right', 'upper'), 'whisker is',
            round((x$stats[5, i] -
                   x$stats[4, i]) / (x$stats[2, i] - x$stats[1, i]), 2),
            'times the length of the', ifelse(x$horizontal, 'left', 'lower'),
            'whisker.\n')
      }
      cat('\n')
    }

VI.data.frame =
    function(x, Describe=FALSE, ...) {
      ThisDF = x
      cat("\nThe summary of each variable is\n")
      with(ThisDF, {
                     for (i in names(ThisDF)) {
                       cat(paste(i, ": ", sep = ""))
                       Wanted = summary(get(i))
                       cat(paste(names(Wanted), Wanted, " "))
                       cat("\n")
                     }
                   })  # closure of the with command
      cat("\n")
    }

VI.dotplot =
    function(x, Describe=FALSE, ...) {
      MinVal = min(unlist(x$vals))
      MaxVal = max(unlist(x$vals))
      Bins = getOption("BrailleR.DotplotBins")
      Cuts = seq(MinVal, MaxVal, (MaxVal - MinVal) / Bins)
      # now do the description bit
      cat(paste0('This graph has ', x$dotplots, ' printed ', x$VertHorz, '\n',
                 ifelse(length(x$ExtraArgs$main) > 0, 'with the title: ',
                        'but has no title'), x$ExtraArgs$main, '\n'))
      if (!is.null(x$ExtraArgs$dlab) | !is.null(x$ExtraArgs$glab)) {
        warning(
            "Use of dlab or glab arguments is not advised. Use xlab and ylab instead.")
      } else {
        cat(paste0(ifelse(length(x$ExtraArgs$xlab) > 0, InQuotes(x$ExtraArgs$xlab), 'No label'),
                   ' appears on the x-axis.\n',
                   ifelse(length(x$ExtraArgs$ylab) > 0, paste0('"', x$ExtraArgs$ylab, '"'),
                          'No label'), ' appears on the y-axis.\n'))
      }
      if (x$vertical) {
        cat("Tick marks for the y-axis are at:", .GetAxisTicks(x$par$yaxp), "\n")
      } else {
        cat("Tick marks for the x-axis are at:", .GetAxisTicks(x$par$xaxp), "\n")
      }
      cat(paste("the data that range from", MinVal, "to", MaxVal,
                "has been broken into", Bins, "bins.\nThe counts are:\n"))
      for (i in 1:x$NPlot) {
        cat(paste0(names(x$vals)[i], ": "))
        cat(graphics::hist(x$vals[[i]], breaks = Cuts, plot = FALSE)$counts,
            "\n")
      }
      return(invisible(NULL))
    }


VI.histogram =
    function(x, Describe=FALSE, ...) {
      cat(paste0('This is a histogram, with the title: ',
          ifelse(length(x$ExtraArgs$main) > 0, x$ExtraArgs$main, paste("Histogram of", x$xname)),
          '\n', ifelse(length(x$ExtraArgs$xlab) > 0, InQuotes(x$ExtraArgs$xlab), InQuotes(x$xname)),
          ' is marked on the x-axis.\n'))
      cat("Tick marks for the x-axis are at:", .GetAxisTicks(x$par$xaxp), "\n")
      cat('There are a total of', sum(x$counts),
          'elements for this variable.\n')
      cat("Tick marks for the y-axis are at:", .GetAxisTicks(x$par$yaxp), "\n")
      NoBins = length(x$breaks) - 1
      if (x$equidist) {
        cat('It has', NoBins, 'bins with equal widths, starting at',
            x$breaks[1], 'and ending at', x$breaks[NoBins + 1], '.\n')
        cat('The mids and counts for the bins are:')
        cat(paste0("\nmid = ", x$mids, "  count = ", x$counts))
      } else {
        cat('The', NoBins, 'bins have unequal bin sizes.\n')
        cat('The intervals and densities for the bins are:')
        cat(paste("\nFor the bin from ", x$breaks[1:NoBins], " to ",
                  x$breaks[-1], "the density is ", x$density, sep = ""))
      }
      cat("\n")
    }


VI.htest = function (x, Describe=FALSE, digits = getOption("digits"),  ...) 
{
    cat("\n")
    cat(strwrap(x$method ), sep = "\n")
    if (!is.null(x$statistic)) 
cat(paste("\n", names(x$statistic), "=", format(x$statistic, 
            digits = max(1L, digits - 2L))))
    if (!is.null(x$parameter)) 
cat(paste("\n", names(x$parameter), "=", format(x$parameter, 
            digits = max(1L, digits - 2L))))
    if (!is.null(x$p.value)) {
        fp <- format.pval(x$p.value, digits = max(1L, digits - 
            3L))
cat(paste("\n", "p-value", if (substr(fp, 1L, 1L) == 
            "<") fp else paste("=", fp)))
    }


    if (!is.null(x$conf.int)) {
cat("\n\n")
        cat(format(100 * attr(x$conf.int, "conf.level")), " percent confidence interval:\n", 
            " ", paste(format(x$conf.int[1:2], digits = digits), 
                collapse = " "), sep = "")
    }
    cat("\n\n")
    invisible(x)
}



VI.list =
    function(x, Describe=FALSE, ...) {
      cat("No VI method has yet been written for this type of object so it has been printed for you in its entirety.\n")
      print(x)
    }


VI.lm =
    function(x, Describe=FALSE, ...) {
      ModelName <- match.call(expand.dots = FALSE)$x
      FolderName = paste0(ModelName, ".Validity")
      RmdName = paste0(FolderName, ".Rmd")
      TitleName =
          paste0(
              'Checking validity for the model "', ModelName,
              '" by way of standardised residuals, leverages, and Cook\'s distances
```{r GetVars, echo=FALSE}
Residuals=rstudent(',
              ModelName, ')
Fits= fitted(', ModelName,
              ')
Leverages= hatvalues(', ModelName, ')
Cooks= cooks.distance(',
              ModelName, ')
```   ')

      Residuals = rstudent(x)

      UniDesc(
          Residuals, Title = TitleName, Filename = RmdName, Folder = FolderName,
          Process = FALSE, VI = TRUE, Latex = FALSE, View = FALSE)

      cat(paste0(
              '## Regression diagnostic plots
### Standardised residuals

```{r Fits, fig.cap="Standardised residuals plotted against fitted values"}
plot(Fits, Residuals)
WhereXY(Fits, Residuals, yDist="normal")
```

```{r Order, fig.cap="Standardised residuals plotted against order"}
plot(Residuals)
WhereXY(1:length(Residuals), Residuals, yDist="normal")
```

```{r Lag1Resids, fig.cap="standardised residuals plotted against lagged residuals"}
n = length(Residuals)
plot(Residuals[-n], Residuals[-1], ylab= paste("Residuals 2 to", n), xlab=paste("Residuals 1 to",(n-1)))
WhereXY(Residuals[-n], Residuals[-1], xDist="normal")
```
The lag 1 autocorrelation of the standardised residuals is `r cor(Residuals[-n], Residuals[-1])`.

### Influence

```{r Leverages, fig.cap="Standardised residuals plotted against leverages"}
plot(Leverages, Residuals)
WhereXY(Leverages, Residuals, yDist="normal")
```

`r sum(Leverages>2*mean(Leverages))` points have excessive leverage.
`r sum(Cooks>1)` points have Cook\'s distances greater than one.

### Outliers and influential observations

```{r ListInfObs}
InflObs = data.frame(',
              ModelName,
              '$model, Fit=Fits, St.residual=Residuals, Leverage=Leverages, Cooks.distance=Cooks)[abs(Residuals)>2 | Cooks > 1 | Leverages > 2*mean(Leverages) , ]
```

```{r ListInfObsLatex, purl=FALSE}
library(xtable)
print(xtable(InflObs, caption="Listing of suspected outliers and influential observations.", label="InflObs',
              ModelName, '", digits=4), file = "', FolderName,
              '/Influential.tex")
```

```{r ListInfObsKabled, results="asis", purl=FALSE}
kable(InflObs)
```   \n\n'),
          file = RmdName, append = TRUE)

      # stop writing markdown and process the written file into html and an R script
      knit2html(RmdName, quiet = TRUE,
                stylesheet = FindCSSFile(getOption("BrailleR.Style")))
      file.remove(sub(".Rmd", ".md", RmdName))
      purl(RmdName, quiet = TRUE)
      if (getOption("BrailleR.View")) browseURL(sub(".Rmd", ".html", RmdName))

      # do the clean up
      #rm(list=c("Residuals", "Fits", "Leverages", "Cooks"), envir=.GlobalEnv)
      return(invisible(TRUE))
    }

VI.matrix = function(x, Describe=FALSE, ...) {
              VI(as.data.frame.matrix(x), Describe=Describe, ...)
            }

VI.tsplot =
    function(x, Describe=FALSE, ...) {
      x
    }
