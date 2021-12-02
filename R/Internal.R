FindCSSFile =
    function(file) {
      out = NULL
      if (file.exists(paste0(getOption("BrailleR.Folder"), "/css/", file))) {
        out = normalizePath(paste0(getOption("BrailleR.Folder"), "/css/", file))
      }
      if (file.exists(file)) {
        out = file
      }
      return(out)
    }



InQuotes = function(x) {
             Out = paste0('"', x, '"')
           }


### from examples for toupper() with slight alteration to allow for BrailleR options.
.simpleCap <- function(x) {
  if (getOption("BrailleR.MakeUpper")) {
    s <- strsplit(x, " ")[[1]]
    out = paste0(toupper(substring(s, 1, 1)), substring(s, 2))
  } else {
    out = x
  }
  return(out)
}



.GetOldStyleScatterText = function(ResponseName, PredictorName, DataName){
TextOut = paste0(
              '```{r ScatterPlot, fig.cap="Scatter Plot"}
# Remove the missing values
completeCases <- complete.cases(Data[ResponseName])*complete.cases(Data[PredictorName])
assign(DataName, Data[completeCases==1,])

plot(',
              ResponseName, '~', PredictorName, ', data=', DataName, ', ylab=',
              .simpleCap(ResponseName), ', xlab=', .simpleCap(PredictorName),
              ')
attach(', DataName, ')
WhereXY(', ResponseName, ',',
              PredictorName, ')
detach(', DataName, ')
```  \n\n')
return(TextOut)
}

.GetModernStyleScatterText = function(ResponseName, PredictorName, DataName){
TextOut=UseTemplate(file="ScatterPlot.Rmd", find=c("DataName", "ResponseName", "PredictorName"), replace=c(DataName, ResponseName, PredictorName))
return(TextOut)
}

.GetOldStyleFittedText = function(ResponseName, PredictorName, DataName, ModelName){
TextOut = paste0('
```{r FittedLinePlot}
plot(', ResponseName, '~',
              PredictorName, ', data=', DataName, ', ylab=',
              .simpleCap(ResponseName), ', xlab=', .simpleCap(PredictorName),
              ')
abline(', ModelName,
              ')
```\n\n')
return(TextOut)
}

.GetModernStyleFittedText = function(ResponseName, PredictorName, DataName, ModelName){
TextOut=UseTemplate(file="FittedLinePlot.Rmd", find=c("DataName", "ResponseName", "PredictorName"), replace=c(DataName, ResponseName, PredictorName))
return(TextOut)
}


.GetOldStyleResidualText = function(ModelName){
TextOut=paste0('
```{r SimpleLinModResAnal, fig.cap="Residual analysis"}
par(mfrow=c(2,2))
plot(',
              ModelName, ')
```  \n\n')
return(TextOut)
}


.GetModernStyleResidualText = function(ModelName){
TextOut=""
return(TextOut)
}


