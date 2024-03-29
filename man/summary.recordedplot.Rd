\name{summary.recordedplot}
\alias{summary.recordedplot}
\title{Summarise the display list for a  graphics device}
\description{Base graphics are created using a series of calls to C routines. This function gathers the names of these calls and the values of the arguments as supplied. Names of the arguments are then added. The display list must be retrieved before the graphics device is closed, but this could be stored for later summarisation.}
\usage{
\method{summary}{recordedplot}(object, ...)
}
\arguments{
  \item{object}{the display list created by recordPlot().}
  \item{\dots}{necessary argument for the method; currently ignored}
}
\details{
The outcome of this command must be further processed to give it  context.
}
\value{
A named list of named vectors. Names of list elements are the C function calls used in plotting the graph on the graphics device; the names for the vectors are dependent on which C functions are called, but are the argument names as per the R  function most closely associated with that C call.
}
\author{Deepayan Sarkar with minor edits from A. Jonathan R. Godfrey
}
\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
to fix}
\examples{
plot(x=c(1:20), y=runif(20))
abline(h=0.5)

p = recordPlot()
summary(p)
rm(p)
}
