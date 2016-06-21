\name{AutoSpellCheck}
\alias{AutoSpellCheck}
\title{Automatic fixing of typos}
\usage{
AutoSpellCheck(file)
}
\arguments{
\item{file}{A vector of files to be checked}
}
\value{
NULL. This function only affects external files.
}
\description{
Fix up all those annoying typos that come up far too often.
}
\details{
The word list of typos and their corrections is called \file{AutoSpellList.csv} and is stored in the user's MyBrailleR folder. The file can be updated to meet the user's specific needs. It should not be over-written by a new installation of BrailleR.
}

