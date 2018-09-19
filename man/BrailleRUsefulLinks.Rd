\name{BrailleRUsefulLinks}
\alias{BrailleRHome}
\alias{BrailleRInAction}
\alias{LURN}
\alias{Google}
\alias{google}
\alias{R4DS}
\alias{r4ds}
\title{Open the home page for the BrailleR Project, the Google search engine, the BrailleR in Action book, or the Let's Use R Now (LURN) book in your browser}
\usage{
BrailleRHome()

BrailleRInAction()

LURN(BlindVersion = getOption("BrailleR.VI"))

Google()
google()

R4DS()
r4ds()
}
\arguments{
\item{BlindVersion}{Use the version of Let's Use R Now tailored to an audience of blind users.}
}
\value{
NULL. These functions are for opening a web page and nothing will result in the R session.
}
\description{
Visit the BrailleR Project home page for updates, instructions on how to join the mailing list which we call BlindRUG and get the latest downloads; or the Let's Use R Now (LURN) home page to read an online manual for using R. Other commonly used websites can be accessed quickly from the R prompt using the other convenience functions.
}
\author{
A. Jonathan R. Godfrey
}

\details{Google  is a key resource, and so should be the R for Data Science book.}