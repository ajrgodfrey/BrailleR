# BrailleR 1.0.2
- improved CRAN test picked up inconsistencies with internal functions

# BrailleR 1.0.1
- deleted detritus

# BrailleR 1.0.0
- first production release. Still plenty to add, but the original intention of the package has now been met.
- removed explicit CITATION file. This then required explicit date specification in DESCRIPTION.

# BrailleR 0.99.0
- did some cleaning up to de-clutter, check examples, add documentation, and all the good things that must be done prior to v1.0.0
- removed dependency on magrittr as now using native pipe
- removed rlang as a dependency; redundant for some time probably
- removed other dependencies (on base packages) from imports
- responded to June 28 CRAN check

# BrailleR 0.33.4
- fix issue #35 with incorrect bin counts
- fix issue #24, correcting base r plot titles in VI
- Add shaded area for geom_smooth CI info to VI output.
- Add geom_ribbon support
- Add geom_area support. This has been added to the geom_ribbon branch and is treated like a geom_ribbon almost exactly the same.
- Add support for showing expand_limit effect on graph.
- add functionality for winget tools into new winget.R file; should streamline software installation down the track
- deprecated functions relating to Python 2.7 and functions for making slide shows
- updated template files so that chunk options are moved from opening fence to commented lines (should be ready for Quarto)
- added several functions to make basic Quarto documents from history and an R script
- changed to use whisker templates by adding {{.}} around the items that need to be changed
- added a few functions to choose a template and be given some guidance on its use; see ChooseTemplate()
- resolve issue #31, add default shape message.
- resolve issue #34, add information about visible points. It only works at the moment up to point size of 18.
- resolve issue #62, add ggplot support for TimeSeries
- resolve issue #61, fix geom_boxplot VI output and add outlier information to VI output.
- Add ggplot to describe
- Add basic CoordFlip and CoordPolar support to VI()
- Refresh SVG functions and documentation. Move all SVG over to whisker templates.

# BrailleR 0.33.3
-Update author files
-Change the VI.ggplot output for unrecognized graphs to correct spelling of cannot

# BrailleR 0.33.2
- updated batch file creation so that they search for current version of R. Batch files should not require updating as a consequence.
- start adding support for quarto.
- converted templates to use the native pipe instead of the magrittr pipe


# BrailleR 0.33.1
- working on modernising other convenience functions
- serious compaction of code was possible; used new internal functions where code is repeated over convenience functions
- WriteR was updated so that it does not create a settings file anywhere. Python 3.8 works but 3.10 has issues getting the necessary wxpython module installed. This creates incentive for getting stand alone version up and running.
- added new verbosity setting for VI output. At this stage it hasno  impact.



# BrailleR 0.33.0
- updated ScatterPlot(), FittedLinePlot(), and TimeSeriesPlot() functions  to have both base and ggplot style graphics.
- updated qplot.Rmd vignette to remove all but one `VI()` command as they are redundant now that we get automatic descriptions of ggplot objects.
- moved all stop() error message commands to stop.r and used hidden commands to pull the errors. Will make translation easier.
- moved a lot of message() and warning() calls to use specific functions instead. Should reduce the number of text strngs that need translation.
- added use of pkgdown
- updated templates to make use of pipe chains where possible
- updated examples to use dplyr syntax
- added quite a few more templates for tests that will help VI users
- added UseTemplateList() as a fast wrapper for UseTemplate()
- added use of Rdpack package for use of bibtex references in Rd files
- brought ggplot style graphics into OnePredictor() with new `Modern=TRUE` while still allowing old-style graphs (must set `Modern=FALSE`)
- tried to reduce package dependencies list. Added packages to suggests list.

# BrailleR 0.32.2 
(Temporary while waiting for CRAN approval)

# BrailleR 0.32.1
- feedback from manual CRAN inspection
- removed commented code from examples in Rd files.
- removed other aspects of examples that fail CRAN checking such as rm()
- removed use of installed.packages()
- had to search for specified text strings and for files lacking specified sections. The new function WhichFiles() was key in making sure this did not take forever.
- updated a few of the templates in inst/templates; these are meant to be snippets, not completely stand alone files.

# BrailleR 0.32.0
- attempted return to CRAN

