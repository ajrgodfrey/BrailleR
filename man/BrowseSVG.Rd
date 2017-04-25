\name{BrowseSVG}
\alias{BrowseSVG}

\title{Launches a browser tab to explore SVG diagram}
\description{Creates a single HTML file that embeds an SVG diagram and
  its XML annotations. Then launches a browser tab to allow viewing and
  interactive exploration of the SVG diagram.}
\usage{
BrowseSVG(file="test", dir=".")
}
\arguments{
  \item{file}{the filename for the HTML file; this should correspond to
    basename of an existing SVG and its XML annotations}
  \item{dir}{the in which HTML file is written and where R tries to
    locate the SVG and XML files}
}
\details{
  An HTML file is written in the given directory and the Javascript library
  is copied to that location.}
\value{
NULL. This function exists for its side effects only.
}
\references{
}
\author{
Volker Sorge
}


