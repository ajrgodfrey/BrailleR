# Open a data object in your chosen spreadsheet software

The chosen data object (data.frame, matrix, or vector) is stored in a
temporary csv file. The file is opened while the R terminal/console is
suspended until the \<enter\> key is pressed. This should be done once
the spreadsheet software has been closed so that the temporary file is
removed and the data object gets updated from the edited csv file. The
user must save the csv file if changes are made.

## Usage

``` r
DataViewer(x, Update = FALSE, New = NULL, Filename = NULL)
```

## Arguments

- x:

  an object of class data.frame, matrix, or vector. A check is made for
  this condition.

- Update:

  Logical. Will changes made in the spreadsheet editor be returned to
  the R session.

- New:

  If Update=TRUE, the original object will be replaced unless a name for
  a new object is given. N.B. the default is to overwrite the original
  object.

- Filename:

  Provide a filename if desired. N.B. this does not guarantee that the
  csv file will be kept. Do not use this function as a shortcut for
  saving csv files.

## Details

The following steps should be taken if the intention is to view and
possibly edit a data.frame, matrix, or vector:

There are a few quirks with respect to variables that could be
interpreted as factors. The process of updating is to write a csv file
using code [write.csv](https://rdrr.io/r/utils/write.table.html)() and
then read it back using code
[read.csv](https://rdrr.io/r/utils/read.table.html)() after it has been
edited. Users must be aware that factors may not register as such, or
that character vectors may be interpreted as factors.

## Value

If code Update=TRUE and code New=NULL, the original data object is
overwritten. To create a new object the user must specify code New.

## Author

A. Jonathan R. Godfrey <a.j.godfrey@massey.ac.nz>

## Examples

``` r
# \donttest{
data(airquality)
DataViewer(airquality, Update=TRUE, New="NewAirQuality")
#> Warning: This function is meant for use in interactive mode only.
# }
```
