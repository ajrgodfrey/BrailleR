\name{AddXMLMethod}
\alias{AddXML}
\alias{AddXML.default}
\alias{AddXML.boxplot}
\alias{AddXML.dotplot}
\alias{AddXML.ggplot}
\alias{AddXML.histogram}

\title{Create XML files to sit alongside SVG files in order to make an accessible graph experience.}
\description{Creates the necessary XML file for a graph object (as long as it has a class assigned) or the current graph window.}
\usage{
AddXML(x, file)
}
\arguments{
  \item{x}{a graph object for which a method exists, or the current graphics device if set to NULL.}
  \item{file}{The XML file to be created.}
}
\details{
This is experimental work. At present, the proof of concept is based ona fairly standard histogram from the \pkg{graphics} package.
}
\value{NULL. This function is solely for the purpose of creating XML files in the current working directory or in a path of the user's choosing.}
\references{
P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second edition. W3C recommendation, W3C. http://www.w3.org/TR/2011/REC-XML11-20110816/
}
\author{Volker Sorge and A. Jonathan R. Godfrey}
\examples{
x=rnorm(1000)
#AddXML(hist(x))
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
