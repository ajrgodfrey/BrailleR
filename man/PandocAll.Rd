\name{PandocAll}
\alias{PandocAll}
\title{Convert files using pandoc.}
\description{Convert all files in the current working directory of one type into another type using Pandoc.}
\usage{
PandocAll(intype = "docx", outtype = "html")
}
\arguments{
  \item{intype,outtype}{File formats denoted using the standard extensions.}
}
\details{
This will over-write existing files. It was intended to take MS Word files and convert to HTML, but other conversions are possible. See the pandoc documentation for full details.
}
\value{Files will be created in the current working directory. CRAN policy says you must have been informed that this is happening. This help file is your warning.}
\references{
Extensive guidance on using pandoc is available
}
\author{A. Jonathan R. Godfrey}
