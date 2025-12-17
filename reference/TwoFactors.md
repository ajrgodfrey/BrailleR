# A convenience function for a two-way analysis

Prepares an analysis of a data set with one response and two predictors
that are both factors. An interaction between the two factors is also
allowed for. The function creates a number of graphs and tables relevant
for the analysis.

## Usage

``` r
TwoFactors(Response, Factor1, Factor2, Inter = FALSE, HSD = TRUE, 
   AlphaE = getOption("BrailleR.SigLevel"), Data = NULL, Filename = NULL, 
    Folder = NULL, VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
    View = getOption("BrailleR.View"), Modern=TRUE)
```

## Arguments

- Response:

  Name of the continuous response variable.

- Factor1, Factor2:

  Name the two factors to be included.

- Inter:

  Logical: Should the interaction of the two factors be included?

- HSD:

  Logical: Should Tukey's HSD be evaluated for the data?

- AlphaE:

  The family-wise Type I error rate for Tukey's HSD calculations.

- Data:

  Name the data.frame that includes the three variables of interest.

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

to complete

## Value

This function is used for creation of the files saved in the working
directory and a few of its subdirectories.

## Author

Timothy P. Bilton and A. Jonathan R. Godfrey

## See also

The
[`OneFactor`](http://ajrgodfrey.github.io/BrailleR/reference/OneFactor.md)
script was the basis for this function;.

## Examples

``` r
DIR = getwd()
setwd(tempdir())
if(require(dplyr)){
TG <- ToothGrowth |> mutate(dose = as.factor(dose))

# Without interaction
TwoFactors('len','supp','dose',Data=TG, Inter=FALSE)

# With two-way interaction
TwoFactors('len', 'supp', 'dose', Data=TG, Inter=TRUE)

rm(TG); rm(TG)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
}
#> Warning: This function is meant for use in interactive mode only.
#> Warning: This function is meant for use in interactive mode only.
#> Warning: object 'TG' not found
setwd(DIR)
```
