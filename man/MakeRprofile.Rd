\name{MakeRprofile}
\alias{MakeRprofile}
\title{Load BrailleR on Startup in Current Working Directory}
\usage{
MakeRprofile(Overwrite = FALSE)
}
\arguments{
\item{Overwrite}{Logical: Should an existing .Rprofile file be overwritten?}
}
\value{
Nothing. This function is used for its side effect of creation of a file in the current working directory. A warning message is created if the file exists and Overwrite=FALSE.
}
\description{
Writes the single command \dQuote{library(BrailleR)} to a .First() function in .Rprofile in the current working directory. This forces the BrailleR package to be automatically loaded when R is opened in this working directory.
}
\author{
A. Jonathan R. Godfrey.
}

