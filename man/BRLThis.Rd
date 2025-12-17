\name{BRLThis}
\alias{BRLThis}
\title{Convert a graph to a pdf ready for embossing}
\usage{
BRLThis(x, file)
}
\arguments{
\item{x}{the call to create a graph}

\item{file}{A character string giving the filename where the image is to be saved.}
}
\value{
Nothing within the R session, but a pdf file will be created in the user's working directory.
}
\description{
DEPRECATED. Do not use this function.
The first argument to this function must be a call to create a graph, such as a histogram. Instead of opening a new graphics device, the graph will be created in a pdf file, with all text being presented using  a braille font. The function is somewhat experimental as the best braille font is not yet confirmed, and a number of examples need to be tested on a variety of embossers before full confidence in the function is given.
}
\details{
The user's chosen braille font must be installed. This might include the default font shipped as part of the package.
}
\author{
A. Jonathan R. Godfrey. with contributions from JooYoung Seo and TK Lee.
}

