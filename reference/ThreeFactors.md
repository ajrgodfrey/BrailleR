# A convenience function for a Three-way analysis

Prepares an analysis of a data set with one response and three
predictors that are all factors. Interactions between the Three factors
are also allowed for. The function creates a number of graphs and tables
relevant for the analysis.

## Usage

``` r
ThreeFactors(Response, Factor1, Factor2, Factor3, Data = NULL, Filename = NULL, 
    Folder = NULL, VI = getOption("BrailleR.VI"), Latex = getOption("BrailleR.Latex"), 
    View = getOption("BrailleR.View"), Modern=TRUE)
```

## Arguments

- Response:

  Name of the continuous response variable.

- Factor1, Factor2, Factor3:

  Name the three factors to be included.

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

A. Jonathan R. Godfrey and Timothy P. Bilton

## See also

The
[`OneFactor`](http://ajrgodfrey.github.io/BrailleR/reference/OneFactor.md)
script was the basis for this function;.

## Examples

``` r
DIR = getwd()
setwd(tempdir())
TestData=data.frame(Resp=sample(54), expand.grid(F1=c("a","b","c"), 
    F2=c("d","e","f"), F3=c("g","h","i"), rep=c(1,2)))
attach(TestData)
ThreeFactors(Resp,F1,F2,F3)
#> Warning: This function is meant for use in interactive mode only.
detach(TestData)
rm(TestData)
# N.B. Various files and a folder were created in a temporary directory. 
# Please investigate them to see how this function worked.
setwd(DIR)
```
