## Last Edited: 16/01/16

TwoFactors = function(Response, Factor1, Factor2, Inter=FALSE, HSD=TRUE, AlphaE = getOption("BrailleR.SigLevel"), Data=NULL, 
    Filename=NULL, Folder=NULL,
    VI=getOption("BrailleR.VI"), Latex=getOption("BrailleR.Latex"), View=getOption("BrailleR.View"))
{

# Check inputs are right form    
if(length(Response)==1){
    if(is.character(Response)){ResponseName=Response}
}
else{
    ResponseName=as.character(match.call()$Response)
}
if(length(Factor1)==1){
    if(is.character(Factor1)){Factor1Name=Factor1}
}
else{
    Factor1Name=as.character(match.call()$Factor1)
}
if(length(Factor2)==1){
    if(is.character(Factor2)){Factor2Name=Factor2}
}
else{
    Factor2Name=as.character(match.call()$Factor2)
}
if(is.null(Data)){
    Data=data.frame(get(ResponseName), get(Factor1Name), get(Factor2Name))
    names(Data)=c(ResponseName, Factor1Name, Factor2Name)
    DataName=paste0(ResponseName, ".", Factor1Name)
    assign(paste0(ResponseName, ".", Factor1Name, ".", Factor2Name),  Data, envir=parent.frame())
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
    if(!is.vector(get(ResponseName))) stop("Input response is not a vector.")
    if(!is.factor(get(Factor1Name))) stop("The first factor is not a factor.\nTry using as.factor() on a copy of the data.frame.")
    if(!is.factor(get(Factor2Name))) stop("The second factor is not a factor.\nTry using as.factor() on a copy of the data.frame.")
}) # end data checking

# create folder and filenames
if(is.null(Folder)) Folder=DataName
if(Folder!="" & !file.exists(Folder)) dir.create(Folder)
if(is.null(Filename)) Filename = paste0(ResponseName, ".", Factor1Name, ".", Factor2Name, "-TwoFactors", ifelse(Inter, 'WithInt', 'NoInt'), ".Rmd")

