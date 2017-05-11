\name{hist}
\alias{hist}
\title{Create a standard histogram with a few extra elements added to the output object}
\description{This function is a wrapper to the standard \code{hist()} function in the \pkg{graphics} package. It adds detail to the stored object so that a better text description can be formulated using the \code{VI()} method in the \pkg{BrailleR} package.}
\usage{
hist(x, ...)
}
\arguments{
  \item{x}{a numeric variable.}
  \item{\dots}{
additional arguments passed on to the plotting function.}
}
\details{
This function masks the function of the same name in the \pkg{graphics} package. Even though the base R implementation does create an object of class histogram, the object does not store all graphical arguments that are passed to the \code{hist()} function. The functionality should be no different at all for anyone who is not using the \code{VI()} function to gain a more detailed text description of the histogram. See the help page for the graphics::hist() function to get a more complete description of histogram creation.}
\value{
An object of class histogram as per the \code{hist()} function from the \pkg{graphics} package, with the addition of any calls to the main title or axis labels.}
\references{
Godfrey, A.J.R. (2013) \sQuote{Statistical Software from a Blind Person's Perspective: R is the Best, but we can make it better}, The R Journal 5(1), pp73-79.
}
\author{
A. Jonathan R. Godfrey
}


\seealso{
The base R implementation of the \code{\link[graphics]{hist}} function should be consulted, using  the entry in the \pkg{\link{graphics}} package
}
\examples{
x=rnorm(1000)
# the stamdard hist function returns
MyHist=graphics::hist(x, xlab="random normal values", main="Example histogram (graphics package)")
#dev.off()
MyHist

# while this version returns
MyHist=hist(x, xlab="random normal values", main="Example histogram (BrailleR package)")
#dev.off()
MyHist

# The VI() method then uses the extra information stored
VI(MyHist)
}
