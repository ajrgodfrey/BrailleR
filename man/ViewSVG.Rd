\name{ViewSVG}
\alias{ViewSVG}

\title{Create the necessary files to allow interactive viewing of SVG}
\description{Copy files from the package folders to the current working directory and write a markdown file that contains the links to all accessible SVG files in the current directory.}
\usage{
ViewSVG(dir=".")
}
\arguments{
  \item{dir}{the directory to search for content; currently limited to the current working directory}
}
\details{
Two files are copied from the package folders and an index file is written that contains the necessary links to all accessible SVG files.}
\value{
NULL. This function exists for its  side effects only.
}
\references{
Godfrey, A.J.R. (2013) \sQuote{Statistical Software from a Blind Person's Perspective: R is the Best, but we can make it better}, The R Journal 5(1), pp73-79.
}
\author{
A. Jonathan R. Godfrey
}


