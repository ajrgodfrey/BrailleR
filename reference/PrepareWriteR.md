# Getting started with WriteR

The WriteR application was written in wxPython so that blind users can
process Rmarkdown documents. This functionality is offered because
RStudio is not an accessible application for screen reader users.

## Usage

``` r
WriteR(file = NULL, math = c("webTeX", "MathJax"))

TestPython()
TestWX()

PrepareWriteR(Author = getOption("BrailleR.Author"))
```

## Arguments

- Author:

  Your name as you want it to appear in the default text that starts
  your R markdown documents.

- file:

  The filename you want started. Not implemented yet.

- math:

  The style for mathematical content in HTML documents created using
  LaTeX input. Not yet implemented.

## Details

WriteR needs python and wxPython to run. Error handling for users
without these packages installed is not yet incorporated in these
functions. Please use `TestWX()` because it calls `TestPython()` as its
first test.

The `PrepareWriteR()` function writes the settings file (called
WriteROptions) for WriteR and copies the files that were part of the
BrailleR installation into the current working directory. You will be
able to run the WriteR application from there, or move to a folder of
your choosing.

## Value

NULL. The `WriteR` function is for your convenience and not for doing
any work inside an R session. The `TestWX()` function prints results but
returns nothing. The `TestPython()` function returns a logical to say
Python can be seen by your system.

## Author

A. Jonathan R. Godfrey

## Note

You must have Python and the associated wxPython installation on your
system to use the WriteR application.