# BrailleR 0.31.4
- Testing for a return to CRAN; looked right.
- changed dates and version numbers in readiness for CRAN
- had to remove orientation checking for bars in ggplot() graphs; see VI.internals. this forced introduction of rlang package dependency
- forced option to be set that is equivalent to GoBlind() to get VI.ggplot() to be automatic
- fixed doubling of VI() output for ggplot() output in qplot.Rmd vignette
- minor cosmetic updates for Rmd files
- Some improved messaging.



# BrailleR 0.31.3
- cleaned Sophie's code. We now have geom_smooth() reporting method and existence of confidence intervals.
- renamed BrailleR functions xlab() and ylab() to use upper camel case to resolve conflict with ggplot2.
- getting ready for contributions from Sophie Banks; added her to contributors list

# BrailleR 0.31.2
- removed travis-ci package service as it will move to a fee-for-service model in 2021
- added GitHub actions to workflow; found trivial issues to fix.
- added spell checking
- added use of pkgdown

# BrailleR 0.31.1
- removed the unclean check directory problem that would frustrate return to CRAN
- added a .onDetach() function to remove options in the (unlikely) event that a user detaches BrailleR.
- axis labels proven to be back for ggplot() graphs



# BrailleR 0.31.0
- merged PR26 to fix ggplot() axis labels.
- added VI.htest()
- added RemoveBOM function for taking the BOM off an Rmd file
- fixed .ProcessAll() so that it avoids the BOM problems created by use of the wrong text editor in Windows.
- added PandocAll() to convert files of one type to another
- added print method for objects of class VI so that the VI() functions can be enriched.
- added VI.qcc() for helping with control charts created using the qcc package
- altered History2Rmd() and R2Rmd() to insert minimal YAML header
- added details to DESCRIPTION to prepare for using mathjax in Rd files




# BrailleR 0.30.2
- trying to ensure examples that create files pass CRAN checks; see UniDesc() etc.

# BrailleR 0.30.1
- made sure to use tempdir() in some examples so that CRAN checks on Devian see clean folders

# BrailleR 0.30.0
- making ready for upload to CRAN
- attempting to remove all references to the reticulate package
- added TestPython() and TestWX() functions which test system setup.
- added Messages.R and Warnings.R to create text strings that get used in multiple functions. All now use internal functions
- deprecated GetPython27() and GetWxPython27(); updated help pages to show deprocation



# BrailleR 0.29.5
- work to remove Python 2.7 from package files
- GetPython27() and GetWxPython27() kept just in case someone wants them.
- small updates to GetPython3() to guide user to use custom installation.

# BrailleR 0.29.4
- testing for new version of whisker package (dependency)
- removed trash from some Rd files that spat a warning on package creation


# BrailleR 0.29.3
- added more detail to Describe() methods

# BrailleR 0.29.2
- added a starting template for the WriteR files
- added Notepad(), notepad(), Explorer(), explorer(), CMD(), and cmd() functions to make life a little easier for Windows users
- added check_it(), CheckIt(), WhatIs(), and what_is() for investigating objects in the middle of a pipe chain
- added R4DS() and r4ds() to open the home page for the R for Data Science book and Google() and google()  for helping get to commonly used websites quickly.
 

# BrailleR 0.29.1
- pushed to CRAN, successfully
- got to successful build status on travis-ci; yippee!
- dependent packages now on CRAN; thanks Paul.
- added travis-ci stuff

# BrailleR 0.29.0
- added CII best practices badge to GitHub repo.
- pushed to CRAN (ahead of regular plan); failed due to dependent packages not on CRAN
- some fixes from Paul for the problems caused by changes in the ggplot2 package; done via PR on GitHub 
- WriteR() slightly modified so that the terminal is not locked up while editing an Rmd file.
- introduced use of roloc package to define colours in human readable form.

# BrailleR 0.28.0
- submitted to CRAN

