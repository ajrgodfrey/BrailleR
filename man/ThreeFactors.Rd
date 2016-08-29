\name{ThreeFactors}
\alias{ThreeFactors}
\title{A convenience function for a Three-way analysis}
\description{Prepares an analysis of a data set with one response and three predictors that are all factors. Interactions between the Three factors are also allowed for. The function creates a number of graphs and tables relevant for the analysis.}
\usage{
ThreeFactors(Response, Factor1, Factor2, Factor3, Data = NULL, Filename = NULL, 
    Folder = NULL, VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
    View = getOption("BrailleR.View"))
}
\arguments{
  \item{Response}{Name of the continuous response variable.}
  \item{Factor1, Factor2, Factor3}{Name the three factors to be included.}
  \item{Data}{Name the data.frame that includes the three variables of interest.}
  \item{Filename}{Name of the Rmarkdown and HTML files to be created. A default will be created that uses the names of the variables if this is left set to NULL.}
  \item{Folder}{Name of the folder to store graph and LaTeX files. A default will be created based on the name of the data.frame being used.}
  \item{VI}{Logical: Should the VI method for blind users be employed?}
  \item{Latex}{Logical: Should the tabulated sections be saved in LaTeX format?}
  \item{View}{Logical: Should the HTML file be opened for inspection?}
}
\details{
to complete}
\value{
to complete}
\author{A. Jonathan R. Godfrey and Timothy P. Bilton}

\seealso{
The \code{\link{OneFactor}} script was the basis for this function;.
}
\examples{
TestData=data.frame(Resp=sample(54), expand.grid(F1=c("a","b","c"), 
    F2=c("d","e","f"), F3=c("g","h","i"), rep=c(1,2)))
attach(TestData)
ThreeFactors(Resp,F1,F2,F3)
detach(TestData)
rm(TestData)
}
