# Work flow convenience functions

Time-saving functions that help create files in more useful formats for
later use.

## Usage

``` r
History2Rmd(file = "History.Rmd")
History2Qmd(file = "History.Qmd")

R2Rmd(ScriptFile)
R2Qmd(ScriptFile)

ProcessAllMd(dir =".")
ProcessAllRmd(dir =".", method = "render")

RemoveBOM(file)
```

## Arguments

- dir:

  The directory to find files.

- file:

  the name of the file to be created or modified.

- method:

  The method used to process Rmd files; one of "render" or "knit2html".

- ScriptFile:

  the R script to be processed into the R markdown file.

## Details

The History2Rmd() function was intended for turning a short interactive
R session into an R markdown file. Lines of code are all separated into
distinct code chunks in the Rmd file. the resulting file will need to be
edited if commands have spanned more than one line.

The R2Rmd() function does try to limit the number of blank lines copied
from the R script into the Rmarkdown file. The Rmd file may need some
editing.

Once all Rmd files have been edited, the user can have all the Rmd files
in a folder processed using ProcessAllRmd(). A similar function
ProcessAllMd() exists to process any plain markdown files which do not
need knitting.

## Value

NULL. These functions are for creating files in the current working
directory.

## Author

A. Jonathan R. Godfrey

## See also

These functions were inspired by the
[`spin`](https://rdrr.io/pkg/knitr/man/spin.html) functionality of the
knitr package. You may wish to move onto using it for more features.
