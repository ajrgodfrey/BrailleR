\name{Internal}
\alias{FindCSSFile}
\alias{GetAxisTicks}
\alias{InQuotes}
\alias{nNonMissing}
\title{Internal functions for the BrailleR package}
\description{Some functions that probably weren't really necessary, but proved useful at some stage.}
\usage{
FindCSSFile(file)


GetAxisTicks(x)

InQuotes(x)

nNonMissing(x)
}
\arguments{
 \item{x}{an object that is of the form needed by the internal function concerned.}
\item{file}{a filename to look for in the user's css folder or locally.}
}
\details{
\code{GetAxisTicks} is intended to create the sequence of values used on an axis.}
\value{These should be fairly obvious from the name of the function}
\author{A. Jonathan R. Godfrey}
