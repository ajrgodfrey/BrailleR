# Find/Replace text in a file

Simple wrapper functions to make it easier to replace the text in a
file, possibly due to spelling errors, but perhaps to replace default
text in a template file.

## Usage

``` r
FindReplace(file, find, replace)

Rnw2Rmd(file)

UseTemplate(file, find=NULL, replace=NULL)

UseTemplateList(newfile, fileList, find=NULL, replace=NULL)
```

## Arguments

- file,fileList:

  The external (text) file, template, or list of templates to be
  updated.

- newfile:

  the file to write output to

- find:

  The text to remove.

- replace:

  The text to insert.

## Value

FindReplace will replace the existing file with the updated version
while UseTemplate will return a character string which will usually be
pushed out to an R script or R markdown file.

## Details

The FindReplace function is purely intended for use on an external file
whereas UseTemplate is intended to take a template file from within the
BrailleR package and return the updated text to the calling environment.

Rnw2Rmd tries to replace Standard LaTeX commands and Sweave chunk
headers with R markdown ones. It is NOT comprehensive, but it does get a
long way towards a useful markdown file.

Obviously the specified file must exist for these functions to work.

## Author

A. Jonathan R. Godfrey

## Examples

``` r
UseTemplate("DTGroupSummary.R")
#> Warning: This function is meant for use in interactive mode only.
UseTemplate("DTGroupSummary.R", "DataName", "MyData")
#> Warning: This function is meant for use in interactive mode only.
```
