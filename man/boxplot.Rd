\name{boxplot}
\alias{boxplot}
\title{Create a standard boxplot with a few extra elements added to the output object}
\description{This function is a wrapper to the standard \code{boxplot()} function in the \pkg{graphics} package. It adds detail to the stored object so that a better text description can be formulated using the \code{VI()} method in the \pkg{BrailleR} package.}
\usage{
boxplot(x, ...)
}
\arguments{
  \item{x}{a numeric variable.}
  \item{\dots}{
additional arguments passed on to the plotting function.}
}
\details{
This function masks the function of the same name in the \pkg{graphics} package. The base R implementation does create an object, but does not give it a class attribute, the object does not store all graphical arguments that are passed to the \code{boxplot()} function. The functionality should be no different at all for anyone who is not using the \code{VI()} function to gain a more detailed text description of the boxplot. See the help page for the \code{graphics::boxplot()} function to get a more complete description of boxplot creation.}
\value{
An object of class boxplot. This class is just a placeholder for the contents of the object used to create a boxplot which would otherwise not be stored in a usable format. The class is not intended for the user; it is a tool that enables the BrailleR package to deliver a readable text version of the plot.
}
\references{
The problem of not including class attributes for graphs was identified in: 
Godfrey, A.J.R. (2013) \sQuote{Statistical Software from a Blind Person's Perspective: R is the Best, but we can make it better}, The R Journal 5(1), pp73-79.
}
\author{A. Jonathan R. Godfrey}
\note{
I would love to see this function become redundant. This will happen if the extra functionality is included in the \code{boxplot()} function in the \pkg{graphics} package. This should be possible as the user experience will not be any different, no matter if the user is blind or sighted.
}

\seealso{
The base R implementation of the \code{\link[graphics]{boxplot}} function should be consulted; see the entry in the \pkg{\link{graphics}} package
}
\examples{
x=rnorm(1000)
op = par(mfcol=c(2,1))
# the stamdard boxplot function returns
MyBoxplot=graphics::boxplot(x, main="Example boxplot (graphics package)", horizontal=TRUE)
MyBoxplot

# while this version returns
MyBoxplot=boxplot(x, main="Example boxplot (BrailleR package)", horizontal=TRUE)
MyBoxplot
par(op)

# The VI() method then uses the extra information stored
VI(MyBoxplot)
}
