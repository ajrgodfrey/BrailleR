\name{ViewSVG}
\alias{ViewSVG}

\title{Create the necessary files to allow interactive viewing of SVG}
\description{Copy files from the package folders to the current working directory and write a markdown file that contains the links to all accessible SVG files in the current directory.}
\usage{
ViewSVG(file = "index")
}
\arguments{
  \item{file}{The file basename to be used. This file will be made in the current directory.}
}
\details{
This will create a html file that has a list of the available svg in the current directory. This only supports the current working directory at the moment. However this is planned on changing in the future. To make the functions you can use the \code{MakeAccessibleSVG()}} function
\value{
NULL. This function exists for its  side effects only.
}
\references{
Godfrey, A.J.R. (2013) \sQuote{Statistical Software from a Blind Person's Perspective: R is the Best, but we can make it better}, The R Journal 5(1), pp73-79.
}
\author{
A. Jonathan R. Godfrey and James A. Thompson
}

\examples{
library(ggplot2)

# Make a few svg webpages
tsplot = TimeSeriesPlot(airquality, x=airquality$Temp)
MakeAccessibleSVG(tsplot, file = "tsplot")

barChart = ggplot(Orange, aes(x = Tree)) +
  geom_bar()
MakeAccessibleSVG(barChart, file = "barChart")

histogram = ggplot(attenu, aes(x=dist)) +
geom_histogram()
  histogram
MakeAccessibleSVG(histogram, file="histogram")

# Display the 'home' page
ViewSVG()
}