\name{UpdateGraph}
\alias{UpdateGraph}
\alias{main}
\alias{update.fittedlineplot}
\alias{update.scatterplot}
\alias{update.tsplot}
\alias{xlab}
\alias{ylab}
\title{extract or alter graph parameters}
\description{Either grabs the specified label or sets it to a newly specified value. In this case the graph is re-drawn and the graph object is updated.}
\usage{
UpdateGraph(object, ...)

main(graph, label = NULL)

xlab(graph, label = NULL)

ylab(graph, label = NULL)
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
