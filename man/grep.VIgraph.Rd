\name{grep.VIgraph}
\alias{grep}
\alias{grep.default}
\alias{grep.VIgraph}
\alias{gsub}
\alias{gsub.default}
\alias{gsub.VIgraph}
\title{
String manipulation of the output produced by VI.ggplot
}
\description{
  Allows the output from VI.ggplot to be searched and replaced
  based on a search pattern.
}
\usage{
\method{grep}{VIgraph}(pattern, x, \dots)
\method{gsub}{VIgraph}(pattern, replacement, x, \dots)
}
\arguments{
  \item{pattern}{Regular expression for matching, as per \code{grep}}
  \item{replacement}{Replacement text, as per \code{gsub}}
  \item{x}{object returned by \code{VI.ggplot}}
  \item{\dots}{other arguments passed on to \code{grep} or \code{gsub}
    to control matching behaviour}
}
\details{
  The \pkg{BrailleR} package redefines the \code{grep} and \code{gsub}
  functions as
  generic functions (that dispatch on the \code{x} argument),
  with \code{base::grep} and \code{base::gsub} as the default methods.
  This \code{grep.VIgraph}
  method behaves like \code{base::grep} with \code{value=TRUE}
  (i.e., it returns the matched values, not the indices).
}
\value{
  Returns a new object of the same type as that returned by VI.ggplot, but
  with the text component restricted to only those lines that matched the
  pattern or with the text component replaced.
}
\author{
Debra Warren and Paul Murrell
}

\examples{
if (require(ggplot2)) {
    grep("axis", VI(qplot(1,1)))
    gsub("labels", "tick labels", VI(qplot(1,1)))
}
}
