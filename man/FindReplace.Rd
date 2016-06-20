\name{FindReplace}
\alias{FindReplace}
\title{Find/Replace text in a file}
\usage{
FindReplace(file, find, replace)
}
\arguments{
\item{file}{The external (text) file to be updated.}

\item{find}{The text to remove.}

\item{replace}{The text to insert.}
}
\value{
NULL; this function is purely intended for use on an external file.
}
\description{
A simple wrapper function to make it easier to replace the text in a file, perhaps due to spelling errors.
}
\details{
Obviously the file must exist for this function to work.
}
\author{
A. Jonathan R. Godfrey
}

