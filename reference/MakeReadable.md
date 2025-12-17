# Convert line breaks in vignette documentation

The Rnw files used for vignettes use Linux style line breaks that make
reading vignette source files difficult for Windows users. A Python
script is called which converts the line breaks and saves the vignette
source in the user's MyBrailleR folder.

## Usage

``` r
MakeReadable(pkg)
```

## Arguments

- pkg:

  The package to investigate for vignette source files.

## Value

Nothing in the workspace. All files are stored in a vignettes folder
within MyBrailleR.

## Details

Must have Python 3.8 installed for this function to work.

## Author

A. Jonathan R. Godfrey
