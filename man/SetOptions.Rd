\name{SetOptions}
\alias{ChooseEmbosser}
\alias{ChooseStyle}
\alias{ResetDefaults}
\alias{SetAuthor}
\alias{SetBRLPointSize}
\alias{SetPaperHeight}
\alias{SetPaperWidth}
\alias{SetPValDigits}
\alias{SetSigLevel}
\title{Functions for setting package options.}
\description{
Some package options have arguments which need validation. Setting the default significance level for analyses was the first function of this kind. Setting the name of the user to be inserted into documents was the second. Others are detailed further below.}
\usage{
ChooseEmbosser(Embosser = "none", Permanent = TRUE, Local = TRUE)

ChooseStyle(css = "BrailleR.css", Permanent = TRUE, Local = TRUE)

ResetDefaults(Local=TRUE)

SetAuthor(name = "BrailleR", Permanent = TRUE, Local = TRUE)

SetBRLPointSize(pt, Permanent = FALSE, Local = TRUE)
SetPaperHeight(Inches, Permanent = FALSE, Local = TRUE)
SetPaperWidth(Inches, Permanent = FALSE, Local = TRUE)

SetPValDigits(digits, Permanent = TRUE, Local = TRUE)

SetSigLevel(alpha, Permanent = TRUE, Local = TRUE)
}
\arguments{
  \item{alpha}{The level of alpha to be used for analyses. Must be between zero and one or a warning is given and the option is not changed.}
  \item{css}{a cascading style sheet file to be inserted in HTML documents created by convenience functions. The file must be placed in the css folder within the BrailleR package folder for this to work.}
  \item{digits}{The number of decimal places to display. Must be an integer greater than one or a warning is given and the option is not changed.}
  \item{Embosser}{the name of the embosser to be used for tactile images. Not all embossers will be immediately supported by the package. The supported embossers are listed in the relevant section below. Please contact the package maintainer to introduce a new embosser to the list of supported models.}
  \item{Inches}{The size of the area to use for embossing. This should be the size of the embossed area not the actual size of the paper itself.}
\item{Local}{Should the local copy of BrailleROptions.dcf be updated?}
  \item{name}{a character string to be used for author details in various file writing functions.}
  \item{Permanent}{Should the change be made permanent? Set to FALSE for a temporary change.}
\item{pt}{The point size of the chosen braille font.}
}
\details{More convenience functions for BrailleR users. Most are self explanatory, but the following details should be noted.

The Choose...() functions are used for establishing default parameters for other details. The ChooseStyle() command can be used to alter the appearance of HTML output by way of cascading style sheets. You can create your own css file and add it to the package before calling this function. Please also submit it to the package maintainer so that you don't lose it when the package is updated on your system.

The ChooseEmbosser() will look for the default settings recommended for particular types of embosser. Initial testing was done on a Tiger Premier 100 embosser manufactured by ViewPlus Inc. The default paper size is 11 by 11.5 inches, but the recommended embossing area for graphics is 10 by 10 inches. Please submit your preferences for any embosser to the pacakge maintainer.


The Set..() commands will let the user specify any desired value for the options as long as it is valid: Options assumed to be character strings are checked to be so, integers must be integers and a proportion must be between zero and one.  

SetPaperHeight and SetPaperWidth are temporary changes by default because some types of images are not meant to use the maximum area set down by the original default settings for an embosser. Careful experimentation may be required to get optimal results. If permanent changes are desired, then please contact the package maintainer to explain why you have made these changes so that we can help other users get the best from a wide range of embossers.

SetPValDigits() is used for rounding purposes to avoid the use of scientific notation. It is not used for determining significance.

These settings are stored locally when you first load the BrailleR package in a new folder. When changes are made, they will affect the current session only (both Local=FALSE and Permanent=FALSE), all work done in this folder from now onwards (Local=TRUE and Permanent=FALSE), or will be used for all future sessions in folders yet to be used (Local=FALSE and Permanent=TRUE).

When the package is next updated, the settings you make permanent will be overwritten. As this is highly undesirable, it is suggested you make a copy of your settings if you want to keep them. Use the SaveMySettings() function to put your settings into a local file and after packages are updated, you will be able to use RestoreMySettings() to use your own settings and not the factory default settings.
}
\author{A. Jonathan R. Godfrey}
\examples{
# SetSigLevel(5) # not a valid alpha
SetSigLevel(0.05, Local=FALSE) # valid alpha value
SetAuthor(Local=FALSE)
SetAuthor("Jonathan Godfrey", Local=FALSE)
}
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
