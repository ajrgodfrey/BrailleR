\name{MakeSlideShow}
\alias{MakeSlideShow}
\docType{data}
\title{Turn a set of Rmd files into an HTML slide show}
\description{
Takes a set of Rmd files in alphabetical order and makes them a set of linked HTML files suitable for a presentation.}
\usage{
MakeSlideShow(folder, Style = getOption("BrailleR.SlidesCSS"), ContentsSlide = FALSE)
}
\arguments{
  \item{folder}{name of the folder in the current working directory that contains the set of Rmd files.}
  \item{Style}{Choose the cascading style sheet file to be applied.}
  \item{ContentsSlide}{Do you want links for the extra slide th at has the links to all slides?}
}
\details{
The files are temporarily moved up tot he current working directory where hte links for the back, next and optionally the contents slides are added, before these new files are knitted to HTML. The user then opens the first file in hte set and has a set of next links to work with that gets them through the slide show. All temporary files are then deleted.}
\value{
A printout of the slides made in the order they will appear. The HTML files are in the current working directory.
}
\author{A. Jonathan R. Godfrey}
\note{
The official CRAN policies tell package developers that we cannot write files to the user's hard drive without their permission or notifying them that this is happening. Well, you've just been told. If you use this function, you will get files written to the hard drive on your computer, but you did want them.
}
