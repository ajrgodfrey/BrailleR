\name{UniDesc}
\alias{UniDesc}
\title{Descriptive statistics and graphs for univariate data}
\description{
This function is a convenience function for analyzing univariate data. It provides histograms, boxplots and tabulated results for normality tests as well as those for skewness and kurtosis. The intended use of this function is principally for a blind user of R who also has the advantage of retrieving textual descriptions of the graphs created along the way, via the \code{VI()} methods.
}
\usage{
UniDesc(Response = NULL, ResponseName = as.character(match.call()$Response), 
    Basic = TRUE, Graphs = TRUE, Normality = TRUE, Tests = TRUE, 
    Title = NULL, Filename = NULL, Folder = ResponseName, Process = TRUE,
VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
View = getOption("BrailleR.View"), PValDigits=getOption("BrailleR.PValDigits"))
}
\arguments{
  \item{Response}{The numeric vector to be analyzed. This must be specified as a variable that is directly available in the workspace, not as a data.frame$variable construct.}
  \item{ResponseName}{This is the same as Response but use quote marks around it. Exactly one of Response or ResponseName must be specified.}
  \item{Basic}{logical, asking for basic numeric summary measures}
  \item{Graphs}{logical, indicating if the graphs are to be created. These will be eps files suitable for insertion in LaTeX documents, pdf files for more general use, and SVG for easier use by blind users.}
  \item{Normality}{logical, asking if the various normality tests offered in the \pkg{nortest} package should be used}
  \item{Tests}{logical, should skewness and kurtosis tests be performed.}
  \item{Title}{the title of the R markdown document being created. NULL leads to a default string being chosen.}
  \item{Filename}{Specify the name of the R markdown and html files (without extensions).}
  \item{Folder}{the folder where results and graph files will be saved.}
  \item{Process}{logical, should the R markdown file be processed?}
  \item{VI}{logical, should the VI method be used to give added text descriptions of graphs? This is most easily  set via the package options.}
  \item{Latex}{logical, Should the \pkg{xtable} package be used to convert the tabulated results into LaTeX tables? This is most easily  set via the package options.}
  \item{View}{logical, should the resulting HTML file  be opened in a browser? This is most easily  set via the package options.}
  \item{PValDigits}{Integer. The number of decimal places to use for p values. This is most easily  set via the package options.}
}

\value{
Saves an R markdown file, (and then if \code{Process=TRUE}) an R script file,  and an html file (which may be opened automatically) in the current working folder. Graphs are saved in png, eps, pdf, and SVG formats (if requested) in (optionally) a subfolder of the current working directory.
}
\author{A. Jonathan R. Godfrey \email{a.j.godfrey@massey.ac.nz}}
\examples{
if(require(nortest)){ # used in the Rmd file, not the UniDesc function
DIR = getwd()
setwd(tempdir())
Ozone=airquality$Ozone
UniDesc(Ozone)
rm(Ozone)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
setwd(DIR)
}
}