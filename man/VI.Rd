\name{VI}
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
\alias{print.description}
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
Methods to help vision impaired users
}
\description{
A set of methods that extract the most relevant information from a graphical object (or implied set of graphical objects) and display the interpreted results in text or HTML form.

The method includes representations of summary methods that are more suitable for blind users. For example, the method for a data.frame uses a single line for each variable instead of the normal column layout used by the \code{summary} method.
}
\usage{
Describe(x, VI=FALSE, ...)
VI(x, Describe=FALSE, ...)

\method{VI}{histogram}(x, Describe=FALSE, ...)
\method{Describe}{histogram}(x, VI=FALSE, ...)

\method{VI}{aov}(x, Describe=FALSE, ...)

\method{VI}{htest}(x, Describe=FALSE, digits = getOption("digits"),  ...) 


\method{VI}{lm}(x, Describe=FALSE, ...)
}
\arguments{
  \item{x}{any \R object}
\item{Describe,VI}{Should the other function be called at the same time}
\item{digits }{number of decimal places to show}
\item{...}{other arguments, currently ignored}
}
\details{
This is the general help page for the VI() functionality. Specific help pages will be created if the ability to alter the outcome through user input warrants. See below for more detail on these.

Describe() is for explaining how a given type of graph appears to the sighted world and is intended for use by blind people who do not know how that graph looks. There is room to add hints for displaying the graphs in a more visually appealing manner. In contrast, VI() is intended to extract the specific details for the particular graph or output concerned.


Further methods can be written by users (blind or sighted). Please submit to the package maintainer for possible inclusion in subsequent releases of the package.
}
\value{
This will vary according to the needs of vision impaired users and the specific objects that need to be interpreted.

In general, the output from VI() is a series of text strings printed in the console/terminal window in addition to the embedded command's normal functionality. The \code{VI.lm()} method is the first to move away from this idea and use a process that builds on the \code{UniDesc()} function. In this case, the method creates an R markdown file and compiles it into HTML. The HTML document is opened if the R session is interactive.

The VI() functions do not create objects as do many \R commands. Manipulations on the objects created by regular \R expressions will need those regular expressions issued in addition to those of the VI family of functions. The \code{VI.lm()} method does create objects in the current workspace and then deletes them once the HTML document is compiled.

The Describe() family of functions do create an object for passing onto other functions.
}
\note{
The \code{VI.lm} method fails if you use  the one line \code{VI(lm(...))} even if the model is named using \code{VI(Model1 <- lm(...))}. It does work if two explicit commands are used. For example \code{Model1 = lm(...)} followed by \code{VI(Model1)}.
}
\author{
A. Jonathan R. Godfrey and Timothy P. Bilton
}

\examples{
RandomX=rnorm(500)
PlottedFig=hist(RandomX)
VI(PlottedFig)
Describe(PlottedFig)
}
