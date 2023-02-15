\name{SVGThis}
\alias{SVGThis}
\alias{SVGThis.default}
\alias{SVGThis.boxplot}
\alias{SVGThis.dotplot}
\alias{SVGThis.eulerr}
\alias{SVGThis.ggplot}
\alias{SVGThis.histogram}
\alias{SVGThis.scatterplot}
\alias{SVGThis.tsplot}
\alias{MakeTigerReady}
\alias{addInfo}

\title{Save commonly used graphs as structured SVG files.}
\description{Converts a graph object (as long as it has a class assigned) to an SVG file that can be viewed using a browser (not IE). At present, the SVG needs manual editing using the Tiger Transformer software before viewing in the Tiger Player.}
\usage{
SVGThis(x, file = "test.svg", ...)
\method{SVGThis}{ggplot}(x, file = "test.svg", createDevice = TRUE, ...)
}
\arguments{
  \item{x}{a graph object for which a method exists}
  \item{file}{The SVG file to be created.}
  \item{createDevice}{Whether this function should creates it own none displaying device and print the graph on it. If FALSE will print the graph on the current device.}
  \item{...}{Arguments to be passed to the methods.}
}

\details{
Most of the work of the function is done \code{gridSVG::grid.export} function. After this there is a rewrite of the SVG so that it can work better with the XML and create a easy accessible experience of the graph.

The produced SVG can also be used as just that a SVG. However note that quite possibly some rewriting will of been done. The rewriting does not change how the graph looks.

To view your graph as a accessible svg you can use the \code{MakeAccessibleSVG()} function.

The Cairo SVG device found in the \pkg{gr.devices} package does not create a structured SVG file that includes the semantics of the graphic being displayed. The SVG created by the \pkg{gridSVG} package does meet this need, but only works on graphs drawn using the \pkg{grid} package. Any graph created using functions from the more common \pkg{graphics} package can be converted to the \pkg{grid} package system using the \pkg{gridGraphics} package.
}

\value{NULL. This function is solely for the purpose of creating SVG files in the current working directory or in a path of the user's choosing.}

\references{
P. Murrell and S. Potter (2014) \dQuote{{The \pkg{gridSVG} package}} The R Journal 6/1, pp. 133-143. http://journal.r-project.org/archive/2014-1/RJournal_2014-1_murrell-potter.pdf

P. Murrell (2015) \dQuote{The {\pkg{gridGraphics}} package},
  The R Journal 7/1 pp. 151-162. http://journal.r-project.org/archive/2015-1/murrell.pdf

P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second edition. W3C recommendation, W3C. http://www.w3.org/TR/2011/REC-SVG11-20110816/
}
\author{A. Jonathan R. Godfrey, Paul Murrell and James Thompson}

\examples{
# Save a custom ggplot object to an SVG file
library(ggplot2)
p = ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
SVGThis(p)

# Cleaning up afterwards
unlink("test.svg")
}

\seealso{
  \code{\link{MakeAccessibleSVG}}
}
