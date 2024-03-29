\name{MakeAllFormats}
\alias{MakeAllFormats}
\title{Prepare the options for conversion of an R markdown file.}
\usage{
MakeAllFormats(RmdFile, BibFile = "")
}
\arguments{
\item{RmdFile}{The name of the R markdown file to be converted.}

\item{BibFile}{Name of the bibtex database file to include.}
}
\value{
Nothing in the R console/terminal. The function is used for its side effects in the working directory.
}
\description{
Make a pandoc options file for use with a named R markdown file.
}
\details{
The options are based on the current best set of possible outcomes. The two html file options use different representations of any mathematical equations. The Microsoft Word file uses the native equation format which is not accessible for blind people using screen readers.
}
\author{
A. Jonathan R. Godfrey.
}
