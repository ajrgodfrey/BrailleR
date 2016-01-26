\name{NewFunction}
\alias{NewFunction}
\title{Create a template for a new function}
\description{
An R script for a new function is created in the working directory. It includes Roxygen commented lines for the documentation with sensible defaults where possible.
}
\usage{
NewFunction(FunctionName, args = NULL, NArgs = 0)
}
\arguments{
\item{FunctionName}{The name of the function and file to create.}
\item{args}{a vector of argument names}
\item{NArgs}{an integer number of arguments to assign to the function.}
}
\details{
A file is saved in the current working directory that has a template for a function with a set of arguments (if supplied). The file still needs serious editing before insertion into a package.
}
\value{
No objects are created  in the workspace. The only outcome is the template file and a message to let the user know the job was completed.
}
\examples{
\donttest{NewFunction("MyTest")}
}
\author{
A. Jonathan R. Godfrey.
}
