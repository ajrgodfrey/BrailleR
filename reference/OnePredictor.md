# Exploration of the relationship between a response and a single predictor

A convenience function for generating exploratory graphs and numeric
summaries, regression analysis output, and the residual analysis of the
simple linear model.

## Usage

``` r
OnePredictor(Response, Predictor, Data = NULL, 
    Filename = NULL, Folder = NULL, 
    VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
   View = getOption("BrailleR.View"), Modern=TRUE)
```

## Arguments

- Response:

  Name of the continuous response variable.

- Predictor:

  Name of the continuous response variable.

- Data:

  The data.frame that contains both the response and the factor.

- Filename:

  Name of the Rmarkdown and HTML files to be created. A default will be
  created that uses the names of the variables if this is left set to
  NULL.

- Folder:

  Name of the folder to store graph and LaTeX files. A default will be
  created based on the name of the data.frame being used.

- VI:

  Logical: Should the VI method for blind users be employed?

- Latex:

  Logical: Should the tabulated sections be saved in LaTeX format?

- View:

  Logical: Should the HTML file be opened for inspection?

- Modern:

  Logical: Should the graphics be created using ggplot?

## Details

This function writes an R markdown file that is knitted into HTML and
purled into an R script. All graphs are saved in subdirectories in png,
eps, pdf and svg formats. Tabulated results can be stored in files
suitable for importing into LaTeX documents.

## Value

This function is used for creation of the files saved in the working
directory and a few of its subdirectories.

## Author

A. Jonathan R. Godfrey and Timothy P. Bilton

## See also

Other convenience functions can be investigated via their help pages.
See
[`UniDesc`](http://ajrgodfrey.github.io/BrailleR/reference/UniDesc.md),
[`OneFactor`](http://ajrgodfrey.github.io/BrailleR/reference/OneFactor.md),
and
[`TwoFactors`](http://ajrgodfrey.github.io/BrailleR/reference/TwoFactors.md)

## Examples

``` r
if(require(nortest)){ # used in a dependent function's Rmd file
library(knitr)
DIR = getwd()
setwd(tempdir())
data(airquality)
OnePredictor("Ozone", "Wind", airquality)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
setwd(DIR)
}
#> Loading required package: nortest
#> Warning: This function is meant for use in interactive mode only.
#> Warning: This function is meant for use in interactive mode only.
#> Warning: This function is meant for use in interactive mode only.
```
