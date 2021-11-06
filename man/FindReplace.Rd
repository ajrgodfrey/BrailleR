\name{FindReplace}
\alias{FindReplace}
\alias{Rnw2Rmd}
\alias{UseTemplate}
\alias{UseTemplateList}
\title{Find/Replace text in a file}
\usage{
FindReplace(file, find, replace)

Rnw2Rmd(file)

UseTemplate(file, find=NULL, replace=NULL)

UseTemplateList(newfile, fileList, find=NULL, replace=NULL)
}
\arguments{
\item{file,fileList}{The external (text) file, template, or list of templates  to be updated.}
\item{newfile}{the file to write output to}

\item{find}{The text to remove.}

\item{replace}{The text to insert.}
}
\value{
FindReplace will replace the existing file with the updated version while UseTemplate will return a character string which will usually be pushed out to an R script or R markdown file. 
}
\description{
Simple wrapper functions to make it easier to replace the text in a file, possibly due to spelling errors, but perhaps to replace default text in a template file.
}
\details{
The FindReplace function is purely intended for use on an external file whereas UseTemplate is intended to take a template file from within the BrailleR package and return the updated text to the calling environment.

Rnw2Rmd tries to replace Standard LaTeX commands and Sweave chunk headers with R markdown ones. It is NOT comprehensive, but it does get a long way towards a useful markdown file.

Obviously the specified file must exist for these functions to work.
}
\author{
A. Jonathan R. Godfrey
}
\examples{
UseTemplate("DTGroupSummary.R")
UseTemplate("DTGroupSummary.R", "DataName", "MyData")
}
