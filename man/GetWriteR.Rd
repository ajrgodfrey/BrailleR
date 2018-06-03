\name{GetWriteR}
\alias{GetWriteR}
\alias{GetPandoc}
\alias{Get7zip}
\alias{GetRStudio}
\alias{GetPython27}
\alias{GetPython3}
\alias{GetWxPython27}
\title{Download an executable for Windows users}
\usage{
Get7zip()

GetPandoc()

GetPython27()
GetPython3()

GetRStudio()

GetWriteR(UseGitHub = TRUE)

GetWxPython27()
}
\arguments{
\item{UseGitHub}{Use the latest version found via GitHub or an older version found on the R-Resources.massey.ac.nz webpage.}
}
\details{ This function assumes you have a current internet connection because it downloads a File. For WriteR, it is a zip file which gets unpacked in your current working directory, then  The zip file is removed and the executable file is moved to your chosen MyBrailleR folder.

The other functions will download and install the chosen application. The installers are stored in the user's MyBrailleR folder.
}
\value{
NULL. The downloaded file is saved in the user's MyBrailleR folder.
}
\note{Use of this function assumes you are happy for a file to be downloaded and saved on your hard drive. You can go to your MyBrailleR folder and delete the executable at any time.}
\description{
Anyone wishing to make use of the WriteR application must have pandoc installed.

Users that do not have Python 2.7 and wxPython installed cannot use the WriteR application file as provided by the BrailleR package. An executable for Windows is available for separate download. In 2018, the WriteR script files were tested for use with Python3; initial testing was successful.

Downloaded files will be saved into the user's MyBrailleR folder.
}
\author{
A. Jonathan R. Godfrey, building on the installr package by Tal Galili
}

