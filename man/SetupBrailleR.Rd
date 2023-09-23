
\name{SetupBrailleR}
\alias{SetupBrailleR}
\alias(MyBrailleR)
\title{Establish or open the BrailleR folder for the user}
\usage{
SetupBrailleR()

MyBrailleR()
}
\value{
The path to the folder is returned invisibly.
}
\description{
Creates a permanent folder called MyBrailleR if the user agrees. Windows users can open this file easily using MyBrailleR().
}
\details{
The user can establish a permanent MyBrailleR folder if the BrailleR package is loaded in an interactive session. If only used in batch mode, the user will only be able to use the default BrailleR settings.
}
\author{
A. Jonathan R. Godfrey with suggestions from Henrik Bengtsson and Brian Ripley.
}

