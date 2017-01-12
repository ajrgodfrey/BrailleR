\name{ScatterPlot}
\alias{ScatterPlot}
\title{Create a standard scatter plot with a few extra elements added to the output object}
\description{This function is a wrapper to the standard \code{plott()} function in the \pkg{graphics} package. It is tailored to generating a scatter plot, and adds detail to the stored object so that a better text description can be formulated using the \code{VI()} method in the \pkg{BrailleR} package.}
\usage{
ScatterPlot(x, y, ...)
}
\arguments{
  \item{x,y}{numeric variables.}
  \item{\dots}{
additional arguments passed on to the plotting function.}
}
\details{
This wrapper will draw the base graphics plot for a set of points.}
\value{
An object of class scatterplot, with the addition of any calls to the main title or axis labels being explicitly stored even if a zero length character string.}
\references{
Godfrey, A.J.R. (2013) \sQuote{Statistical Software from a Blind Person's Perspective: R is the Best, but we can make it better}, The R Journal 5(1), pp73-79.
}
\author{
A. Jonathan R. Godfrey
}


