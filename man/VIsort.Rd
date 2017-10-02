\name{VIsort}
\alias{VIsort}
\title{
Sort VI.ggplot points list
}
\description{
Allows the list of data points listed by VI.ggplot to be sorted by x or y values, ascending or descending.  Currently only implemented for geom_points.  This function is experimental and has not been extensively tested.
}
\usage{
VIsort(x, sortby="x", decreasing = FALSE)
}
\arguments{
  \item{x}{object returned by \code{VI.ggplot}}
  \item{sortby}{value on which to sort, "x" or "y"}
  \item{decreasing}{logical: should the sort be decreasing}
}
\value{
Returns a new object of the same type as that returned by VI.ggplot, but with data re-ordered.
}
\author{
Debra Warren
}

\examples{
if(require(ggplot2)){
VIsort(VI(qplot(x=1:5,y=c(2,5,1,4,3))),sortby="y",dec=TRUE)
}
}

