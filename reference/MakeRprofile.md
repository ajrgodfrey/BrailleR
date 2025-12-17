# Load BrailleR on Startup in Current Working Directory

Writes the single command “library(BrailleR)” to a .First() function in
.Rprofile in the current working directory. This forces the BrailleR
package to be automatically loaded when R is opened in this working
directory.

## Usage

``` r
MakeRprofile(Overwrite = FALSE)
```

## Arguments

- Overwrite:

  Logical: Should an existing .Rprofile file be overwritten?

## Value

Nothing. This function is used for its side effect of creation of a file
in the current working directory. A warning message is created if the
file exists and Overwrite=FALSE.

## Author

A. Jonathan R. Godfrey.
