# Establish or open the BrailleR folder for the user

Creates a permanent folder called MyBrailleR if the user agrees. Windows
users can open this file easily using MyBrailleR().

## Usage

``` r
SetupBrailleR()

MyBrailleR()
```

## Value

The path to the folder is returned invisibly.

## Details

The user can establish a permanent MyBrailleR folder if the BrailleR
package is loaded in an interactive session. If only used in batch mode,
the user will only be able to use the default BrailleR settings.

## Author

A. Jonathan R. Godfrey with suggestions from Henrik Bengtsson and Brian
Ripley.
