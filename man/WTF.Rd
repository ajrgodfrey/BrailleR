\name{WTF}
\alias{WTF}
\title{What's this figure?}
\usage{
WTF()
}
\description{
Determine what the current graphics device has on it so the blind user can be sure they have something they want, or find out what it might be that is contained in a graphics device.
}
\examples{
attach(airquality)
hist(Ozone)
WTF()
plot(Ozone~Wind)
WTF()
detach(airquality)
}
\author{
A. Jonathan R. Godfrey and Paul Murrell.
}
\value{Text describing what BrailleR was able to detect in the graphics window.}