# BrailleR 0.27.3
* Added a `NEWS.md` file to track changes to the package.
- added a Code of Conduct to the package.
- added internal functions for pulling the WxPython module and checking if the necessary Python and WxPython systems are in place.
- updated GetWxPython27() so that it uses a Python pip install command in the shell instead of a convoluted download and save process. This should obviate the need to have a manual installation of wxPython which is needed for WriteR.
- added GetPython3() because WriteR is Py3 compatible.
- added GetCygwin(), GetRStudio() to help speed up installations. 
- added the pdf2html() function. This is dependent on Python 2.7 at present.
- added Marshall Flax to contributors for substantial work on WriteR
- added a Python27 folder to the Python folder which contains copies of scripts installed in subfolders of the Python27 installation folder that may not be on the system path. First set of scripts pulled over and readme.txt created accordingly.
- added reticulate package to imports list
- added Require() for loading/installing packages.
- added WriteR updates
- changed VIgrep() and VIsort() to grep.VIgraph() and sort.VIgraph()
- added gsub.VIgraph()
- finally fixed GetPython27 now that installr::install_python() is available to all (Windows) users.

# BrailleR 0.27.2
- introduced reference to the BrailleR in Action text
- updated vignettes with more direct links to BrailleR in Action

# BrailleR 0.27.1
- altered DESCRIPTION file to raise Paul and Debra to author from contributor in preparation for pull requests for VI.ggplot() work.
- imported Debra Warren's work <smiles> via a PR on GitHub. This offers huge gains in VI.ggplot()
- changed R dependency sought by CRAN on 29/9/17 by email.
- internalised the R2txt.vars (should have done this ages ago!)
 

# BrailleR 0.27.0
- added ProcessAllMd() for rendering plain markdown files.
- removed dependency on pander package by altering UniDesc(). Reason: Nice results, but possibly over the top for introductory students.
- added Language to the set of package options to be chosen by the user. This is necessary to then have the SpellCheckFiles() work properly.
- added GetExampleText() to help extract the example text from help pages.




# BrailleR 0.26.0 for Annabelle
Pushed to CRAN on 6 July 2017

# BrailleR 0.25.7
- ProcessAllRmd() function added: this processes all Rmd files in the specified folder using either rmarkdown::render() or knitr::knit2html()
- MakeBatch() changed to force Rmd file specific batch file to use rmarkdown::render() instead of knitr::knit2html()
- MakeBatch(file=NULL) now creates ProcessAllRmd.bat file in working directory so that users can process all Rmd files from Windows Explorer or the  DOS command prompt.
- VS offered BrowseSVG() and replacement cacc.js for improved interactive experience; JG fixed for CRAN checks.
- changes from VS merged via GitHub (not to be reported again)
- moved knitr package to imports. This means some of the Rmd files need more explicit mention of the package to get chunk options working properly.
- JG implemented the ViewSVG() so that anyone can use the interactive graph viewing system; required various internal functions to move and write necessary files 
- added FittedLinePlot() which adds a fitted line to the ScatterPlot() implemented through ScatterPlot(); these use a few internal functions, found in ScatterPlot.R
- added plot and print methods for various graph types. The print method refers to the plot function so acts just like the ggplot and lattice packages.
- restructured the storage of graph parameters and arguments for a variety of the masked functions. The intention is to make cleaning things up easier.
- adding examples to the graph making help pages to show that the BrailleR functions replicate base graphics functions
- added xlab(), ylab(), and main() for getting or setting these three parameters quickly. They only work for graphs that are created using BrailleR functions at this time.
- updated VI.gg() which add functions to create text elements so that accessible versions can be made; various internal functions added to get labels commonly found on ggplot() graphs.
- added Describe() so that a blind user can have the general appearance of a particular graph object explained to them. Text elements of the resulting description object can be pulled into the other accessibility tools under development.
- working on accessibility for scatter plots


# BrailleR 0.25.6
- working on accessible Venn diagrams and time series plots
- fixed VI() method to handle additional arguments, although they are currently ignored.
- created function to choose long and short text for a boxplot; previously embedded in VI.boxplot()

# BrailleR 0.25.5
- Added experimental work on making accessible graphs for mounting on the web
- added Volker Sorge and Donal Fitzpatrick to the package contributors list
- added MakeAccessibleSVG() and AddXML() as well as a bunch of internal functions to do the hard work.
- added Augment() method to take the functionality out of VI() that adds the content that feeds into the text descriptions because it will get used in other processes from here on.
- changes from VS merged via GitHub

# BrailleR 0.25.4
- added JooYoung Seo and TK Lee to the package contributors list
- updated WriteR.pyw
- fixed small typos
- added MakeSlidy() which takes a folder of Rmd files and turns them into a slidy presentation

