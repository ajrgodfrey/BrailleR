\name{AddXMLMethod}
\alias{AddXML}
\alias{AddXML.default}
\alias{AddXML.boxplot}
\alias{AddXML.dotplot}
\alias{AddXML.eulerr}
\alias{AddXML.ggplot}
\alias{AddXML.histogram}
\alias{AddXML.scatterplot}
\alias{AddXML.tsplot}

\title{Create XML files to sit alongside SVG files in order to make an accessible graph experience.}
\description{Creates the necessary XML file for a graph object (as long as it has a class assigned)}
\usage{
AddXML(x, file)
}
\arguments{
  \item{x}{a graph object for which a method exists}
  \item{file}{The XML file to be created.}
}
\details{
It will create a xml file which has useful information for creating a accessible svg graph experience. However for it to work properly the \code{SVGThis} and \code{BrowseSVG} function must also be used. As can be seen in the examples it takes a bit of verbose code to use this function. To create easy exploration webpages of a graph use \code{MakeAccessibleSVG}.
}
\value{NULL. This function is solely for the purpose of creating XML files in the current working directory or in a path of the user's choosing.}
\references{
P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second edition. W3C recommendation, W3C. http://www.w3.org/TR/2011/REC-XML11-20110816/
}
\author{Volker Sorge, A. Jonathan R. Godfrey and James Thompson}

\examples{
library(ggplot2)
library(grid)

# Create a simple histogram plot
simpleHist = data.frame(x=rnorm(1e2)) |>
  ggplot(aes(x=x)) +
  geom_histogram()

# Open a new PDF device, but
#discard the output instead of saving it to a file
pdf(NULL)

# Plot the ggplot object on the current device
simpleHist

# Force the plot to be drawn on the device,
#even though the output is being discarded
grid.force()

# Export the plot to an XML file
AddXML(simpleHist, file = "histogram.xml")

# Close the current PDF graphic device
dev.off()

}

\seealso{
  \code{\link{MakeAccessibleSVG}}
}
