\name{Embossers}
\alias{Embossers}
\alias{Premier100}
\title{Prepare BrailleR settings for specific braille embossers}
\usage{
Premier100()
}
\value{
Nothing. The functions are only used to set package options.
}
\description{
Convenience functions for setting package options based on experimentation using specific embossers.
}
\details{
These functions are only relevant for owners of the specified embossers. Ownership of these models means the user has access to fonts that are licenced to the user.

The Premier 100 embosser uses standard 11 by 11.5 inch fanfold braille paper. Printing in landscape or portrait is possible.
}
\examples{
#Premier100() #' Specify use of the Premier 100 embosser.
#ChooseEmbosser() #' reset to default: using no embosser.
}
\author{
A. Jonathan R. Godfrey.
}
\seealso{
\code{\link{ChooseEmbosser}}
}

