\name{WhichFile}
\alias{WhichFile}
\title{Find a text string  in files}
\description{Which files in a folder (and its subfolders) include/exclude a given text string}
\usage{
WhichFile(String, Folder, fixed = TRUE, DoesExist = TRUE)
}
\arguments{
  \item{String}{The text string or regular expression being sought.}
  \item{Folder}{The head folder to start searching in.}
  \item{fixed}{Fixed text string or if FALSE, a regular expression that will be passed to grep().}
  \item{DoesExist}{If TRUE, it shows the files that do include the text string of interest; if FALSE, files that lack the search string are returned.}
}
\details{
Finding a given search string in a pile of text files is time-consuming. Finding which files lack that search string is even harder.}
\value{A vector of filenames returned as character strings.}
\author{A. Jonathan R. Godfrey in response to a request from CRAN to add missing text to help documentation.}
\note{
This search uses readLines() which throws plenty of warnings if the files being searched across do not all end in a blank line.}

