\name{VI.ggplot}
\alias{VI.ggplot}
\alias{print.VIgraph}
\title{VI for graphs created using ggplot2}
\usage{
\method{VI}{ggplot}(x, Describe=FALSE, threshold=10, 
   template=system.file("whisker/VIdefault.txt", package="BrailleR"),
   ...)
}
\arguments{
\item{x}{an object created by ggplot() or qplot() from the ggplot2 package which therefore has class gg or ggplot.}
\item{Describe}{Should the Describe function be called at the same time. Not currently implemented for ggplot objects.}
\item{threshold}{Maximum number of data items that should be individually listed in the output.}
\item{template}{Template file, in mustache format, to be used in creating the text}
\item{...}{other arguments, currently ignored}
}
\value{
A text description is printed out as a side effect. Returns a structure containing a hierarchical representation of the graph as well as the text description as a character vector.
}
\description{
The popular ggplot2 package creates graphs using many default settings and it is unlikely that all ramifications of using this package will be understood by reading the code alone. Text descriptions of these graphs may still be less complete than those created using base graphics.
}
\details{
Still lots to do with this functionality. The theme of the graph may prove important to blind users although less interesting to the creation of purely text alternatives of the graphs.
}
\examples{
if(require(ggplot2)){
g = ggplot(economics_long, aes(date, value01, colour = variable))
g = g + geom_line() + ggtitle('dummy title')
VI.ggplot(g)
g
}
}
\author{
A. Jonathan R. Godfrey, Tony Hirst and Debra Warren
}

