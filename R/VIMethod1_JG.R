
VI = function(x) {
       UseMethod("VI")
     }

VI.default =
    function(x) {
      cat("There is no specific method written for  this type of object.\n")
      cat("You might try to use the print() function on the object or the str() command to investigate its contents.\n")
      print(x)
    }



VI.boxplot =
    function(x) {
      NBox = length(x$n)
      VarGroup = ifelse(NBox > 1, 'group', 'variable')
      VarGroupUpp = ifelse(NBox > 1, 'Group', 'This variable')
      IsAre = ifelse(NBox > 1, 'are', 'is')
      Boxplots = ifelse(NBox > 1, paste(NBox, 'boxplots'), 'a boxplot')
      VertHorz = ifelse(x$horizontal, 'horizontally', 'vertically')
      if (NBox > 1) {
        x$names = paste0('"', x$names, '"')
      } else {
        x$names = NULL
      }
      cat(paste0(
              'This graph has ', Boxplots, ' printed ', VertHorz,
              '\n', ifelse(length(x$main) > 0, 'with the title: ',
                           'but has no title'), x$main, '\n',
              ifelse(length(x$xlab) > 0, InQuotes(x$xlab), 'No label'),
              ' appears on the x-axis.\n',
              ifelse(length(x$ylab) > 0, paste0('"', x$ylab, '"'), 'No label'),
              ' appears on the y-axis.\n'))
      if (x$horizontal) {
        cat("Tick marks for the x-axis are at:", GetAxisTicks(x$xaxp), "\n")
      } else {
        cat("Tick marks for the y-axis are at:", GetAxisTicks(x$yaxp), "\n")
      }
      for (i in 1:NBox) {
        cat(VarGroupUpp, x$names[i], 'has', x$n[i], 'values.\n')
        if (any(x$group == i)) {
          cat('An outlier is marked at:', x$out[which(x$group == i)], '\n')
        } else {
          cat('There are no outliers marked for this', VarGroup, '\n')
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
    function(x, ...) {
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
    function(x) {
      NPlot = length(x$vals)
      VarGroup = ifelse(NPlot > 1, 'group', 'variable')
      VarGroupUpp = ifelse(NPlot > 1, 'Group', 'This variable')
      IsAre = ifelse(NPlot > 1, 'are', 'is')
      dotplots = ifelse(NPlot > 1, paste(NPlot, 'dotplots'), 'a dotplot')
      VertHorz = ifelse(x$vertical, 'vertically', 'horizontally')
      MinVal = min(unlist(x$vals))
      MaxVal = max(unlist(x$vals))
      Bins = getOption("BrailleR.DotplotBins")
      Cuts = seq(MinVal, MaxVal, (MaxVal - MinVal) / Bins)
      # now do the description bit
      cat(paste0('This graph has ', dotplots, ' printed ', VertHorz, '\n',
                 ifelse(length(x$main) > 0, 'with the title: ',
                        'but has no title'), x$main, '\n'))
      if (!is.null(x$dlab) | !is.null(x$glab)) {
        warning(
            "Use of dlab or glab arguments is not advised. Use xlab and ylab instead.")
      } else {
        cat(paste0(ifelse(length(x$xlab) > 0, InQuotes(x$xlab), 'No label'),
                   ' appears on the x-axis.\n',
                   ifelse(length(x$ylab) > 0, paste0('"', x$ylab, '"'),
                          'No label'), ' appears on the y-axis.\n'))
      }
      if (x$vertical) {
        cat("Tick marks for the y-axis are at:", GetAxisTicks(x$yaxp), "\n")
      } else {
        cat("Tick marks for the x-axis are at:", GetAxisTicks(x$xaxp), "\n")
      }
      cat(paste("the data that range from", MinVal, "to", MaxVal,
                "has been broken into", Bins, "bins.\nThe counts are:\n"))
      for (i in 1:NPlot) {
        cat(paste0(names(x$vals)[i], ": "))
        cat(graphics::hist(x$vals[[i]], breaks = Cuts, plot = FALSE)$counts,
            "\n")
      }
      return(invisible(NULL))
    }


VI.histogram =
    function(x) {
      cat(paste0('This is a histogram, with the title: ',
          ifelse(length(x$main) > 0, x$main, paste("Histogram of", x$xname)),
          '\n', ifelse(length(x$xlab) > 0, InQuotes(x$xlab), InQuotes(x$xname)),
          ' is marked on the x-axis.\n'))
      cat("Tick marks for the x-axis are at:", GetAxisTicks(x$xaxp), "\n")
      cat('There are a total of', sum(x$counts),
          'elements for this variable.\n')
      cat("Tick marks for the y-axis are at:", GetAxisTicks(x$yaxp), "\n")
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




VI.list =
    function(x) {
      cat("No VI method has yet been written for this type of object so it has been printed for you in its entirety.\n")
      print(x)
    }


VI.lm =
    function(x) {
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

VI.matrix = function(x, ...) {
              VI(as.data.frame.matrix(x), ...)
            }

