\name{MakeRmdFiles}
\alias{History2Rmd}
\alias{ProcessAllMd}
\alias{ProcessAllRmd}
\alias{R2Rmd}
\title{Work flow convenience functions}
\description{Time-saving functions that help create files in more useful formats for later use.}
\usage{
History2Rmd(file = "History.Rmd")

R2Rmd(ScriptFile)

ProcessAllMd(dir =".")
ProcessAllRmd(dir =".", method = "render")
}
\arguments{
  \item{dir}{The directory to find files.}
  \item{file}{the name of the file to be created.}
  \item{method}{The method used to process Rmd files; one of "render" or "knit2html".}
  \item{ScriptFile}{the R script to be processed into the Rmarkdown file.}
}

\details{The History2Rmd() function was intended for turning a short interactive R session into an R markdown file. Lines of code are all separated into distinct code chunks in the Rmd file. the resulting file will need to be edited if commands have spanned more than one line. 

The R2Rmd() function does try to limit the number of blank lines copied from the R script into the Rmarkdown file. The Rmd file may need some editing.

Once all Rmd files have been edited, the user can have all the Rmd files in a folder processed using ProcessAllRmd(). A similar function ProcessAllMd() exists to process any plain markdown files which do not need knitting.
}
\value{NULL. These functions are for creating files in the current working directory.}
\author{A. Jonathan R. Godfrey}
\seealso{
These functions were inspired by the \code{\link[knitr]{spin}} functionality of the \pkg{knitr} package. You may wish to move onto using it for more features.}