# start writing to the R markdown file
cat(paste0('# Analysis of the ', DataName, ' data, using ', ResponseName, ' as the response variable and the variables ', Factor1Name,  ifelse(Inter, ", ", " and "), Factor2Name, ifelse(Inter, ", and their interaction", ""), ' as factors.  
#### Prepared by ', getOption("BrailleR.Author"), '  \n\n'), file=Filename)

cat(paste0('```{r setup, purl=FALSE, include=FALSE}  
opts_chunk$set(dev=c("png", "pdf", "postscript", "svg"))  
opts_chunk$set(echo=FALSE, comment="", fig.path="', Folder, '/', ResponseName, '.', Factor1Name, '.',Factor2Name, '-", fig.width=7)  
```    

## Group summaries

```{r GroupSummary}  
attach(', DataName, ')  
Data.Mean <- aggregate(', ResponseName,', list(', Factor1Name,', ', Factor2Name, '), mean, na.rm=TRUE)
Data.StDev <- aggregate(', ResponseName,', list(', Factor1Name,', ', Factor2Name, '), sd, na.rm=TRUE)
nNonMissing <- function(x){
    length(na.omit(x)) # length() includes NAs
}
Data.n <- aggregate(', ResponseName,', list(', Factor1Name,', ', Factor2Name, '), nNonMissing)
Data.StdErr = Data.StDev[,3]/sqrt(Data.n[,3])
detach(', DataName, ')  
DataSummary = cbind(Data.Mean, Data.StDev[,3], Data.n[,3], Data.StdErr)
colnames(DataSummary) = c("',Factor1Name, ' Level", "',Factor2Name,' Level", "Mean", "Standard deviation", "n", "Standard error")
```  

The ratio of the largest group standard deviation to the smallest is `r round(max(Data.StDev[,3])/min(Data.StDev[,3]),2)`  

```{r PrintSummary, results="asis", purl=FALSE}  
kable(as.matrix(DataSummary), row.names=FALSE)  
```  \n\n'), file=Filename, append=TRUE)

if(Latex){
cat(paste0('```{r DataSummaryTex, purl=FALSE}  
library(xtable)  
ThisTexFile = "', Folder, '/', ResponseName, '.', Factor1Name, '.', Factor2Name, '-GroupSummary.tex"  
TabCapt = "Summary statistics for ', ResponseName, ' by level of ', Factor1Name, ' and ', Factor2Name, '"  
print(xtable(DataSummary, caption=TabCapt, label="', ResponseName, 'GroupSummary", digits=4, align="llrrrrr"), include.rownames = FALSE, file = ThisTexFile)  
    ```  \n\n'), file=Filename, append=TRUE)
}

### Produce the EDA plots depending on whether interactions are included or not.

nNonMissing <- function(x){
  length(na.omit(x)) # length() includes NAs
}
Data.n <- with(get(DataName), aggregate(get(ResponseName), list(get(Factor1Name),get(Factor2Name)), nNonMissing))

if(Inter){
if(min(Data.n[,3])>4){
cat(paste0('## Comparative boxplots
```{r boxplots, fig.cap="Comparative boxplots"}  \n',
ifelse(VI,"VI(",""), 'boxplot(', ResponseName, '~interaction(', Factor1Name, ',', Factor2Name, ', sep=":"), data=', DataName, ifelse(VI,")", ""), ')  
```\n\n'), file=Filename, append=TRUE)
}
else{
cat(paste0('## Comparative boxplots  

When boxplots are not included, it is  because at least one group size is too small.  \n\n'), file=Filename, append=TRUE)
}
}
else{
if(min(Data.n[,3])>4){
cat(paste0('## Comparative boxplots
```{r boxplots, fig.cap="Comparative boxplots"}  \n',
ifelse(VI,"VI(",""), 'boxplot(', ResponseName, '~', Factor1Name, ', data=', DataName, ifelse(VI,")", ""), ')\n',
ifelse(VI,"VI(",""), 'boxplot(', ResponseName, '~', Factor2Name, ', data=', DataName, ifelse(VI,")", ""), ')  
``` \n\n'), file=Filename, append=TRUE)
}
else{
cat(paste0('## Comparative boxplots  

When boxplots are not included, it is  because at least one group size is too small.   \n\n'), file=Filename, append=TRUE)
}
}

cat(paste0('## Comparative dotplots  

```{r Dotplots-by-', Factor1Name, ', fig.cap="Comparative dotplots for ', ResponseName, ' by ', Factor1Name, '"}  
', ifelse(VI, "VI(", ""), 'stripchart(', ResponseName, '~', Factor1Name, ', data=', DataName, ifelse(VI,")", ""), ')  
```  

```{r Dotplots-by-', Factor2Name, ', fig.cap="Comparative dotplots for ', ResponseName, ' by ', Factor2Name, '"}  
', ifelse(VI, "VI(", ""), 'stripchart(', ResponseName, '~', Factor2Name, ', data=', DataName, ifelse(VI,")", ""), ')  
``` \n\n'), file=Filename, append=TRUE)


#### Interaction plot (if specified)

if(Inter){
  
F1.Big = length(levels(Data[[Factor2Name]])) < length(levels(Data[[Factor1Name]]))
xFactor = ifelse(F1.Big ,Factor1Name, Factor2Name)
Trace = ifelse(!F1.Big, Factor1Name, Factor2Name)
  
cat(paste0('## Interaction Plot \n
```{r InteractionPlot, fig.cap="Interaction Plot"}
with(',DataName, ', interaction.plot(', xFactor, ',', Trace, ',', ResponseName, ')) 
colnames(Data.Mean) = c("',Factor1Name,'","', Factor2Name,'", "Mean") 
cat("Means table: Rows are for the trace factor, ', Trace ,', and columns are for the factor along the x-axis, ', xFactor, '.")
xtabs(Mean~',Trace, '+', xFactor,',data=Data.Mean) 
```  \n\n'), file=Filename, append=TRUE)
}


######## Fit the anova model

cat(paste0('## Two-way Analysis of Variance

```{r TwoWayANOVA}
MyANOVA <- aov(', ResponseName, '~', Factor1Name, ifelse(Inter, "*", "+") , Factor2Name, ', data=', DataName, ')
', ifelse(VI, "VI(MyANOVA)", ""), '
summary(MyANOVA)  
if(length(unique(Data.n[,3]))!=1){ 
MyANOVA2 <- aov(', ResponseName, '~', Factor2Name, ifelse(Inter, "*", "+") , Factor1Name, ', data=', DataName, ')
', ifelse(VI, "VI(MyANOVA2)", ""),'
summary(MyANOVA2)
}
```  \n\n'), file=Filename, append=TRUE)

if(Latex){
cat(paste0('```{r ANOVA-TEX, purl=FALSE}  
library(xtable)  
ThisTexFile = "', Folder, '/', ResponseName, '-', Factor1Name, '-', Factor2Name, ifelse(Inter, "WithInt", "NoInt"), '-ANOVA.tex"  
TabCapt = "Two-way ANOVA for ', ResponseName, ' with the group factors ', Factor1Name, ' and ', Factor2Name, ifelse(Inter, ", as well as their interaction", " without their interaction"), '."  
print(xtable(MyANOVA, caption=TabCapt, label="', ResponseName, '-', Factor1Name, '-ANOVA", digits=4), file = ThisTexFile)  
```  \n\n'), file=Filename, append=TRUE)
}

if(Inter){
cat(paste0("```{r TwoWayANOVA2, fig.cap=\"Residual analysis\"}
par(mfrow=c(2,2)) 
plot(MyANOVA) 
``` \n\n## Tests for homogeneity of Variance  \n
```{r BartlettTest} 
bartlett.test(", ResponseName, "~interaction(", Factor1Name, ",", Factor2Name, "), data=", DataName, ")
``` \n\n```{r FlignerTest}
fligner.test(", ResponseName, "~interaction(", Factor1Name, ",", Factor2Name, "), data=", DataName, ")
``` \n\n"), 
file = Filename, append = TRUE)
}
else{
cat(paste0("```{r TwoWayANOVA2, fig.cap=\"Residual analysis\"}
par(mfrow=c(2,2))  
plot(MyANOVA) 
``` \n\n## Tests for homogeneity of Variance  \n
```{r BartlettTest}
bartlett.test(", ResponseName, "~", Factor1Name,", data=", DataName, ")
bartlett.test(", ResponseName, "~", Factor2Name,", data=", DataName, ") 
``` \n\n```{r FlignerTest}
fligner.test(", ResponseName, "~", Factor1Name, ", data=", DataName, ")  
fligner.test(", ResponseName, "~", Factor2Name, ", data=", DataName, ")  
``` \n\n"), file = Filename, append = TRUE)
}

# Tukey HSD output and plots

if(HSD){
cat(paste0("## Tukey Honestly Significant Difference test \n
```{r TukeyHSD, fig.cap=\"Plot of Tukey HSD\"}
MyHSD <- TukeyHSD(MyANOVA, ordered=TRUE, conf.level=", 1-AlphaE,")
", ifelse(VI, "VI(MyHSD)", ""), "
MyHSD
plot( MyHSD )
``` \n\n"), file=Filename, append=TRUE)
}

# stop writing markdown and process the written file into html and an R script
knit2html(Filename, quiet=TRUE, stylesheet=FindCSSFile(getOption("BrailleR.Style")))
file.remove(sub(".Rmd", ".md", Filename))
purl(Filename, quiet=TRUE, documentation=0)
if(View) browseURL(sub(".Rmd", ".html", Filename))
} # end of TwoFactors function




