\name{BrowseSVG}
\alias{BrowseSVG}

\title{Merge svg and xml file in html file}
\description{Creates a single HTML file that embeds an SVG diagram and
  its XML annotations. Then launches a browser tab to allow viewing and
  interactive exploration of the SVG diagram.}
\usage{
BrowseSVG(file="test", key=TRUE, footer = TRUE, view=interactive()) 
}
\arguments{
  \item{file}{the filename for the HTML file; this should correspond to
    basename of an existing SVG and its XML annotations}
  \item{key}{include key for explorer's keyboard commands in webpage}
  \item{footer}{Whether the footer should be showed at bottom of webpage}
  \item{view}{launch in browser; this is the default when running in an interactive
  session}
}
\details{
  A HTML file is written in the current working directory. This HTML file will have the embeded svg and xml files as well as the javascript to help with the exploration of the graph. Note that it is required that you already have a svg and xml file in the current directory for it to work.}
\value{
NULL. This function exists for its side effects only.
}
\author{
Volker Sorge and James A. Thompson
}

\examples{
library(ggplot2)
simpleHist = data.frame(x=rnorm(1e2)) |>
  ggplot(aes(x=x)) +
    geom_histogram()
file = "histogram"
pdf(NULL)  # create non-displaying graphics device for SVGThis and AddXML
svgfile = SVGThis(simpleHist, paste0(file, ".svg"),createDevice=FALSE)
xmlfile = AddXML(simpleHist, paste0(file, ".xml")) 
dev.off()  # destroy graphics device, now that we're done with it

BrowseSVG(file)

#Cleaing up from BrowseSVG
unlink(paste0(file, ".svg"))
unlink(paste0(file, ".xml"))
unlink(paste0(file, ".html"))
}

\seealso{
  \code{\link{MakeAccessibleSVG}, \link{SVGThis}, \link{AddXML}}
}
