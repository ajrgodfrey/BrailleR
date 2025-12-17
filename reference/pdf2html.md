# Convert a pdf file to html

A blind user often has difficulty reading the content provided in pdf
files. This tool is quite experimental at this stage.

## Usage

``` r
pdf2html(pdffile, htmlfile=sub(".pdf", ".html", pdffile), HeadingLevels=4, PageTag="h6")
```

## Arguments

- pdffile:

  A pdf file to be converted.

- htmlfile:

  The filename for the resulting html; default is to change the file
  extension.

- HeadingLevels:

  The depth of heading level to include; tags h1, h2, h3... are used.

- PageTag:

  Which tag to use for replacing page numbers; default is h6, but any
  tag could be used.

## Value

Logical: Has the conversion completed. Note that this does not mean the
result is totally useful as this will depend on the quality of the input
file.

## Details

A Python 2.7 module is the basis for the conversion. Some
post-processing can be done to further enhance the readability of the
resulting html file.

## Author

A. Jonathan R. Godfrey