# BrailleR 0.25.3
- WriteR() failed for JYS. Suggestion to use file.path() from HB added to WriteR(). Proved insufficient so hard wired quote marks for command line being issued have been included. JYS reported success.
- fixed URL for CRAN repository of package in CITATION file
- then fixed a bunch of other URLs from http to https in DESCRIPTION and vignette files.
- added folder of templates for (fairly) common analyses which are slightly beyond the OneFactor(), OnePredictor() etc 
type; it will also include the code chunks that are reused frequently in other functions.
- added UseTemplate() to make use of the template files faster. Not intended for wide use at this stage.
- Moved installr package from Imports to Suggests so that installation from GitHub works for OS!=Windows.
- removed use of require(<p kg>) and used requireNamespace("<pkg>") instead, and then used pkg::blah()
- added initial version of ThreeFactors()
- updated FindReplace() to avoid using pattern matching
- added Rnw2Rmd() to get a head start on the conversion from *.Rnw to *.Rmd 
- updated the BrailleR History vignette.


# BrailleR 0.25.2
- fixed formatting of the R functions so it is easier to read. Request from Henrik Bengtsson resolved using the rfmt package seen at UseR!2016


# BrailleR 0.25.1
- added SpellCheck() which is an interface to spell check a set of files, allowing ignore this time, always for all files, always for this file, replacement, and reading the word in context.
- added CleanCSV() for removing white space in (csv) files
- moved files from Inst to Inst/MyBrailleR for cleaner package installation. updated installation functions as needed.
- added AutoSpellCheck() for fixing all my irritating typos. 
- added AutoSpellList.csv for my list of typos to fix. Users can update this for themselves.
- added FindReplace() for replacing text strings in a specified file.
- added SpellCheckFiles() which is a wrapper for spell checking a file or files in a folder; this returns a list with the classed set to "wordlist" which has an associated print method. (based on similar functionality in the devtools package)
- added package hunspell to the growing list of dependencies
- fixed spelling in vignettes using SpellCheckFiles()
- added local and global options for lists of words to ignore during spell checking.

# BrailleR 0.25.0
- did some overdue spell checking
- fixed wrong filename in PrepareWriteR() and its help page.
- added more Get*() commands to download and install several useful tools; based on functions from the installr package with the downloaded files going into the user's MyBrailleR folder. Python 2.7 and the associated wxPython version are hard wired at present until the dynamic links can be established.
- altered MakeBatch() to accept both upper and lower case R in file extensions.
- added ThankYou() to create an email message from a very short template.
- added LURN() to open the Let's Use R Now manual in a browser. It will open the version for blind users by default.
- added vignette on getting started with WriteR.
- updated vignettes
- updated WriteR.pyw and WriteROptions files. to v0.160530.0
- added GetWriteR() to download executable version for Windows users. This currently comes from GitHub by default, but was originally tested on http://R-Resources.massey.ac.nz; this can be used again if the user sets the argument UseGitHub=FALSE but the zip file downloaded must be moved to the right folder and manually unzipped. The function is currently unavailable due to problems with the executable file itself.
- added experimental VI.ggplot() thanks to starter from Tony Hirst
- added vignette for testing VI.ggplot() via ggplot2::qplot() calls. (This is far from complete.)
- added use of magrittr package to gain  the benefits of the pipe operator


# BrailleR 0.24.2
- CRAN check uncovered need to have dependency of R >= 3.2.0. 

# BrailleR 0.24.1
- fixed issue with inappropriate use of tempdir() in conjunction with paste0() instead of the more correct file.path(). Direct request from Brian Ripley on behalf of CRAN.
- removed use of tempdir() entirely for saving BrailleROptions and WriteROptions. Users must pull the defaults from the package until such time as they accept use of a folder on their own system, or a local copy of the settings.
- altered option setting commands to ensure no access to files if not running in an interactive session.
- altered help files accordingly

# BrailleR 0.24.0
- Made ready for CRAN submission

# BrailleR 0.23.10
- added MakeReadable() which cleans up vignette source files from installed packages, by converting tabs to spaces and Linux line breaks to Windows line breaks. This currently requires Python 2.7 to be installed.
-Added BrailleRHome() which takes the user to the BrailleR Project home page.
- Added JoinBlindRUG() which creates the email message needed for joining the Blind R User Group email list.


