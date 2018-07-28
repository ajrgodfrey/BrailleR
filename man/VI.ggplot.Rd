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
Returns a structure containing a hierarchical representation of the graph as well as the text description as a character vector.  When run interactively, the text
description is printed.
}
\description{
Prints a textual description of a graph produced by ggplot or qplot.
}
\note{
This function is experimental.  The ggplot2 package produces many different types
of graphs and offers many options for modifying the graph appearance. Not all
options have been fully catered for, so text descriptions of these graphs may still be less complete than those created using base graphics, or may be 
misleading in some circumstances.
}
\examples{
if(require(ggplot2)){
g = ggplot(economics_long, aes(date, value01, colour = variable))
g = g + geom_line() + ggtitle('dummy title')
VI(g)
g
}
}
\author{
Debra Warren, Tony Hirst and A. Jonathan R. Godfrey
}

