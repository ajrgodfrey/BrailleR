\name{UpdateGraph}
\alias{UpdateGraph}
\alias{Main}
\alias{update.fittedlineplot}
\alias{update.scatterplot}
\alias{update.tsplot}
\alias{XLab}
\alias{YLab}
\title{extract or alter graph parameters}
\description{Either grabs the specified label or sets it to a newly specified value. In this case the graph is re-drawn and the graph object is updated.}
\usage{
UpdateGraph(object, ...)

Main(graph, label = NULL)

XLab(graph, label = NULL)

YLab(graph, label = NULL)
}
\arguments{
  \item{graph,object}{The graph object to be updated.}
  \item{label}{the text to be used in place of the current text label. Use of the default NULL leads to the extraction of the current value and no updating is done.}
\item{...}{the set of parameters to be altered.}
}
\details{
Specify the label to be an empty text string if the desire is to delete the current label.}
\value{The graph object will be updated in the global environment if a new value is assigned.}
\author{A. Jonathan R. Godfrey}
\examples{
attach(airquality)
op = par(mfcol=c(3,2))
test1 = TimeSeriesPlot(Wind, col=4)
XLab(test1, "Day")
# check the change is permanent by doing another change
test1 %>% Main("titles are important") # nice that the pipe works!

test2 = TimeSeriesPlot(Ozone)
# using the update method
update(test2, main="important title", sub="subtitles aren't always present", ylab="Ozone (ppb)") 
# finally, change the graph to use different plotting characters/line types
update(test2) # to fix
par(op)
detach(airquality)
}
