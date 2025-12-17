# Analysis for a continuous response for one group factor

A convenience function that creates an analysis for a continuous
response variable with one grouping factor. The function creates a
number of graphs and tables relevant for the analysis.

## Usage

``` r
OneFactor(Response, Factor, Data = NULL, HSD = TRUE, AlphaE = 0.05, 
Filename = NULL, Folder = NULL, 
VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
View = getOption("BrailleR.View"), Modern=TRUE)
```

## Arguments

- Response:

  Name of the continuous response variable.

- Factor:

  The grouping factor.

- Data:

  The data.frame that contains both the response and the factor.

- HSD:

  Logical: Should Tukey's HSD be evaluated for the data?

- AlphaE:

  The family-wise Type I error rate for Tukey's HSD calculations.

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
eps, pdf and svg formats. Tabulated results are stored in files suitable
for importing into LaTeX documents.

## Value

This function is used for creation of the files saved in the working
directory and a few of its subdirectories.

## Author

A. Jonathan R. Godfrey and Timothy P. Bilton

## See also

Other convenience functions can be investigated via their help pages.
See
[`UniDesc`](http://ajrgodfrey.github.io/BrailleR/reference/UniDesc.md),
[`OnePredictor`](http://ajrgodfrey.github.io/BrailleR/reference/OnePredictor.md),
and
[`TwoFactors`](http://ajrgodfrey.github.io/BrailleR/reference/TwoFactors.md)

## Examples

``` r
DIR = getwd()
setwd(tempdir())
data(airquality)
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
library(knitr)
# the following line  returns an error:
## OneFactor("Ozone", "Month", airquality, View=FALSE)
# so we make a copy of the data.frame, and fix that:
airquality2 = airquality |> mutate(Month = as.factor(Month))
# and now all is good to try:
OneFactor("Ozone", "Month", airquality2)
#> Error in get(DataName): object 'airquality2' not found
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
setwd(DIR)
```
