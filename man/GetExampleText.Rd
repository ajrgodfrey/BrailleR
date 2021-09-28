\name{GetExampleText}
\alias{GetExampleText}
\title{extract the example text from a help page}
\description{
A cut back version of example() for obtaining the text used in examples on help pages without running those examples. The function is intended to help write markdown/Sweave documents. }
\usage{
GetExampleText(topic, package = NULL, lib.loc = NULL, character.only = FALSE, outFile="")
}

\arguments{
  \item{topic}{name or literal character string: the online help topic the examples of which should be run.}
  \item{package}{a character vector giving the package names to look into for the topic, or NULL (the default), when all packages on the search path are used.}
  \item{lib.loc}{a character vector of directory names of R libraries, or NULL. The default value of NULL corresponds to all libraries currently known. If the default is used, the loaded packages are searched before the libraries.}
  \item{character.only}{a logical indicating whether topic can be assumed to be a character string.}
  \item{outFile}{an optional filename to save the results into. The default is to use a temporary file.}
}
\details{
The example() code was hacked back to form this utility function. It is probably a little heavy for what is needed but it works sufficiently at the time of creation.}
\value{
a vector of character strings each element being one line of the examples from the corresponding help topic.}
\author{The work of Martin Maechler and others got tampered with by A. Jonathan R. Godfrey}

\seealso{
You may wish to compare this with \code{\link{example}} 
}
\examples{
cat(paste(GetExampleText(mean), collapse="\n"))
}
