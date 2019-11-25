\name{WriteR}
\alias{PrepareWriteR}
\alias{TestPython}
\alias{TestWX}
\alias{WriteR}
\title{Getting started with WriteR}
\description{The WriteR application was written in wxPython so that blind users can process Rmarkdown documents. This functionality is offered because RStudio is not an accessible application for screen reader users.}
\usage{
WriteR(file = NULL, math = c("webTeX", "MathJax"))

TestPython()
TestWX()

PrepareWriteR(Author = getOption("BrailleR.Author"))
}
\arguments{
  \item{Author}{Your name as you want it to appear in the default text that starts your R markdown documents.}
\item{file}{The filename you want started. Not implemented yet.}
\item{math}{The style for mathematical content in HTML documents created using LaTeX input. Not yet implemented.}
}
\details{WriteR needs python and wxPython to run. Error handling for users without these packages installed is not yet incorporated in these functions. Please use \code{TestWX()} because it calls \code{TestPython()} as its first test.

The \code{PrepareWriteR()}  function writes the settings file (called WriteROptions) for WriteR and copies the files that were part of the BrailleR installation into the current working directory. You will be able to run the WriteR application from there, or move to a folder of your choosing.}
\value{NULL. The \code{WriteR}  function is for your convenience and not for doing any work inside an R session. The \code{TestWX()} function prints results but returns nothing. The \code{TestPython()} function returns a logical to say Python can be seen by your system.}
\author{A. Jonathan R. Godfrey}
\note{You must have Python and the associated wxPython installation on your system to use the WriteR application.}
