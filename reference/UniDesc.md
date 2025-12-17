# Descriptive statistics and graphs for univariate data

This function is a convenience function for analyzing univariate data.
It provides histograms, boxplots and tabulated results for normality
tests as well as those for skewness and kurtosis. The intended use of
this function is principally for a blind user of R who also has the
advantage of retrieving textual descriptions of the graphs created along
the way, via the
[`VI()`](http://ajrgodfrey.github.io/BrailleR/reference/VI.md) methods.

## Usage

``` r
UniDesc(Response = NULL, ResponseName = as.character(match.call()$Response), 
    Basic = TRUE, Graphs = TRUE, Normality = TRUE, Tests = TRUE, 
    Title = NULL, Filename = NULL, Folder = ResponseName, Process = TRUE,
VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
View = getOption("BrailleR.View"), PValDigits=getOption("BrailleR.PValDigits"))
```

## Arguments

- Response:

  The numeric vector to be analyzed. This must be specified as a
  variable that is directly available in the workspace, not as a
  data.frame\$variable construct.

- ResponseName:

  This is the same as Response but use quote marks around it. Exactly
  one of Response or ResponseName must be specified.

- Basic:

  logical, asking for basic numeric summary measures

- Graphs:

  logical, indicating if the graphs are to be created. These will be eps
  files suitable for insertion in LaTeX documents, pdf files for more
  general use, and SVG for easier use by blind users.

- Normality:

  logical, asking if the various normality tests offered in the nortest
  package should be used

- Tests:

  logical, should skewness and kurtosis tests be performed.

- Title:

  the title of the R markdown document being created. NULL leads to a
  default string being chosen.

- Filename:

  Specify the name of the R markdown and html files (without
  extensions).

- Folder:

  the folder where results and graph files will be saved.

- Process:

  logical, should the R markdown file be processed?

- VI:

  logical, should the VI method be used to give added text descriptions
  of graphs? This is most easily set via the package options.

- Latex:

  logical, Should the xtable package be used to convert the tabulated
  results into LaTeX tables? This is most easily set via the package
  options.

- View:

  logical, should the resulting HTML file be opened in a browser? This
  is most easily set via the package options.

- PValDigits:

  Integer. The number of decimal places to use for p values. This is
  most easily set via the package options.

## Value

Saves an R markdown file, (and then if `Process=TRUE`) an R script file,
and an html file (which may be opened automatically) in the current
working folder. Graphs are saved in png, eps, pdf, and SVG formats (if
requested) in (optionally) a subfolder of the current working directory.

## Author

A. Jonathan R. Godfrey <a.j.godfrey@massey.ac.nz>

## Examples

``` r
if(require(nortest)){ # used in the Rmd file, not the UniDesc function
DIR = getwd()
setwd(tempdir())
Ozone=airquality$Ozone
UniDesc(Ozone)
rm(Ozone)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
setwd(DIR)
}
#> Error in eval(parse_only(code), envir = envir): object 'Ozone.count' not found
#> 
#> Quitting from Ozone-UniDesc.Rmd:35-35
```
