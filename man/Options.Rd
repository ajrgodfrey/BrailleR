\name{Options}
\alias{GoBlind}
\alias{GoSighted}
\alias{GoAdvanced}
\alias{GoNovice}
\alias{LatexOn}
\alias{LatexOff}
\alias{ViewOn}
\alias{ViewOff}
\title{Set package options}
\description{
A set of convenience functions to alter the settings that control how much output is generated and displayed by other  \pkg{BrailleR} functions.
}
\usage{
GoBlind()
GoSighted()


GoAdvanced()
GoNovice()

LatexOn()
LatexOff()

ViewOn()
ViewOff()
}
\details{
The function names should be fairly self explanatory. \code{GoBlind()} and \code{GoSighted()} control use of the \code{VI()} method  which provides extra information about graphical objects for the assistance of blind users; \code{GoAdvanced} (less verbose) and \code{GoNovice()} (more verbose)  control how much output a user will be given;  \code{ViewOn()} and \code{ViewOff()} are for the automatic opening of \code{HTML} pages created by \pkg{BrailleR} functions; and \code{LatexOn()} and \code{LatexOff()} control the production of tables into LaTeX via the \pkg{xtable} package.
}
\value{
Nothing is returned. These functions are only used for their side effects.
}
\author{
A. Jonathan R. Godfrey
}


\seealso{
See these settings applied as default arguments to \code{\link{UniDesc}}
}
