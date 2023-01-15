\name{MakeAccessibleSVGMethod}
\alias{MakeAccessibleSVG}
\alias{MakeAccessibleSVG.default}
\alias{MakeAccessibleSVG.ggplot}
\alias{MakeAccessibleSVG.histogram}
\alias{MakeAccessibleSVG.scatterplot}
\alias{MakeAccessibleSVG.tsplot}

\title{Create and display a accessible exploration webpage SVG of graph}
\description{Creates the necessary SVG and XML files for a graph object (as long as it has a class assigned). Then turns them into a html file and opens it for viewing (if a interactive session) in your browser.}
\usage{
MakeAccessibleSVG(x, file = "test", view=interactive(), cleanup = TRUE, ...)
}
\arguments{
  \item{x}{a graph object for which a method exists}
  \item{file}{The shared name for the SVG and XML files to be created.}
  \item{view}{launch in browser; this is the default when in interactive session}
  \item{cleanup}{Whether the function should remove the svg and xml files after they have bee embedded into the hmtml file.}
  \item{...}{arguments passed on to other methods/functions}
}
\details{
This is experimental work. It works for some baseplots like Boxplots, Histograms and Scatter plots. In ggplot it only works with geom_line and geom_bar (this includes histograms and geom_cols) for ggplot. This function can be thought of as just a shortcut for quickly creating a SVG webpage for exploration. Each individual step can be done with the \code{SVGThis()}, \code{AddXML()} and \code{BrowseSVG()} functions. Using this is currently the quickest workflow for accessing the SVG features of BrailleR.
}
\value{NULL. This function is solely for the purpose of creating SVG and XML files and displaying them}

\examples{
#Base R
#boxplot = boxplot(rnorm(1e4))
#MakeAccessibleSVG(boxplot, view = F)

#attach(airquality)
#scatter = ScatterPlot(x=Wind, y=Ozone, pch=4, base=TRUE)
#detach(airquality)
#MakeAccessibleSVG(scatter)

#ggplot2
library(ggplot2)
tsplot = TimeSeriesPlot(airquality, x=airquality$Temp)
MakeAccessibleSVG(tsplot)

barChart = ggplot(Orange, aes(x = Tree)) +
  geom_bar()
MakeAccessibleSVG(barChart)

histogram = ggplot(attenu, aes(x=dist)) +
geom_histogram()
  histogram
MakeAccessibleSVG(histogram)

# Cleaning up
unlink("test.html")
}

\references{
P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second edition. W3C recommendation, W3C. http://www.w3.org/TR/2011/REC-XML11-20110816/
}

\author{A. Jonathan R. Godfrey, Volker Sorge and James A. Thompson}

\seealso{
  \code{\link{SVGThis}}, \code{\link{AddXML}}, \code{\link{BrowseSVG}}
}