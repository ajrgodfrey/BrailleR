# clean out unwanted white space from a csv file

A blind user may not see the white space characters surrounding text or
numbers in a csv file. These corrupt analyses and are annoying to fix.

## Usage

``` r
CleanCSV(file)
```

## Arguments

- file:

  A vector of files to be checked

## Value

NULL. This function only affects external files.

## Details

Spits out the csv file in clean form, as well as a back up copy of the
original file.

## Author

A. Jonathan R. Godfrey
