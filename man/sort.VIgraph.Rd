\name{sort.VIgraph}
\alias{sort.VIgraph}
\title{
Sort VI.ggplot points list
}
\description{
Allows the list of data points listed by VI.ggplot to be sorted by x or y values, ascending or descending.  Currently only implemented for geom_points.  This function is experimental and has not been extensively tested.
}
\usage{
\method{sort}{VIgraph}(x, decreasing = FALSE, by = "x", \dots)
}
\arguments{
  \item{x}{object returned by \code{VI.ggplot}}
  \item{decreasing}{logical: should the sort be decreasing}
  \item{by}{value on which to sort, "x" or "y"}
  \item{\dots}{further arguments passed to \code{base::sort}}
}
\value{
Returns a new object of the same type as that returned by VI.ggplot, but with data re-ordered.
}
\author{
Debra Warren and Paul Murrell
}

\examples{
if (require(ggplot2)) {
    sort(VI(qplot(x=1:5, y=c(2,5,1,4,3))), decreasing=TRUE, by="y")
}
}

