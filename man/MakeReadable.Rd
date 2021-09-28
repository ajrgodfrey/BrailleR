\name{MakeReadable}
\alias{MakeReadable}
\title{Convert line breaks in vignette documentation}
\usage{
MakeReadable(pkg)
}
\arguments{
\item{pkg}{The package to investigate for vignette source files.}
}
\value{
Nothing in the workspace. All files are stored in a vignettes folder within MyBrailleR.
}
\description{
The Rnw files used for vignettes use Linux style line breaks that make reading vignette source files difficult for Windows users. A Python script is called which converts the line breaks and saves the vignette source in the user's MyBrailleR folder.
}
\details{
Must have Python 3.8 installed for this function to work.
}
\author{
A. Jonathan R. Godfrey
}

