\name{TSPlot}
\alias{TimeSeriesPlot}
\alias{plot.tsplot}
\alias{print.tsplot}

\title{Create a standard time series plot with a few extra elements added to the output object}
\description{This function is a wrapper to the standard \code{plott()} function in the \pkg{graphics} package. It is tailored to generating a time series plot, and adds detail to the stored object so that a better text description can be formulated using the \code{VI()} method in the \pkg{BrailleR} package. The function will become redundant once all other \pkg{BrailleR} functionality is working well with ggplot style graphics.}
\usage{
TimeSeriesPlot(.data, x, time=NULL, base=FALSE, ...)
}
\arguments{
\item{.data}{the data.frame from which variables are drawn. Ignored if using base graphics.}

  \item{x}{a numeric variable. N.B. when using base or non ts data you must explicitly specify them by naming this argument.}
\item{base}{Use base style graphics. Default is to use ggplot2 instead.}

\item{time}{a numeric or date variable. Only used by ggplot. This will be the values plotted along the x axis. If it is left at \code{NULL} then the x axis will be a sequence from 1 to \code{length(x)}}
  \item{\dots}{
additional arguments passed on to the plotting function.}
}
\details{
This function was originally designed to be a wrapper that would draw the base graphics plot for a time series. The saved object can be plotted later with a call to \code{plot}.

From v0.33.0 onwards, the function can complete the original intention, but the ggplot2 package's improved  interaction with BrailleR means this is the now the preferred style of plot. This plot wont be plotted by default so you need to expressly call the plot or print method.}
\value{

Either:

1. An object of class tsplot, with the addition of any calls to the main title or axis labels being explicitly stored even if a zero length character string, or

2. A ggplot object.}
\references{
Godfrey, A.J.R. (2013) \sQuote{Statistical Software from a Blind Person's Perspective: R is the Best, but we can make it better}, The R Journal 5(1), pp73-79.
}
\author{
A. Jonathan R. Godfrey and James A. Thompson
}
\examples{
# with base
attach(airquality)
op = par(mfcol=c(3,2))
plot(as.ts(Wind), ylab="Wind", col=4)
test1 = TimeSeriesPlot(x=Wind, col=4, base=TRUE)
test1 #does the plot method work?
plot(as.ts(Ozone), ylab="Ozone")
test2 = TimeSeriesPlot(x=Ozone, base=TRUE)
test2 # does the plot method work?
par(op)
detach(airquality)

<<<<<<< HEAD
## with ggplot
# basic
basic = TimeSeriesPlot(airquality, x=airquality$Temp)
basic # proves it prints/plots
# ts data
TimeSeriesPlot(UKDriverDeaths,  main = "UK driver deaths", sub = "For January")
TimeSeriesPlot(sunspots, ylab="Number of spots", xlab="Year")
=======
# with ggplot
if(require(ggplot2)){
   basic = TimeSeriesPlot(airquality, x=airquality$Temp)
   basic
   # ts data
   withTitle = TimeSeriesPlot(UKDriverDeaths,  
    main = "UK driver deaths",
    sub = "For the month Januaray")
   withTitle
   withLabs = TimeSeriesPlot(sunspots, ylab="Number of spots", xlab="Year")
   withLabs
}
>>>>>>> 6d4d1fdf3afa7ad005e8eb4c9f791f202afb8533
}
