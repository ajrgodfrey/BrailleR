\name{Require}
\alias{Require}
\title{Load a package by installing it if necessary}
\usage{
Require(pkg)
}
\arguments{
\item{pkg}{the package to be loaded/installed.}
}
\value{
logical: to say that the package has been successfully loaded (invisible)
}
\description{
It is easier to run a script if we know the packages will be installed if this additional step is necessary. 
Installation uses the RStudio mirror of CRAN.
}
\seealso{
require from the base package
}
\author{
A. Jonathan R. Godfrey
}
