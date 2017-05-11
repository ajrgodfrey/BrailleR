\name{dotplot}
\alias{dotplot}
\alias{dotplot.default}
\alias{dotplot.formula}
\title{create a dotplot using stripchart}
\description{
A method for creating dotplots. The functions call the \code{stripchart} command from the \pkg{graphics} package and assign the output to have the class \code{dotplot}.
}
\usage{
dotplot(x, ...)

\method{dotplot}{formula}(x, ...)
}
\arguments{
  \item{x}{a vector or formula, where the right hand side of the formula is a factor.}
  \item{\dots}{other graphical parameters including those passed to \code{title}.}
}
\details{
This function was created as a result of being unable to assign all graphical parameters that are created when a formula is used in \code{stripchart}. Users not intending to use the \code{VI} method should use \code{stripchart} instead.}
\author{A. Jonathan R. Godfrey}
\seealso{
This function is dependent on the \code{\link[graphics]{stripchart}} function from the \pkg{graphics} package. Consult its help page for more information. 
}
\examples{
VI(with(airquality, dotplot(Ozone~Month)))
}
