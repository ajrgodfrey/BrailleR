\name{CheckIt}
\alias{CheckIt}
\alias{WhatIs}
\alias{what_is}
\alias{check_it}
\title{Investigate data objects}
\usage{
CheckIt(x, ...)
check_it(x, ...)

what_is(x, ...)
WhatIs(x, ...)
}
\arguments{
\item{x}{The object to be investigated and passed out again.}

\item{...}{extra parameters to be passed on.}
}
\value{
These functions intentionally return (invisibly of course) the original input object so that they can be used within a pipe chain, as is commonly used by the Tidyverse.
}
\description{
Investigate an object, especially useful  at any stage in a pipe chain.
}
\details{
The VI() functionality returns a character vector and is not useful inside a pipe chain. In effect, WhatIs() just adds the pipe chain convenience to the VI() tool, while CheckIt() looks at the structure of the data object. The latter is perhaps more useful if you are uncertain that the pipe chain is delivering what you hoped for.
}
\examples{
require(dplyr)
airquality \%>\% CheckIt() \%>\% arrange(Ozone) \%>\% head()

}
\author{
A. Jonathan R. Godfrey
}
