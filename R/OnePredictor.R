## add this back in when the VI.anova() is done
#  ', .ifelse(VI, "VI(", ""), 'anova(', ModelName, .ifelse(VI,")", ""), ')

OnePredictor =
    function(Response, Predictor, Data = NULL, Filename = NULL, Folder = NULL,
             VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"),
             View = getOption("BrailleR.View"), Modern=TRUE) {

      # Need to redefine the environment for VI.lm function
      VI.env <- environment(VI.lm)
      environment(VI.lm) <- environment()

      if (length(Response) == 1) {
        if (is.character(Response)) {
          ResponseName = Response
        }
      } else {
        ResponseName = as.character(match.call()$Response)
      }
      if (length(Predictor) == 1) {
        if (is.character(Predictor)) {
          PredictorName = Predictor
        }
      } else {
        PredictorName = as.character(match.call()$Predictor)
      }

      if (is.null(Data)) {
        Data = data.frame(get(ResponseName), get(PredictorName))
        names(Data) = c(ResponseName, PredictorName)
        DataName = paste0(ResponseName, ".", PredictorName)
        assign(paste0(ResponseName, ".", PredictorName), Data,
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


      if(VI){
        VIOpenText = "VI("
        VICloseText = ")"
        }
      else {
        VIOpenText = ""
        VICloseText = ""
        }


      if(Latex){
        LatexOpenText = "VI("
        LatexCloseText = ")"
        }
      else {
        LatexOpenText = ""
        LatexCloseText = ""
        }

      with(Data, {
                   if (!is.numeric(get(ResponseName)))
                     .ResponseNotNumeric()
                   if (!is.numeric(get(PredictorName)))
                     .PredictorNotNumeric()
                 })  # end data checking

      # create folder and filenames
      if (is.null(Folder)) Folder = DataName
      if (Folder != "" & !file.exists(Folder)) dir.create(Folder)
      if (is.null(Filename)) {
        Filename = paste0(.simpleCap(ResponseName), ".",
                          .simpleCap(PredictorName), "-OnePredictor.Rmd")
      }

      ModelName = paste0(ResponseName, ".", PredictorName, ".lm")

      # start writing to the R markdown file
      cat('# Analysis of the', .simpleCap(DataName), 'data, using',
          .simpleCap(ResponseName), 'as the response variable and',
          .simpleCap(PredictorName),
          'as the single predictor.
#### Prepared by ',
          getOption("BrailleR.Author"), '  \n\n', file = Filename)

      cat(paste0(
              '```{r setup2, purl=FALSE, include=FALSE}
',
              .ifelse(VI, "library(BrailleR)", ""),
              .ifelse(Modern, "\nlibrary(tidyverse)\nlibrary(ggfortify)", ""),
              '
library(knitr)
opts_chunk$set(dev=c("png", "pdf", "postscript", "svg"))
opts_chunk$set(echo=FALSE, comment="", fig.path="',
              Folder, '/', .simpleCap(ResponseName), '.',
              .simpleCap(PredictorName),
              '-", fig.width=7)
```

<!--- IMPORTANT NOTE: This Rmd file does not yet import the data it uses. 
You will need to add a data import command of some description into the next R chunk to use the file as a stand alone file. --->

```{r importData}
```

## Variable summaries

The response variable is ',
              .simpleCap(ResponseName), ' and the predictor variable is ',
              .simpleCap(PredictorName), '.

```{r VariableSummary}
attach(',
              DataName, ')
SummaryResponse <- summary(na.omit(', ResponseName,
              '))
SummaryPredictor <- summary(na.omit(', PredictorName,
              '))
SummaryTable <- cbind(', ResponseName, '=SummaryResponse,',
              PredictorName,
              '=SummaryPredictor)
row.names(SummaryTable) <- c("Minimum","Lower Quartile", "Median","Mean","Upper Quartile","Maximum")
Sds <- c(sd(',
              ResponseName, ', na.rm=T),sd(', PredictorName,
              ', na.rm=T))
Nas <- c(sum(is.na(', ResponseName, ')), sum(is.na(',
              PredictorName,
              ')))
SummaryTable <- rbind(SummaryTable,"Standard Deviation"=Sds,"Missing Values"=Nas)
detach(',
              DataName,
              ')
```

```{r PrintSummary, results="asis", purl=FALSE}
kable(t(SummaryTable), row.names=T, align=rep("c",8))
```  \n\n'),
          file = Filename, append = TRUE)


      if (Latex) {
      }


      cat('## Scatter Plot\n\n', file = Filename, append = TRUE)


ScatterText = .ifelse(Modern, .GetModernStyleScatterText(ResponseName=ResponseName, PredictorName=PredictorName, DataName=DataName),
 .GetOldStyleScatterText(ResponseName=ResponseName, PredictorName=PredictorName, DataName=DataName))
      cat(ScatterText, file = Filename, append = TRUE)

      cat(paste0('## Linear regression

```{r ', ModelName,
              '}
', ModelName,
              ' <- lm(', ResponseName, '~', PredictorName, ', data=', DataName,
              ')
', .ifelse(VI, paste("VI(", ModelName, ")"), ""), '
',
              .ifelse(VI, paste0("VI(summary(", ModelName, "))"), ""),
              '
summary(', ModelName,
              ')
```\n\n'),
          file = Filename, append = TRUE)

FittedText = .ifelse(Modern, .GetModernStyleFittedText(ResponseName=ResponseName, PredictorName=PredictorName, DataName=DataName, ModelName=ModelName),
.GetOldStyleFittedText(ResponseName=ResponseName, PredictorName=PredictorName, DataName=DataName, ModelName=ModelName))
      cat(FittedText, file = Filename, append = TRUE)

ResidualText = .ifelse(Modern, .GetModernStyleResidualText(ModelName=ModelName), .GetOldStyleResidualText(ModelName=ModelName))
      cat(ResidualText, file = Filename, append = TRUE)


      if (VI) {
        cat(paste0(
                'A separate html page showing the residual analysis and model validity checking for ',
                ModelName, ' is at [', ModelName, '.Validity.html](', ModelName,
                '.Validity.html)  \n\n'), file = Filename, append = TRUE)
      }

      cat(paste0('### One-way Analysis of Variance

```{r ANOVA', ModelName, '}
anova(',
              ModelName, ')
```  \n\n'), file = Filename, append = TRUE)

      if (Latex) {
        cat(paste0(
                '```{r VariableSummaryTex, purl=FALSE}
library(xtable)
ThisTexFile = "',
                Folder, '/', .simpleCap(ResponseName), '.',
                .simpleCap(PredictorName),
                '-VariableSummary.tex"
TabCapt = "Summary statistics for variables ',
                .simpleCap(ResponseName), ' and ', .simpleCap(PredictorName),
                '."
print(xtable(t(SummaryTable), caption=TabCapt, label="',
                .simpleCap(ResponseName),
                '-VariableSummary", digits=4, align="lrrrrrrrr"), include.rownames = FALSE, file = ThisTexFile)
```

```{r SimpleLinMod-TEX, purl=FALSE}
ThisTexFile = "', Folder,
                '/', .simpleCap(ResponseName), '-', .simpleCap(PredictorName),
                '-lm.tex"
TabCapt = "Linear regression model for ',
                .simpleCap(ResponseName), ' with the single Predictor ',
                .simpleCap(PredictorName), '."
print(xtable(', ModelName,
                ', caption=TabCapt, label="', ResponseName, '-', PredictorName,
                '-lm", digits=4), file = ThisTexFile)
```

```{r ANOVA-TEX, purl=FALSE}
ThisTexFile = "',
                Folder, '/', ResponseName, '-', PredictorName,
                '-anova.tex"
TabCapt = "Analysis of variance for the linear regression model having ',
                ResponseName, ' as the response and the Predictor ',
                PredictorName, '."
print(xtable(anova(', ModelName,
                '), caption=TabCapt, label="', ResponseName, '-', PredictorName,
                '-lm", digits=4), file = ThisTexFile)
```  \n\n'),
            file = Filename, append = TRUE)
      }

      # finish writing markdown and process the written file into html and an R script
      knit2html(Filename, quiet = TRUE,
                stylesheet = FindCSSFile(getOption("BrailleR.Style")))
      file.remove(sub(".Rmd", ".md", Filename))
      purl(Filename, quiet = TRUE, documentation = 0)
      if (View) browseURL(sub(".Rmd", ".html", Filename))
      environment(VI.lm) <- VI.env
    }  # end of OnePredictor function

