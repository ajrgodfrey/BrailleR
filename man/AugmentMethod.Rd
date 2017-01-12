\name{AugmentMethod}
\alias{Augment}
\alias{Augment.default}
\alias{Augment.Augmented}
\alias{Augment.boxplot}
\alias{Augment.dotplot}
\alias{Augment.eulerr}
\alias{Augment.ggplot}
\alias{Augment.histogram}
\alias{Augment.scatterplot}
\alias{Augment.tsplot}
\alias{.Augment}
\alias{.AugmentGrid}

\title{add additional detail to the stored object for a graph}
\description{Creates the necessary details that feed into the text descriptions in the VI() function and into the descriptions used in the accessible online versions of the graphs.}
\usage{
Augment(x)
}
\arguments{
  \item{x}{a graph object for which a method exists, or the current graphics device if set to NULL.}
}
\details{
Ought to be treated as an internal function and not used interactively.
}
\value{The input object is returned with additions to the object. This does not break the S3 class.}
\author{A. Jonathan R. Godfrey}
\examples{
x=rnorm(1000)
MyHist=Augment(hist(x))
MyHist
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
