\name{FindReplace}
\alias{FindReplace}
\alias{UseTemplate}
\title{Find/Replace text in a file}
\usage{
FindReplace(file, find, replace)
}
\arguments{
\item{file}{The external (text) file or template to be updated.}

\item{find}{The text to remove.}

\item{replace}{The text to insert.}
}
\value{
The FindReplace function is purely intended for use on an external file whereas UseTemplate is intended to take a template file and return the updated text to the calling environment.
}
\description{
Simple wrapper functions to make it easier to replace the text in a file, possibly due to spelling errors, but perhaps to replace default text in a template file.
}
\details{
Obviously the file must exist for this function to work.
}
\author{
A. Jonathan R. Godfrey
}

