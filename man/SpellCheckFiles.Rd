\name{SpellCheckFiles}
\alias{SpellCheckFiles}
\alias{print.wordlist}
\title{Spell checking a file or all files within a specified folder}
\usage{
SpellCheckFiles(file = ".", ignore = character())

\method{print}{wordlist}(x, ...)
}
\arguments{
\item{file}{The filename of an individual file, or an individual folder.}

\item{ignore}{The character vector of words to be ignored by hunspell}

\item{x}{the object to be printed}
\item{...}{other parameters pass to the print method}
}
\value{
A list object with each item of the list being the findings from spell checking each file. The words not found in the dictionary are given as well as the line numbers where they were found.
}
\description{
Check spelling using hunspell. A new print method is also used.
}
\details{
vague at present.
}
\author{
A. Jonathan R. Godfrey wrote these functions but leant heavily on functions found in the devtools package.
}
\seealso{
The hunspell package and functions therein.
}