# BrailleR 0.23.9
- added NewFunction() for creating a template R script file for a new function including Roxygen comment lines.
- fixed spacing problems in the output messages for MakeRmd()
- added constraint that some version of Python must be installed for WriteR() to work.
- added scope for WriteR() to call a file name for a file that does not yet exist. The file is created and then the application opens.
- added library(BrailleR) to first chunk created by UniDesc() and ifelse(VI, "library(BrailleR)", "library(knitr)") to the first chunk of the other convenience functions so the Rmd files can be converted without BrailleR being loaded. Discovered at University of Pretoria Boot Camp.
- Fixed MakeSlideshow() so that warnings for empty blank lines at the end of slides no longer appears.
- added MakeAllInOneSlide() function to be able to deliver slide show as a single file. Required for distributing talks given at DEIMS 2016


# BrailleR 0.23.8
- Small changes to TwoFactors() so variable names get printed properly in tables.
- added author credentials to OneFactor(), OnePredictor(), TwoFactors(), and UniDesc().
- removed over-writing of files in example for TwoFactors(). Filenames will now indicate with or No interaction.
- dotplots in TwoFactors() have more meaningful filenames that reflect grouping variable used.
- fixed creation of ReadMe.txt in the MyBrailleR folder so that it gets the package version properly. Needed to include packageVersion() in the NAMESPACE file; also explicitly linked this command to the utils package in SetupBrailleR().
- added internal function .simpleCap() which is based on code in the example for toupper(); outcome is dependent on a new BrailleR option BrailleR.MakeUpper which is set to TRUE by default.
- added function SetMakeUpper() to control the presentation of variable names on graphs.
- made use of  .simpleCap() in UniDesc(), TwoFactors(), OneFactor(), and OnePredictor().
- fixed error in UniDesc where label for latex table was being garbled.

# BrailleR 0.23.7
- WriteR() goes live. Does not make use of all arguments just yet.
- updated some of the vignette files
- added option for BrailleR.SlideStyle in readiness for MakeSlideShow() function that will turn a series of Rmd files into a set of html slides.
- fixed mismatch in BrailleR.Style option name.
- added internal function that will seek the path of the desired css file for the user.
- enhanced the SetupBrailleR() to copy css files
- added use of the css file chosen using BrailleR.Style to be used for UniDesc() etc.
- The MakeSlideShow() function is ready to go including addition of a contents slide.
- updated DESCRIPTION file to add GitHub links.

# BrailleR 0.23.6
- reinstated use of a local file for local settings
- Added creation of "MyBrailleR" folder for user preferences and files. This only happens if the user agrees otherwise a temporary folder is created Thanks to Henrik Bengtsson for code suggestions and comments.
- settings files will be copied to the user folder if needed.
- fixed case sensitive typo in BrailleROptions settings file for BrailleR.Embosser
- SaveMySettings() and RestoreMySettings() functions now redundant; removed as they were never released publicly.
- introduced use of normalizePath(). Thanks to Henrik Bengtsson.
- made some changes to replace cat() with message(). Suggestion from Henrik Bengtsson. (might be more of them to fix.)
- added creation of Readme.txt file in the MyBrailleR folder which contains the date and the version of BrailleR being used.
- New version of WriteR 0.160105.3
- established GitHub repository at ajrgodfrey/BrailleR

# BrailleR 0.23.5
- Implemented use of local settings stored in .BrailleROptions object (hidden)
- There is now  a set of defaults that can be restored in addition to the currently active set of preferences in the BrailleROptions file within the package.
- SaveMySettings() and RestoreMySettings() functions created for obvious outcomes. These are needed to protect from losing settings when the package is updated.
- A wrapper for WriteR is now included.
- MakeAllFormats() added to create pandoc settings files based on the foo.pandoc file in the inst folder.
- What's this figure? function WTF() now incorporated.
- added necessary import of grid package

# BrailleR 0.23.4
- changed preferences to use local options files. Removed PREFERENCES from Inst folder.

# BrailleR 0.23.3
- added fitted line plot to OnePredictor().
- altered tables to wide format instead of long where only one set of results given by UniDesc()
- added new version of history() that uses the file.edit() instead of file.show(). Thanks to Duncan Murdoch.
- added note to the VI.Rd help page so that the explicit two step procedure for VI.lm() is described.
- made more use of message() and warning() for package feedback in preparation for multiple language support.
- removed windows architecture from batch file creations scripts.

