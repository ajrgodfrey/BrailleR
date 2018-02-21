\name{VIgrep}
\alias{VIgrep}
\title{
Grep within the output produced by VI.ggplot
}
\description{
Allows the output from VI.ggplot to be limited based on a search pattern.
}
\usage{
VIgrep(pattern, x, ...)
}
\arguments{
  \item{pattern}{Charater string for matching, as per \code{grepl}} 
  \item{x}{object returned by \code{VI.ggplot}}
  \item{...}{other arguments passed on to \code{grepl} to control matching behaviour}
}
\value{
Returns a new object of the same type as that returned by VI.ggplot, but with the text component restricted to only those lines that matched the pattern.
}
\author{
Debra Warren
}

\examples{
if(require(ggplot2)){
VIgrep("axis",VI(qplot(1,1)))
}
}
