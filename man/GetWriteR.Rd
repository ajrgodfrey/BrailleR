\name{GetWriteR}
\alias{GetWriteR}
\alias{GetPandoc}
\alias{Get7zip}
\alias{GetRStudio}
\alias{GetPython3}
\alias{GetPython}
\alias{GetCygwin}
\alias{GetWxPython3}
\alias{GetWxPython}
\title{Download and install software (Windows users only)}
\usage{
Get7zip()

GetCygwin(x64 = TRUE)

GetPandoc()

GetPython(x64 = TRUE)
GetPython3(x64 = TRUE)

GetRStudio()

GetWriteR()

GetWxPython()
GetWxPython3()
}
\arguments{
\item{x64}{Use the 64 bit version if appropriate.}
}
\details{ This function assumes you have a current internet connection because it downloads a File. 

The functions will download and install the chosen application. The installers are stored in the user's MyBrailleR folder.
}
\value{
NULL. The downloaded file is saved in the user's MyBrailleR folder.
}
\note{Use of this function assumes you are happy for a file to be downloaded and saved on your hard drive. You can go to your MyBrailleR folder and delete the executable at any time.}
\description{
Anyone wishing to make use any of the WriteR applications must have pandoc installed.

Users that do not have Python and wxPython installed cannot use the WriteR application file as provided by the BrailleR package. This command  gets an installer that can run independently of Python.

Downloaded files will be saved into the user's MyBrailleR folder.
}
\author{
A. Jonathan R. Godfrey, building on the installr package by Tal Galili
}

