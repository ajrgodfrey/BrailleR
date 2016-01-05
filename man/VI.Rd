\name{VI}
\alias{VI}
\alias{VI.default}
\alias{VI.aov}
\alias{VI.boxplot}
\alias{VI.data.frame}
\alias{VI.dotplot}
\alias{VI.histogram}
\alias{VI.hist}
\alias{VI.list}
\alias{VI.lm}
\alias{VI.matrix}
\alias{VI.summary.lm}
\alias{VI.TukeyHSD}
\title{
Methods to help vision impaired users
}
\description{
A set of methods that extract the most relevant information from a graphical object (or implied set of graphical objects) and display the interpreted results in text or HTML form.

The method includes representations of summary methods that are more suitable for blind users. For example, the method for a data.frame uses a single line for each variable instead of the normal column layout used by the \code{summary} method.
}
\usage{
VI(x)

\method{VI}{histogram}(x)

\method{VI}{aov}(x)

\method{VI}{lm}(x)
}
\arguments{
  \item{x}{any \R object}
}
\details{
This is the general help page for the VI() functionality. Specific help pages will be created if the ability to alter the outcome through user input warrants. See below for more detail on these.


Further methods can be written by users (blind or sighted). Please submit to the package maintainer for possible inclusion in subsequent releases of the package.
}
\value{
This will vary according to the needs of vision impaired users and the specific objects that need to be interpretted.

In general, the output is a series of text strings printed in the console/terminal window in addition to the embedded command's normal functionality. The \code{VI.lm()} method is the first to move away from this idea and use a process that builds on the \code{UniDesc()} function. In this case, the method creates an R markdown file and compiles it into HTML. The HTML document is opened if the R session is interactive.

These functions do not create objects as do many \R commands. Manipulations on the objects created by regular \R expressions will need those regular expressions issued in addition to those of the VI family of functions. The \code{VI.lm()} method does create objects in the current workspace and then deletes them once the HTML document is compiled.
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
rm(RandomX)
VI(PlottedFig)
rm(PlottedFig)
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
