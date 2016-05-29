\name{GetWriteR}
\alias{GetWriteR}
\title{Download an executable for Windows users}
\usage{
GetWriteR()
}
\details{ This function downloads a zip file which gets unpacked in your current working directory. The zip file is removed and the executable file is moved to your chosen MyBrailleR folder.}
\value{
NULL. The downloaded file is saved in the user's MyBrailleR folder.
}
\note{Use of this function assumes you are happy for a file to be downloaded and saved on your hard drive. You can go to your MyBrailleR folder and delete the executable at any time.}
\description{
Users that do not have Python 2.7 and wxPython installed cannot use the WriteR application file as provided by the BrailleR package. An executable for Windows is available for separate download. The downloaded file is saved into the user's MyBrailleR folder.
}
\author{
A. Jonathan R. Godfrey
}

