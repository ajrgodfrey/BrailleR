\name{VI}
\alias{VI.ggplot}
\alias{print.VIgraph}
\alias{print.VI}
\alias{VI}
\alias{VI.default}
\alias{VI.aov}
\alias{VI.boxplot}
\alias{VI.data.frame}
\alias{VI.dotplot}
\alias{VI.histogram}
\alias{VI.hist}
\alias{VI.htest}
\alias{VI.list}
\alias{VI.lm}
\alias{VI.matrix}
\alias{VI.qcc}
\alias{VI.summary.lm}
\alias{VI.tsplot}
\alias{VI.TukeyHSD}
\title{
Extract information from a graphical object
}
\description{
A method that extracts the most relevant information from a graphical object (or implied set of graphical objects) and display the interpreted results in text or HTML form.

The method includes representations of summary methods that are more suitable for blind users. For example, the method for a data.frame uses a single line for each variable instead of the normal column layout used by the \code{summary} method.
}
\usage{
VI(x, Describe=FALSE, ...)

\method{VI}{histogram}(x, Describe=FALSE, ...)

\method{VI}{aov}(x, Describe=FALSE, ...)

\method{VI}{htest}(x, Describe=FALSE, digits = getOption("digits"),  ...) 

\method{VI}{lm}(x, Describe=FALSE, ...)

\method{VI}{ggplot}(x, Describe=FALSE, threshold=10, 
   template=system.file("whisker/VIdefault.txt", package="BrailleR"),
   ...)
}
\arguments{
\item{x}{any \R object}
\item{Describe}{Should the \code{\link{Describe()}} function be called at the same time}
\item{digits }{number of decimal places to show}
\item{threshold}{Only for ggplot. Maximum number of data items that should be individually listed in the output.}
\item{template}{Only for ggplot. Template file, in mustache format, to be used in creating the text}
\item{...}{other arguments, currently ignored}
}
\details{
VI() is intended to extract the specific details for the particular graph or output.

It will provide the information as a printout to the console/terminal window.
}
\value{
Nothing is returned when working with most of the functions functionality.

The \code{VI.lm()} method is the first to move away from this idea and use a process that builds on the \code{UniDesc()} function. In this case, the method creates an R markdown file and compiles it into HTML. The HTML document is opened if the R session is interactive.

\code{VI.ggplot} returns a structure containing a hierarchical representation of the graph as well as the text description as a character vector.  When run interactively, the text
description is printed.
}
\note{
The \code{VI.lm} method fails if you use  the one line \code{VI(lm(...))} even if the model is named using \code{VI(Model1 <- lm(...))}. It does work if two explicit commands are used. For example \code{Model1 = lm(...)} followed by \code{VI(Model1)}.

The ggplot2 package contains many layers and not all of them have a VI output yet. However most of the commonly used ones do. Regardless the VI output should be considered experimental with some results being potenitally misleading.
}
\author{
A. Jonathan R. Godfrey, Debra Warren, Sophie Banks, Tony Hirst, Timothy P. Bilton and James A. Thompson
}

\examples{
# Base R
RandomX=rnorm(500)
PlottedFig=hist(RandomX)
VI(PlottedFig)

# ggplot
ggplot(economics_long, aes(date, value01, colour = variable)) +
  geom_line() +
  ggtitle('dummy title')
}
