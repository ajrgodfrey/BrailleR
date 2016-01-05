## add this back in when the VI.anova() is done
#  ', ifelse(VI, "VI(", ""), 'anova(', ModelName, ifelse(VI,")", ""), ')

OnePredictor = function(Response, Predictor, Data=NULL, 
Filename=NULL, Folder=NULL, VI=getOption("BrailleR.VI"), Latex=getOption("BrailleR.Latex"), View=getOption("BrailleR.View")){

  # Need to redefine the environment for VI.lm function
VI.env <- environment(VI.lm)  
environment(VI.lm) <- environment()
  
if(length(Response)==1){
if(is.character(Response)){ResponseName=Response}
}
else{
ResponseName=as.character(match.call()$Response)
}
if(length(Predictor)==1){
if(is.character(Predictor)){PredictorName=Predictor}
}
else{
PredictorName=as.character(match.call()$Predictor)
}

if(is.null(Data)){
Data=data.frame(get(ResponseName), get(PredictorName))
names(Data)=c(ResponseName, PredictorName)
DataName=paste0(ResponseName, ".", PredictorName)
assign(paste0(ResponseName, ".", PredictorName), Data, envir=parent.frame())
}
else{
if(length(Data)==1){
if(is.character(Data)){DataName=Data}
Data=get(DataName)
}
else{
DataName=as.character(match.call()$Data)
}
if(!is.data.frame(Data)) stop("The named dataset is not a data.frame.")
}

with(Data, {
if(!is.numeric(get(ResponseName))) stop("The response variable is not numeric.")
if(!is.numeric(get(PredictorName))) stop("The Predictor variable is not numeric.")
}) # end data checking

# create folder and filenames
if(is.null(Folder)) Folder=DataName
if(Folder!="" & !file.exists(Folder)) dir.create(Folder)
if(is.null(Filename)) { Filename = paste0(ResponseName, ".", PredictorName, "-OnePredictor.Rmd") }

ModelName=paste0(ResponseName, ".", PredictorName, ".lm")

# start writing to the R markdown file
cat('# Analysis of the', DataName, 'data, using', ResponseName, 'as the response variable and', PredictorName, 'as the single predictor.  \n\n', file=Filename)

cat(paste0('```{r setup2, purl=FALSE, include=FALSE}  
opts_chunk$set(dev=c("png", "pdf", "postscript", "svg"))  
opts_chunk$set(echo=FALSE, comment="", fig.path="', Folder, '/', ResponseName, '.', PredictorName, '-", fig.width=7)  
```    

## Variable summaries  

The response variable is ', ResponseName ,' and the predictor variable is ', PredictorName,'.

```{r VariableSummary}  
attach(', DataName, ')
SummaryResponse <- summary(na.omit(',ResponseName,'))
SummaryPredictor <- summary(na.omit(',PredictorName,'))
SummaryTable <- cbind(',ResponseName,'=SummaryResponse,',PredictorName,'=SummaryPredictor)
row.names(SummaryTable) <- c("Minimum","Lower Quartile", "Median","Mean","Upper Quartile","Maximum")
Sds <- c(sd(',ResponseName,', na.rm=T),sd(',PredictorName,', na.rm=T))
Nas <- c(sum(is.na(',ResponseName,')), sum(is.na(',PredictorName,')))
SummaryTable <- rbind(SummaryTable,"Standard Deviation"=Sds,"Missing Values"=Nas)
detach(', DataName, ')
```    

```{r PrintSummary, results="asis", purl=FALSE}  
kable(t(SummaryTable), row.names=T, align=rep("c",8))  
```  \n\n'), file=Filename, append=TRUE)

if(Latex){
cat(paste0('```{r VariableSummaryTex, purl=FALSE}
library(xtable)
ThisTexFile = "', Folder, '/', ResponseName, '.', PredictorName, '-VariableSummary.tex"  
TabCapt = "Summary statistics for variables ', ResponseName, ' and ', PredictorName, '"  
print(xtable(t(SummaryTable), caption=TabCapt, label="', ResponseName, 'VariableSummary", digits=4, align="lrrrrrrrr"), include.rownames = FALSE, file = ThisTexFile)  
```  \n\n'), file=Filename, append=TRUE)
}

cat(paste0('## Scatter Plot

```{r ScatterPlot, fig.cap="Scatter Plot"}
# Remove the missing values
completeCases <- complete.cases(Data[ResponseName])*complete.cases(Data[PredictorName])
assign(DataName, Data[completeCases==1,])

plot(',ResponseName,'~',PredictorName,', data=',DataName,')
attach(',DataName,')
WhereXY(',ResponseName,',',PredictorName,')
detach(',DataName,')
```  \n\n'), file=Filename, append=TRUE)


cat(paste0('## Linear regression  

```{r SimpleLinMod}   
', ModelName, ' <- lm(', ResponseName, '~', PredictorName, ', data=', DataName,')
', ifelse(VI, paste("VI(",ModelName,")"), ""), ' 
', ifelse(VI, paste0("VI(summary(", ModelName, "))"), ""), ' 
summary(', ModelName, ')  
```  

```{r FittedLinePlot}   
plot(',ResponseName,'~',PredictorName,', data=',DataName,')
abline(', ModelName, ')  
```  

```{r SimpleLinModResAnal, fig.cap="Residual analysis"}  
par(mfrow=c(2,2))  
plot(', ModelName, ')  
```  \n\n'), file=Filename, append=TRUE)

if(VI){
cat(paste0('A separate html page showing the residual analysis and model validity checking for ', ModelName, ' is at [', ModelName, '.Validity.html](', ModelName, '.Validity.html)  \n\n'), file=Filename, append=TRUE)
}

cat(paste0('### One-way Analysis of Variance  

```{r OneWayANOVA1}  
anova(', ModelName, ')  
```  \n\n'), file=Filename, append=TRUE)

if(Latex){
cat(paste0('```{r SimpleLinMod-TEX, purl=FALSE}  
ThisTexFile = "', Folder, '/', ResponseName, '-', PredictorName, '-lm.tex"  
TabCapt = "Linear regression model for ', ResponseName, ' with the single Predictor ', PredictorName, '."  
print(xtable(', ModelName, ', caption=TabCapt, label="', ResponseName, '-', PredictorName, '-lm", digits=4), file = ThisTexFile)  
```  

```{r ANOVA-TEX, purl=FALSE}  
ThisTexFile = "', Folder, '/', ResponseName, '-', PredictorName, '-anova.tex"  
TabCapt = "Analysis of variance for the linear regression model having ', ResponseName, ' as the response and the Predictor ', PredictorName, '."  
print(xtable(anova(', ModelName, '), caption=TabCapt, label="', ResponseName, '-', PredictorName, '-lm", digits=4), file = ThisTexFile)  
```  \n\n'), file=Filename, append=TRUE)
}

# stop writing markdown and process the written file into html and an R script
knit2html(Filename, quiet=TRUE)
file.remove(sub(".Rmd", ".md", Filename))
purl(Filename, quiet=TRUE, documentation=0)
if(View) browseURL(sub(".Rmd", ".html", Filename))
environment(VI.lm) <- VI.env
} # end of OnePredictor function
