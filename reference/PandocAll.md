# Convert files using pandoc.

Convert all files in the current working directory of one type into
another type using Pandoc.

## Usage

``` r
PandocAll(intype = "docx", outtype = "html")
```

## Arguments

- intype,outtype:

  File formats denoted using the standard extensions.

## Details

This will over-write existing files. It was intended to take MS Word
files and convert to HTML, but other conversions are possible. See the
pandoc documentation for full details.

## Value

Files will be created in the current working directory. CRAN policy says
you must have been informed that this is happening. This help file is
your warning.

## References

Extensive guidance on using pandoc is available

## Author

A. Jonathan R. Godfrey
