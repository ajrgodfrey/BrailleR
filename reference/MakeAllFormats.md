# Prepare the options for conversion of an R markdown file.

Make a pandoc options file for use with a named R markdown file.

## Usage

``` r
MakeAllFormats(RmdFile, BibFile = "")
```

## Arguments

- RmdFile:

  The name of the R markdown file to be converted.

- BibFile:

  Name of the bibtex database file to include.

## Value

Nothing in the R console/terminal. The function is used for its side
effects in the working directory.

## Details

The options are based on the current best set of possible outcomes. The
two html file options use different representations of any mathematical
equations. The Microsoft Word file uses the native equation format which
is not accessible for blind people using screen readers.

## Author

A. Jonathan R. Godfrey.
