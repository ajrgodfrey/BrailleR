\name{SessionLog}
\alias{SessionLog}
\alias{GrabLast}
\alias{ShowMe}
\title{Retrieve a copy of the console input/output}
\description{
Retrieve the output from the last n top level calls, or the hole current session. These functions are designed to cater for situations where the output scrolls off the screen and is no longer accessible to a screen reader user.}
\usage{
GrabLast(file = "", n=1)

SessionLog(file = "", n=NULL)

ShowMe(file = NULL, n=1) 
}
\arguments{
  \item{file}{a filename; if left unspecified, the output is printed in the console}
\item{n}{the number of calls to retrieve}
}
\details{
A stack of top level calls and the resulting output is stored, courtesy of a setting established on package load. These functions retrieve elements from that stack. The ShowMe() function automatically opens the file created for immediate viewing.}
\value{NULL, invisibly; not the output which is either printed to the console or the file specified}
\author{Gabe Becker and some very minor edits from A. Jonathan R. Godfrey}

