\name{CleanCSV}
\alias{CleanCSV}
\title{clean out unwanted white space from a  csv file}
\usage{
CleanCSV(file)
}
\arguments{
\item{file}{A vector of files to be checked}
}
\value{
NULL. This function only affects external files.
}
\description{
A blind user may not see the white space characters surrounding text or numbers in a  csv file. These corrupt analyses and are annoying to fix.
}
\details{
Spits out the csv file in clean form, as well as a back up copy of the original file.
}
\author{
A. Jonathan R. Godfrey
}

