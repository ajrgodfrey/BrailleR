\name{GetWriteR}
\alias{GetWriteR}
\alias{GetPandoc}
\alias{Get7zip}
\alias{GetRStudio}
\alias{GetPython27}
\alias{GetPython3}
\alias{GetCygwin}
\alias{GetWxPython27}
\alias{GetWxPython3}
\title{Download and install software (Windows users only)}
\usage{
Get7zip()

GetCygwin(x64 = TRUE)

GetPandoc()

GetPython27(...) # deprecated
GetPython3(x64 = TRUE)

GetRStudio()

GetWriteR(UseGitHub = TRUE)

GetWxPython27(...) # deprecated
GetWxPython3()
}
\arguments{
\item{UseGitHub}{Use the latest version found via GitHub or an older version found on the R-Resources.massey.ac.nz webpage.}
\item{x64}{Use the 64 bit version if appropriate.}
\item{...}{cover for unnecessary arguments going to deprocated functions.}
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

Users that do not have Python and wxPython installed cannot use the WriteR application file as provided by the BrailleR package. 

Downloaded files will be saved into the user's MyBrailleR folder.
}
\author{
A. Jonathan R. Godfrey, building on the installr package by Tal Galili
}

