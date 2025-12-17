# extract the example text from a help page

A cut back version of example() for obtaining the text used in examples
on help pages without running those examples. The function is intended
to help write markdown/Sweave documents.

## Usage

``` r
GetExampleText(topic, package = NULL, lib.loc = NULL, character.only = FALSE, outFile="")
```

## Arguments

- topic:

  name or literal character string: the online help topic the examples
  of which should be run.

- package:

  a character vector giving the package names to look into for the
  topic, or NULL (the default), when all packages on the search path are
  used.

- lib.loc:

  a character vector of directory names of R libraries, or NULL. The
  default value of NULL corresponds to all libraries currently known. If
  the default is used, the loaded packages are searched before the
  libraries.

- character.only:

  a logical indicating whether topic can be assumed to be a character
  string.

- outFile:

  an optional filename to save the results into. The default is to use a
  temporary file.

## Details

The example() code was hacked back to form this utility function. It is
probably a little heavy for what is needed but it works sufficiently at
the time of creation.

## Value

a vector of character strings each element being one line of the
examples from the corresponding help topic.

## Author

The work of Martin Maechler and others got tampered with by A. Jonathan
R. Godfrey

## See also

You may wish to compare this with
[`example`](https://rdrr.io/r/utils/example.html)

## Examples

``` r
cat(paste(GetExampleText(mean), collapse="\n"))
#> 
#> x <- c(0:10, 50)
#> xm <- mean(x)
#> c(xm, mean(x, trim = 0.10))
#> 
#> 
```
