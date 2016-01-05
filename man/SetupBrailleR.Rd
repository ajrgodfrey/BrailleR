
\name{SetupBrailleR}
\alias{SetupBrailleR}
\title{Establish the BrailleR folder for the user}
\usage{
SetupBrailleR()
}
\value{
The path to the folder is returned invisibly.
}
\description{
Creates a permanent folder if the user agrees or a temporary one otherwise.
}
\details{
The user can establish a permanent folder if the BrailleR package is loaded in an interactive session. If only used in batch mode, the user will get a new temporary folder each time and the default BrailleR settings will be used instead.
}
\author{
A. Jonathan R. Godfrey with suggestions from Henrik Bengtsson.
}

