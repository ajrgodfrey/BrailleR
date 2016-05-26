\name{VI.ggplot}
\alias{VI.ggplot}
\title{VI for graphs created using ggplot2}
\usage{
\method{VI}{ggplot}(x)
}
\arguments{
\item{x}{an object created by ggplot() or qplot() from the ggplot2 package which therefore has class gg or ggplot.}
}
\value{
A text description is printed out as a side effect. The function returns NULL invisibly.
}
\description{
The popular ggplot2 package creates graphs using many default settings and it is unlikely that all ramifications of using this package will be understood by reading the code alone. Text descriptions of these graphs may still be less complete than those created using base graphics.
}
\details{
Still lots to do with this functionality. The theme of the graph may prove important to blind users although less interesting to the creation of purely text alternatives of the graphs.
}
\examples{
if(require(ggplot2)){
g = ggplot(economics_long, aes(date, value01, colour = variable))
g = g + geom_line() + ggtitle('dummy title')
VI.ggplot(g)
g
}
}
\author{
A. Jonathan R. Godfrey and Tony Hurst
}

