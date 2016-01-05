\name{history}
\alias{history}
\title{View the history of the current workspace}
\usage{
history(max.show = 25, reverse = FALSE, pattern, ...)
}
\arguments{
  \item{max.show }{The maximum number of lines to show. Inf will give all of the currently available history.
}
  \item{reverse }{logical. If true, the lines are shown in reverse order. Note: this is not useful when there are continuation lines.
}
  \item{pattern }{A character string to be matched against the lines of the history. When supplied, only unique matching lines are shown.
}
  \item{\dots}{Arguments to be passed to grep when doing the matching.
}
}
\value{
Nothing is returned to the workspace. This function exists for the creation and viewing of the temporary file that holds the list of commands issued in the current workspace.
}
\description{
A substitute for the history function from the \pkg{utils} package.
}
\details{
This function exists because the standard history function in the \pkg{utils} package opens the internal pager that cannot be used by a blind person's screen reading software.
}
\author{
Duncan Murdoch, with testing by  A. Jonathan R. Godfrey.
}
\seealso{
the original \code{\link[utils]{history}} function.
}

