## Last Edited: 30/08/16

ThreeFactors =
    function(Response, Factor1, Factor2, Factor3, Data = NULL,
             Filename = NULL, Folder = NULL, VI = getOption("BrailleR.VI"),
             Latex = getOption("BrailleR.Latex"),
             View = getOption("BrailleR.View"), Modern=TRUE) {

      # Check inputs are right form
      if (length(Response) == 1) {
        if (is.character(Response)) {
          ResponseName = Response
        }
      } else {
        ResponseName = as.character(match.call()$Response)
      }
      if (length(Factor1) == 1) {
        if (is.character(Factor1)) {
          Factor1Name = Factor1
        }
      } else {
        Factor1Name = as.character(match.call()$Factor1)
      }
      if (length(Factor2) == 1) {
        if (is.character(Factor2)) {
          Factor2Name = Factor2
        }
      } else {
        Factor2Name = as.character(match.call()$Factor2)
      }
      if (length(Factor3) == 1) {
        if (is.character(Factor3)) {
          Factor3Name = Factor3
        }
      } else {
        Factor3Name = as.character(match.call()$Factor3)
      }
      if (is.null(Data)) {
        Data = data.frame(get(ResponseName), get(Factor1Name), get(Factor2Name), get(Factor3Name))
        names(Data) = c(ResponseName, Factor1Name, Factor2Name, Factor3Name)
        DataName = paste0(ResponseName, ".And3Factors")
        assign(DataName, Data,
               envir = parent.frame())
      } else {
        if (length(Data) == 1) {
          if (is.character(Data)) {
            DataName = Data
          }
          Data = get(DataName)
        } else {
          DataName = as.character(match.call()$Data)
        }
        if (!is.data.frame(Data)) .NotADataFrame()
      }

      with(
          Data,
          {
            if (!is.numeric(get(ResponseName)))
              .ResponseNotNumeric()
            if (!is.vector(get(ResponseName)))
              .ResponseNotAVector()
            if (!is.factor(get(Factor1Name)))
              .FactorNotFactor(which="first")
            if (!is.factor(get(Factor2Name)))
              .FactorNotFactor(which="second")
            if (!is.factor(get(Factor3Name)))
              .FactorNotFactor(which="third")
          })  # end data checking

      # create folder and filenames
      if (is.null(Folder)) Folder = DataName
      if (Folder != "" & !file.exists(Folder)) dir.create(Folder)
      if (is.null(Filename))
        Filename =
            paste0(DataName, ".Rmd")


      # start writing to the R markdown file for all three factors
      cat(paste0('# Analysis of the ', DataName, ' data, using ', ResponseName,
                 ' as the response variable and the variables ', Factor1Name,
                 ', ', Factor2Name,
                 ', and ', Factor3Name,
                 ' as factors.
#### Prepared by ',
                 getOption("BrailleR.Author"), '  \n\n'), file = Filename)

      cat(paste0(
              '```{r setup, include=FALSE}
',
              ifelse(VI, "library(BrailleR)", ""),
              ifelse(Modern, "\nlibrary(tidyverse)\nlibrary(ggfortify)", ""),
              '
knitr::opts_chunk$set(dev=c("png", "pdf", "postscript", "svg"))
knitr::opts_chunk$set(echo=FALSE, comment="", fig.path="',
              Folder, '/', ResponseName, '.', Factor1Name, '.', Factor2Name,
              '-", fig.width=7)
```

## Group summaries

```{r NewFunction}  \n', 
paste(readLines(system.file("Templates/nNonMissing.R", package="BrailleR")), collapse="\n"), 
'\n```

```{r All3GroupSummary}
Data.Mean <- aggregate(', ResponseName, ', list(',
              Factor1Name, ', ', Factor2Name, ', ', Factor3Name,
              '), mean, na.rm=TRUE)
colnames(Data.Mean) = c("', Factor1Name,
              '","', Factor2Name, '","', Factor3Name, '","Mean")
Data.StDev <- aggregate(',
              ResponseName, ', list(', Factor1Name, ', ', Factor2Name, ', ', Factor3Name,
              '), sd, na.rm=TRUE)
Data.n <- aggregate(',
              ResponseName, ', list(', Factor1Name, ', ', Factor2Name,', ', Factor3Name,
              '), nNonMissing)
Data.StdErr = Data.StDev[,4]/sqrt(Data.n[,4])
DataSummary = cbind(Data.Mean, Data.StDev[,4], Data.n[,4], Data.StdErr)
colnames(DataSummary) = c("',
              Factor1Name, ' Level", "', Factor2Name, ' Level", "', Factor3Name,
              ' Level", "Mean", "Standard deviation", "n", "Standard error")
```

The ratio of the largest group standard deviation to the smallest is `r round(max(Data.StDev[,4])/min(Data.StDev[,4]),2)`

```{r PrintSummary, results="asis", purl=FALSE}
kable(as.matrix(DataSummary), row.names=FALSE)
```  \n\n'),
          file = Filename, append = TRUE)

      if (Latex) {
        cat(paste0(
                '```{r DataSummaryTex, purl=FALSE}
library(xtable)
ThisTexFile = "',
                Folder, '/', ResponseName, '.', Factor1Name, '.', Factor2Name,'.', Factor3Name,
                '-GroupSummary.tex"
TabCapt = "Summary statistics for ',
                ResponseName, ' by level of ', Factor1Name, ', ', Factor2Name, ' and ',
                Factor3Name,
                '"
print(xtable(DataSummary, caption=TabCapt, label="',
                ResponseName,
                'GroupSummary", digits=4, align="lllrrrrr"), include.rownames = FALSE, file = ThisTexFile)
    ```  \n\n'),
            file = Filename, append = TRUE)
      }

# additional testing
cat('```{r DTMeans, message=FALSE}\n', file=Filename, append=TRUE)
cat(UseTemplate("DTGroupSummary.R", 
c("DataName", "ResponseName", "FactorSet"), 
c(DataName, ResponseName, paste0("list(", Factor1Name, ",", Factor2Name, ",", Factor3Name, ")") )), file=Filename, append=TRUE)
cat('```

```{r kableDTMeans, perl=FALSE}
kable(DataSummary)
```\n\n', file=Filename, append=TRUE)

      # start writing to the R markdown file for pairs F1&F2
      cat(paste0('### Group summaries, averaging over ', Factor3Name,'

```{r GroupSummary_', Factor1Name, '_', Factor2Name,'}
Data.Mean <- aggregate(', ResponseName, ', list(',
              Factor1Name, ', ', Factor2Name,
              '), mean, na.rm=TRUE)
colnames(Data.Mean) = c("', Factor1Name,
              '","', Factor2Name, '", "Mean")
Data.StDev <- aggregate(',
              ResponseName, ', list(', Factor1Name, ', ', Factor2Name,
              '), sd, na.rm=TRUE)
Data.n <- aggregate(',
              ResponseName, ', list(', Factor1Name, ', ', Factor2Name,
              '), nNonMissing)
Data.StdErr = Data.StDev[,3]/sqrt(Data.n[,3])
DataSummary = cbind(Data.Mean, Data.StDev[,3], Data.n[,3], Data.StdErr)
colnames(DataSummary) = c("',
              Factor1Name, ' Level", "', Factor2Name,
              ' Level", "Mean", "Standard deviation", "n", "Standard error")
```

The ratio of the largest group standard deviation to the smallest is `r round(max(Data.StDev[,3])/min(Data.StDev[,3]),2)`

```{r PrintSummary_', Factor1Name, '_', Factor2Name,', results="asis", purl=FALSE}
kable(as.matrix(DataSummary), row.names=FALSE)
```  \n\n'),
          file = Filename, append = TRUE)

      if (Latex) {
        cat(paste0(
                '```{r DataSummaryTex_', Factor1Name, '_', Factor2Name,', purl=FALSE}
library(xtable)
ThisTexFile = "',
                Folder, '/', ResponseName, '.', Factor1Name, '.', Factor2Name,
                '-GroupSummary.tex"
TabCapt = "Summary statistics for ',
                ResponseName, ' by level of ', Factor1Name, ' and ',
                Factor2Name,
                '"
print(xtable(DataSummary, caption=TabCapt, label="',
                ResponseName,
                'GroupSummary", digits=4, align="llrrrrr"), include.rownames = FALSE, file = ThisTexFile)
    ```  \n\n'),
            file = Filename, append = TRUE)
      }

      # start writing to the R markdown file for pairs F1&F3
      cat(paste0('### Group summaries, averaging over ', Factor2Name,'

```{r GroupSummary_', Factor1Name, '_', Factor3Name,'}
Data.Mean <- aggregate(', ResponseName, ', list(',
              Factor1Name, ', ', Factor3Name,
              '), mean, na.rm=TRUE)
colnames(Data.Mean) = c("', Factor1Name,
              '","', Factor3Name, '", "Mean")
Data.StDev <- aggregate(',
              ResponseName, ', list(', Factor1Name, ', ', Factor3Name,
              '), sd, na.rm=TRUE)
Data.n <- aggregate(',
              ResponseName, ', list(', Factor1Name, ', ', Factor3Name,
              '), nNonMissing)
Data.StdErr = Data.StDev[,3]/sqrt(Data.n[,3])
DataSummary = cbind(Data.Mean, Data.StDev[,3], Data.n[,3], Data.StdErr)
colnames(DataSummary) = c("',
              Factor1Name, ' Level", "', Factor3Name,
              ' Level", "Mean", "Standard deviation", "n", "Standard error")
```

The ratio of the largest group standard deviation to the smallest is `r round(max(Data.StDev[,3])/min(Data.StDev[,3]),2)`

```{r PrintSummary_', Factor1Name, '_', Factor3Name,', results="asis", purl=FALSE}
kable(as.matrix(DataSummary), row.names=FALSE)
```  \n\n'),
          file = Filename, append = TRUE)

      if (Latex) {
        cat(paste0(
                '```{r DataSummaryTex_', Factor1Name, '_', Factor3Name,', purl=FALSE}
library(xtable)
ThisTexFile = "',
                Folder, '/', ResponseName, '.', Factor1Name, '.', Factor3Name,
                '-GroupSummary.tex"
TabCapt = "Summary statistics for ',
                ResponseName, ' by level of ', Factor1Name, ' and ',
                Factor3Name,
                '"
print(xtable(DataSummary, caption=TabCapt, label="',
                ResponseName,
                'GroupSummary", digits=4, align="llrrrrr"), include.rownames = FALSE, file = ThisTexFile)
    ```  \n\n'),
            file = Filename, append = TRUE)
      }

      # start writing to the R markdown file for pairs F2&F3
      cat(paste0('### Group summaries, averaging over ', Factor1Name,'

```{r GroupSummary_', Factor2Name, '_', Factor3Name,'}
Data.Mean <- aggregate(', ResponseName, ', list(',
              Factor2Name, ', ', Factor3Name,
              '), mean, na.rm=TRUE)
colnames(Data.Mean) = c("', Factor2Name,
              '","', Factor3Name, '", "Mean")
Data.StDev <- aggregate(',
              ResponseName, ', list(', Factor2Name, ', ', Factor3Name,
              '), sd, na.rm=TRUE)
Data.n <- aggregate(',
              ResponseName, ', list(', Factor2Name, ', ', Factor3Name,
              '), nNonMissing)
Data.StdErr = Data.StDev[,3]/sqrt(Data.n[,3])
DataSummary = cbind(Data.Mean, Data.StDev[,3], Data.n[,3], Data.StdErr)
colnames(DataSummary) = c("',
              Factor2Name, ' Level", "', Factor3Name,
              ' Level", "Mean", "Standard deviation", "n", "Standard error")
```

The ratio of the largest group standard deviation to the smallest is `r round(max(Data.StDev[,3])/min(Data.StDev[,3]),2)`

```{r PrintSummary_', Factor2Name, '_', Factor3Name,', results="asis", purl=FALSE}
kable(as.matrix(DataSummary), row.names=FALSE)
```  \n\n'),
          file = Filename, append = TRUE)

      if (Latex) {
        cat(paste0(
                '```{r DataSummaryTex_', Factor2Name, '_', Factor3Name,', purl=FALSE}
library(xtable)
ThisTexFile = "',
                Folder, '/', ResponseName, '.', Factor2Name, '.', Factor3Name,
                '-GroupSummary.tex"
TabCapt = "Summary statistics for ',
                ResponseName, ' by level of ', Factor2Name, ' and ',
                Factor3Name,
                '"
print(xtable(DataSummary, caption=TabCapt, label="',
                ResponseName,
                'GroupSummary", digits=4, align="llrrrrr"), include.rownames = FALSE, file = ThisTexFile)
    ```  \n\n'),
            file = Filename, append = TRUE)
      }

      ######## Fit the anova model

      cat(paste0(
              '## Three-way Analysis of Variance

```{r ThreeWayANOVA}
MyANOVA <- aov(',
              ResponseName, '~', Factor1Name, '*', Factor2Name, '*', 
              Factor3Name, ', data=', DataName, ')
',
              ifelse(VI, "VI(MyANOVA)", ""),
              '
summary(MyANOVA)
```  \n\n'),
          file = Filename, append = TRUE)

      if (Latex) {
        cat(paste0(
                '```{r ANOVA-TEX, purl=FALSE}
library(xtable)
ThisTexFile = "',
                Folder, '/', ResponseName, '-', Factor1Name, '-', Factor2Name,                
                '-ANOVA.tex"
TabCapt = "Two-way ANOVA for ',
                .simpleCap(ResponseName), ' with the group factors ',
                .simpleCap(Factor1Name), ' and ', .simpleCap(Factor2Name),
                '."
print(xtable(MyANOVA, caption=TabCapt, label="',
                ResponseName, '-', Factor1Name,
                '-ANOVA", digits=4), file = ThisTexFile)
```  \n\n'),
            file = Filename, append = TRUE)
      }

      # finish writing markdown and process the written file into html and an R script
      knit2html(Filename, quiet = TRUE, envir=globalenv(),
                stylesheet = FindCSSFile(getOption("BrailleR.Style")))
      file.remove(sub(".Rmd", ".md", Filename))
      purl(Filename, quiet = TRUE, documentation = 0)
      if (View) browseURL(sub(".Rmd", ".html", Filename))
    }  # end of ThreeFactors function
