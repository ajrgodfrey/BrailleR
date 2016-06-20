\name{SpellCheckFiles}
\alias{SpellCheckFiles}
\alias{print.wordlist}
\title{Spell checking a file or all files within a specified folder}
\usage{
SpellCheckFiles(file = ".", ignore = character(), 
    local.ignore = TRUE, global.ignore = TRUE) 

\method{print}{wordlist}(x, ...)
}
\arguments{
\item{file}{The filename of an individual file, or an individual folder.}

\item{ignore}{The character vector of words to be ignored by hunspell}

\item{local.ignore}{Use a local file of words to be ignored. This file has the same name as the file with .ignore.txt tacked on the end and is colocated with the file being checked. If the file argument is set to a folder then the local.ignore can be set to the name of a file in the current working directory.}

\item{global.ignore}{Use the global word list called words.ignore.txt found in the MyBrailleR folder}

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
The global list of words to be ignored needs to be saved in the user's MyBrailleR folder. It can be updated as often as the user likes. It should have one word per line, and contain no space, tab or punctuation characters.
}
\author{
A. Jonathan R. Godfrey wrote these functions but leant heavily on functions found in the devtools package.
}
\seealso{
The hunspell package and functions therein.
}

