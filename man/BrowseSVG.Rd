\name{BrowseSVG}
\alias{BrowseSVG}

\title{Launches a browser tab to explore SVG diagram}
\description{Creates a single HTML file that embeds an SVG diagram and
  its XML annotations. Then launches a browser tab to allow viewing and
  interactive exploration of the SVG diagram.}
\usage{
BrowseSVG(file="test", dir=".", key=TRUE, footer = TRUE, view=interactive()) 
}
\arguments{
  \item{file}{the filename for the HTML file; this should correspond to
    basename of an existing SVG and its XML annotations}
  \item{dir}{the folder into which the HTML file is written and where R tries to
    locate the SVG and XML files}
  \item{key}{include key for explorer's keyboard commands in webpage}
  \item{footer}{Volker, explain please.}
  \item{view}{launch in browser; this is the default when running in an interactive
  session}
}
\details{
  An HTML file is written in the given directory and the Javascript library
  is copied to that location.}
\value{
NULL. This function exists for its side effects only.
}
\references{
to add following first demonstration/publication
}
\author{
Volker Sorge
}


