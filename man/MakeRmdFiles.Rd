\name{MakeRmdFiles}
\alias{History2Rmd}
\alias{R2Rmd}
\title{Work flow convenience funcions}
\description{Time-saving funcions that help create files in more useful formats for later processing.}
\usage{
History2Rmd(file = "History.Rmd")

R2Rmd(ScriptFile)
}
\arguments{
  \item{file}{the name of the fil to be created.}
  \item{ScriptFile}{the R script to be processed into the Rmarkdown file.}
}

\details{The History2Rmd function was intended for turning a short interactive R session into an Rmarkdown file. Lines of code are all separated into distinct code chunks in the Rmd file. the resulting file will need to be edited if commands have spanned more than one line. 

The R2Rmd function does try to limit the number of blank lines copied from the R script into the Rmarkdown file. The Rmd file may need som editing.
}
\value{NULL. These functions are for creating files in the current working directory.}
\author{A. Jonathan R. Godfrey}
\seealso{
These functions were inspired by the \code{\link[knitr]{spin}} functionality of the \pkg{knitr} package. You may wish to move onto using it for more features.}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
