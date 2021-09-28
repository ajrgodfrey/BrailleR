\name{MakeAccessibleSVGMethod}
\alias{MakeAccessibleSVG}
\alias{MakeAccessibleSVG.default}
\alias{MakeAccessibleSVG.ggplot}
\alias{MakeAccessibleSVG.histogram}
\alias{MakeAccessibleSVG.scatterplot}
\alias{MakeAccessibleSVG.tsplot}

\title{Create matched pairs of SVG and XML files to make an accessible graph experience.}
\description{Creates the necessary SVG and XML files for a graph object (as long as it has a class assigned) or the current graph window.}
\usage{
MakeAccessibleSVG(x, file = "test", view = interactive(), ...)
}
\arguments{
  \item{x}{a graph object for which a method exists, or the current graphics device if set to NULL.}
  \item{file}{The shared name for the SVG and XML files to be created.}
  \item{view}{launch in browser; this is the default when in interactive session}
  \item{...}{arguments passed on to other methods/functions}
}
\details{
This is experimental work. Having started with the proof of concept based on a fairly standard histogram from the \pkg{graphics} package, we are now looking to the boxplots and time series plots.
}
\value{NULL. This function is solely for the purpose of creating SVG and XML files in the current working directory or in a path of the user's choosing.}
\references{
P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second edition. W3C recommendation, W3C. http://www.w3.org/TR/2011/REC-XML11-20110816/
}
\author{A. Jonathan R. Godfrey and Volker Sorge}
