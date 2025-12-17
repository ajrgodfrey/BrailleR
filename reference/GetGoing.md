# Set options for using BrailleR

An interactive question-and-answer interface suitable for blind users
wanting to set the options for using the BrailleR package.

## Usage

``` r
GetGoing()
```

## Details

Defaults are offered for all questions so that pressing \<Enter\> means
no changes are made. Users answer yes/no questions as TRUE or FALSE
respectively; the short form T or F is also allowed.

The user can also choose to perform various setup tasks using this
interface.

## Value

NULL. This function is a tool for executing other functions that will
set options and setup the package according to the user's wants.

## Author

A. Jonathan R. Godfrey

## See also

All options being set through this function have specific functions that
achieve the same ends. For example, see
[`GoSighted`](http://ajrgodfrey.github.io/BrailleR/reference/Options.md)
for the options that are binary settings, or
[`SetAuthor`](http://ajrgodfrey.github.io/BrailleR/reference/SetOptions.md)
for options requiring a specific character or numeric value to be
chosen.

The setup functionality can be reviewed at
[`MakeBatch`](http://ajrgodfrey.github.io/BrailleR/reference/MakeBatch.md).
