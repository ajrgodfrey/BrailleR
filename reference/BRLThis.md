# Convert a graph to a pdf ready for embossing

DEPRECATED. Do not use this function. The first argument to this
function must be a call to create a graph, such as a histogram. Instead
of opening a new graphics device, the graph will be created in a pdf
file, with all text being presented using a braille font. The function
is somewhat experimental as the best braille font is not yet confirmed,
and a number of examples need to be tested on a variety of embossers
before full confidence in the function is given.

## Usage

``` r
BRLThis(x, file)
```

## Arguments

- x:

  the call to create a graph

- file:

  A character string giving the filename where the image is to be saved.

## Value

Nothing within the R session, but a pdf file will be created in the
user's working directory.

## Details

The user's chosen braille font must be installed. This might include the
default font shipped as part of the package.

## Author

A. Jonathan R. Godfrey. with contributions from JooYoung Seo and TK Lee.
