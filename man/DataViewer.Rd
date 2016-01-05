\name{DataViewer}
\alias{DataViewer}
\title{Open a data object in your chosen spreadsheet software}
\description{
The chosen data object (data.frame, matrix, or vector) is stored in a temporary csv file. The file is opened while the R terminal/console is suspended until the <enter> key is pressed. This should be done once the spreadsheet software has been closed so that the temporary file is removed and the data object gets updated from the edited csv file. The user must save the csv file if changes are made.}
\usage{
DataViewer(x, Update = FALSE, New = NULL, Filename = NULL)
}
\arguments{
  \item{x}{an object of class data.frame, matrix, or vector. A check is made for this condition.}
  \item{Update}{Logical. Will changes made in the spreadsheet editor be returned to the R session.}
  \item{New}{If Update=TRUE, the original object will be replaced unless a name for a new object is given. N.B. the default is to overwrite the original object.}
  \item{Filename}{Provide a filename if desired. N.B. this does not guarantee that the csv file will be kept. Do not use this function as a shortcut for saving csv files.}
}
\details{The following steps should be taken if the intention is to view and possibly edit a data.frame, matrix, or vector:

There are a few quirks with respect to variables that could be interpreted as factors. The process of updating is to write a csv file using code \link{write.csv}() and then read it back using code \link{read.csv}() after it has been edited. Users must be aware that factors may not register as such, or that character vectors may be interpreted as factors.
}
\value{If code Update=TRUE and code New=NULL, the original data object is overwritten. To create a new object the user mustspecify  code New.}
\author{A. Jonathan R. Godfrey \email{a.j.godfrey@massey.ac.nz}}
\examples{
data(airquality)
DataViewer(airquality, Update=TRUE, New="NewAirQuality")
# remove the new object using rm()
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
