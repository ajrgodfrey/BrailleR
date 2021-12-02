\name{OneFactor}
\alias{OneFactor}
\title{Analysis for a continuous response for one group factor}
\description{
A convenience function that creates an analysis for a continuous response variable with one grouping factor. The function creates a number of graphs and tables relevant for the analysis.}
\usage{
OneFactor(Response, Factor, Data = NULL, HSD = TRUE, AlphaE = 0.05, 
Filename = NULL, Folder = NULL, 
VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
View = getOption("BrailleR.View"), Modern=TRUE)
}
\arguments{
  \item{Response}{Name of the continuous response variable.}
  \item{Factor}{The grouping factor.}
  \item{Data}{The data.frame that contains both the response and the factor.}
  \item{HSD}{Logical: Should Tukey's HSD be evaluated for the data?}
  \item{AlphaE}{The family-wise Type I error rate for Tukey's HSD calculations.}
  \item{Filename}{Name of the Rmarkdown and HTML files to be created. A default will be created that uses the names of the variables if this is left set to NULL.}
  \item{Folder}{Name of the folder to store graph and LaTeX files. A default will be created based on the name of the data.frame being used.}
  \item{VI}{Logical: Should the VI method for blind users be employed?}
  \item{Latex}{Logical: Should the tabulated sections be saved in LaTeX format?}
  \item{View}{Logical: Should the HTML file be opened for inspection?}
  \item{Modern}{Logical: Should the graphics be createdusing ggplot?}
}
\details{This function writes an R markdown file that is knitted into HTML and purled into an R script. All graphs are saved in subdirectories in png, eps, pdf and svg formats. Tabulated results are stored in files suitable for importing into LaTeX documents.}
\value{This function is used for creation of the files saved in the working directory and a few of its subdirectories.}
\author{A. Jonathan R. Godfrey and Timothy P. Bilton}
\seealso{Other convenience functions can be investigated via their help pages. See \code{\link{UniDesc}}, \code{\link{OnePredictor}}, and \code{\link{TwoFactors}}
}

\examples{
DIR = getwd()
setwd(tempdir())
data(airquality)
library(dplyr)
# the following line  returns an error:
## OneFactor("Ozone", "Month", airquality, View=FALSE)
# so we make a copy of the data.frame, and fix that:
if(require(dplyr)){
airquality2 = airquality \%>\% mutate(Month = as.factor(Month))
# and now all is good to try:
OneFactor("Ozone", "Month", airquality2)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
}
setwd(DIR)
}
