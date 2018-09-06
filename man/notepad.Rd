\name{Notepad}
\alias{Notepad}
\alias{notepad}
\alias{Explorer}
\alias{explorer}
\alias{cmd}
\alias{CMD}
\title{Open standard Windows tools quickly}
\usage{
Notepad(file = NULL)
}
\arguments{
\item{file}{A character string for the file to be opened; it will be created if it does not yet exist.}
}
\value{
NULL. The functions are for their external effects only. Control is still available in the R console/terminal.
}
\description{
Many standard Windows tools can be opened from the Run dialogue, but this starts them in the standard locations, when R users may want them opened or saved in the current working directory.
}
\details{
If a file specified does not yet exist in the current folder, the standard notepad editor  asks the user if a new file is wanted.
}
\author{
A. Jonathan R. Godfrey
}
