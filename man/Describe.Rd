\name{Describe}
\alias{Describe}
\alias{Describe.default}
\alias{Describe.aov}
\alias{Describe.boxplot}
\alias{Describe.dotplot}
\alias{Describe.histogram}
\alias{Describe.lm}
\alias{Describe.matrix}
\alias{Describe.scatterplot}
\alias{Describe.summary.lm}
\alias{Describe.tsplot}
\alias{Describe.TukeyHSD}
\alias{Describe.ggplot}
\alias{print.description}
\alias{print.multiDescription}

\title{
Describe method to help visualize plot types.
}
\description{
A function to help describe what a graph model would look like, to a vision impaired person.
}
\usage{
Describe(x, VI=FALSE, ...)

\method{Describe}{histogram}(x, VI=TRUE, ...)

\method{Describe}{ggplot}(x,VI=FALSE, whichLayer=NULL, ...)
}
\arguments{
\item{x}{any \R object}
\item{VI}{Should \code{\link{VI()}} be called at the same time}
\item{whichLayer}{Only used with Describe.ggplot, if NULL will either display the layer if ggplot has one layer, ask user for input if it is an interactive session or print out all of the layers}
\item{...}{other arguments, currently ignored}
}
\details{
Describe() is for explaining how a given type of graph appears to a sighted person and is intended for use by blind people who do not know how the graph looks. There is room to add hints for displaying the graphs in a more visually appealing manner.

The text description will only be generic to the plot type and not specific information for specific information see \code{\link{VI()}}.

Unlike \code{\link{VI()}} and ggplot Describe needs to be explicitly called to show its output.
}
\value{
A description in the format of a list. It will ahve the title, general info and RHints. If multiple layers of a ggplot are being described then it will be a list of descriptions for each layer.
}
\author{
A. Jonathan R. Godfrey and James A. Thompson
}

\examples{
# Base R
scatter = FittedLinePlot(NULL, x = rnorm(1e2), y = rnorm(1e2))
Describe(scatter)
hist = hist(rnorm(1e3))
Describe(hist)

# ggplot
simplePoint = ggplot(NULL, aes(rnorm(1e2), rnorm(1e2))) +
  geom_point()
Describe(simplePoint)
}