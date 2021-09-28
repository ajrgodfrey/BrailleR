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
\description{Converts a graph object (as long as it has a class assigned) or the current graph window to an SVG file that can be viewed using a browser (not IE) or the  Tiger Player software available from ViewPlus Inc. At present, the SVG needs manual editing using the Tiger Transformer software before viewing in the Tiger Player.}
\usage{
SVGThis(x, file = "test.svg", ...)}
\arguments{
  \item{x}{a graph object for which a method exists, or the current graphics device if set to NULL.}
  \item{file}{The SVG file to be created.}
  \item{...}{Arguments to be passed to the methods.}
}
\details{
The Cairo SVG device found in the \pkg{gr.devices} package does not create a structured SVG file that includes the semantics of the graphic being displayed. The SVG created by the \pkg{gridSVG} package does meet this need, but only works on graphs drawn using the \pkg{grid} package. Any graph created using functions from the more common \pkg{graphics} package can be converted to the \pkg{grid} package system using the \pkg{gridGraphics} package.

The \code{SVGThis.ggplot} method accepts argument \code{createDevice} (default TRUE) - if true the method creates its own null pdf device to draw the graph on, if false it draws on the current device.}
\value{NULL. This function is solely for the purpose of creating SVG files in the current working directory or in a path of the user's choosing.}
\references{
P. Murrell and S. Potter (2014) \dQuote{{The \pkg{gridSVG} package}} The R Journal 6/1, pp. 133-143. http://journal.r-project.org/archive/2014-1/RJournal_2014-1_murrell-potter.pdf

P. Murrell (2015) \dQuote{The {\pkg{gridGraphics}} package},
  The R Journal 7/1 pp. 151-162. http://journal.r-project.org/archive/2015-1/murrell.pdf

P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second edition. W3C recommendation, W3C. http://www.w3.org/TR/2011/REC-SVG11-20110816/
}
\author{A. Jonathan R. Godfrey and Paul Murrell}
