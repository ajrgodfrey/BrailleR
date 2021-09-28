\name{TwoFactors}
\alias{TwoFactors}
\title{A convenience function for a two-way analysis}
\description{Prepares an analysis of a data set with one response and two predictors that are both factors. An interaction between the two factors is also allowed for. The function creates a number of graphs and tables relevant for the analysis.}
\usage{
TwoFactors(Response, Factor1, Factor2, Inter = FALSE, HSD = TRUE, 
   AlphaE = getOption("BrailleR.SigLevel"), Data = NULL, Filename = NULL, 
    Folder = NULL, VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
    View = getOption("BrailleR.View"))
}
\arguments{
  \item{Response}{Name of the continuous response variable.}
  \item{Factor1, Factor2}{Name the two factors to be included.}
  \item{Inter}{Logical: Should the interaction of the two factors be included?}
  \item{HSD}{Logical: Should Tukey's HSD be evaluated for the data?}
  \item{AlphaE}{The family-wise Type I error rate for Tukey's HSD calculations.}
  \item{Data}{Name the data.frame that includes the three variables of interest.}
  \item{Filename}{Name of the Rmarkdown and HTML files to be created. A default will be created that uses the names of the variables if this is left set to NULL.}
  \item{Folder}{Name of the folder to store graph and LaTeX files. A default will be created based on the name of the data.frame being used.}
  \item{VI}{Logical: Should the VI method for blind users be employed?}
  \item{Latex}{Logical: Should the tabulated sections be saved in LaTeX format?}
  \item{View}{Logical: Should the HTML file be opened for inspection?}
}
\details{
to complete}
\value{This function is used for creation of the files saved in the working directory and a few of its subdirectories.}
\author{Timothy P. Bilton and A. Jonathan R. Godfrey}

\seealso{
The \code{\link{OneFactor}} script was the basis for this function;.
}
\examples{
DIR = getwd()
setwd(tempdir())
TG <- ToothGrowth
TG$dose <- as.factor(TG$dose)

# Without interaction
TwoFactors('len','supp','dose',Data=TG, Inter=FALSE)

# With two-way interaction
TwoFactors('len', 'supp', 'dose', Data=TG, Inter=TRUE)

# For unbalanced data
TG_Unb <- TG[-c(53:60),]
TwoFactors('len', 'supp', 'dose', Data=TG_Unb, Inter=TRUE)
rm(TG); rm(TG_Unb)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
setwd(DIR)
}
