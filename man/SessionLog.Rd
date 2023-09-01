\name{SessionLog}
\alias{SessionLog}
\title{Retrieve a copy of the console input/output}
\description{
Retrieve the output from the last top level call. This function is designed to cater for situaitons wher ehte output scrolls off the screen and is no longer accessible to a screen reader user.}
\usage{
SessionLog(file = "")
}
\arguments{
  \item{file}{a filename; if left unspecified, the output is printed in the console}
}
\details{
A stack of top level calls and the resulting output is stored, courtesy of a setting established on package load. This function retrieves elements from that stack.}
\value{NULL, invisibly; not ehe output wich is either printed to the console or the file specified}
\author{
Gabe and some very minor edits from A. Jonathan R. Godfrey}

