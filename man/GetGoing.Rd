\name{GetGoing}
\alias{GetGoing}
\alias{GetingStarted}
\title{Set options for using BrailleR}
\description{An interactive question-and-answer interface suitable for blind users wanting to set the options for using the BrailleR package.}
\usage{
GetGoing()
}
\details{Defaults are offered for all questions so that pressing <Enter> means no changes are made. Users answer yes/no questions as TRUE or FALSE respectively; the short form T or F is also allowed. 

The user can also choose to perform various setup tasks using this interface.}
\value{NULL. This function is a tool for executing other functions that will set options and setup the package according to the user's wants.}
\author{A. Jonathan R. Godfrey}
\seealso{All options being set through this function have specific functions that achieve the same ends. For example, see \code{\link{GoSighted}} for the options that are binary settings, or \code{\link{SetAuthor}} for options requiring a specific character or numeric value to be chosen.

The setup functionality can be reviewed at \code{\link{MakeBatch}}. }