# BrailleR 0.23.2
- introduced use of pander for tables in html

# BrailleR 0.23.1
- fixed MakeBatch() and PrepareWriteR() so that it works for new representations of windows versions. Discovered at the SZS 8 July 2015.
- fixed bug in OnePredictor() with use of Response when ResponseName was required. Discovered on 9 July 2015 during Skype call with SD.

# BrailleR 0.23.0
- moved from import to importFrom in the namespace. This was required for the base packages being used so I did it for all packages.

# BrailleR 0.22.0
Successfully uploaded to CRAN

# BrailleR 0.21.1
- added option for braille font installation status
- ensured BRL options are of correct type on load of BrailleR.
- created functions to change paper size and braille font point size.- included options for paper size and embosser type
- established DEFAULTS and PREFERENCES files so an update does not overwrite a user's preferences. If PREFERENCES does not exist, then it is created when next the package is loaded.
- created ResetDefaults() to overwrite PREFERENCES with DEFAULTS.
- added package dependency to devtools so that package reload can be managed.
- added package dependency to extrafont so that braille fonts can be embedded in pdf files.
- added functions for setting specific embosser models.
- added SVGThis into package as experimental function.
- added BRLThis into package as experimental function.

# BrailleR 0.21.0
- fixed bug in the batch file that converted an Rmd file to html. Now uses knitr::knit2html instead of rmarkdown::render.
- altered startup so that explicit use of the packages is initiated
- investigated using Roxygen for package documentation. Conclusion is that it must be all or nothing. Nothing preferred at present.
- fixed use of css for VI.lm()
- added extra braille options in readiness for the experimental BRLThis() function.
- added fonts folder to package that includes the single font file "BRAILLE1.ttf" for Windows users and its licence file.

# BrailleR 0.20
- uploaded to CRAN

# BrailleR 0.19-5
- replaced settings folder with individual files for each setting with a single devian control file called PREFERENCES
- updated zzz.R functions so that they use the dcf format for settings
- updated all functions for updating the package settings values to use the dcf format
- Included the OnePredictor() convenience function, and related additions to the VI() method

# BrailleR 0.19-4
- added analysis of tick marks for axes to existing graph types
- introduced dotplot() as wrapper  for graphics::stripchart()
- added VI.dotplot()
- made adding quote marks to strings easier using in internal function InQuotes()
- made sure the boxes in HTML documents are appropriate and that spacing is nicer.

# BrailleR 0.19-3
- incorporated the BrailleR.css file for use in formatting HTML content from the convenience functions.
- updated UniDesc(), OneFactor(), TwoFactors() to use the BrailleR.css
- fixed the example for SetOptionsRd so that the author setting is not altered during package creation.
- included the author in the HTML files for convenience functions.
- added a choice for the css style file to use

# BrailleR 0.19-2
- tried (unsuccessfully) to make the tables in UniDesc() more visually appealing, without altering their accessibility.
- Added links to Getting Started vignette for RStudio and pandoc downloads.
- cross references in vignettes sorted out.
- found the vignettes were unacceptably large files and how to get them smaller without loss of information.
- more tidy up of vignettes

# BrailleR 0.19-1
- updated the primary vignette on the BrailleR package's history.
- added a getting started vignette
- included the previously overlooked need for the rmarkdown package.
- added the SetPValDigits() function and improved the SetSigLevel() which now both mirror the SetAuthor() behaviour.
- Added detail to the GetGoing() function for these options.
- Updated UniDesc() so it uses the BrailleR.PValDigits option.
- updated UniDesc() so it generates a more complete R script when purled.


# BrailleR 0.19-0
- Made some minor changes to UniDesc(), OneFactor(), TwoFactors()  so that packages are explicitly loaded when a code chunk needs them. Notably moments, xtable, and nortest
- added GetGoing() function for setting options. Altered package startup message to mention it.
- altered VI.boxplot() so that lower/upper terminology is only used for vertical boxplots and left/right is used for horizontal ones.
- NEWS file established.

# BrailleR 0.18-1
- Move gridSVG and gridGraphics to Imports. Neither is actually used in this version but will be in a subsequent release
- Satisfactory CRAN release version

# BrailleR 0.18-0 
- This version was rejected by CRAN because it had too many other packages listed as depends and CRAN wants them to be imports instead.
