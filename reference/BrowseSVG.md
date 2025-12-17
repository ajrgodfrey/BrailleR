# Merge svg and xml file in html file

Creates a single HTML file that embeds an SVG diagram and its XML
annotations. Then launches a browser tab to allow viewing and
interactive exploration of the SVG diagram.

## Usage

``` r
BrowseSVG(file="test", key=TRUE, footer = TRUE, view=interactive(), ggplot_object = NULL)
```

## Arguments

- file:

  the filename for the HTML file; this should correspond to basename of
  an existing SVG and its XML annotations

- key:

  include key for explorer's keyboard commands in webpage

- footer:

  Whether the footer should be showed at bottom of webpage

- view:

  launch in browser; this is the default when running in an interactive
  session

- ggplot_object:

  This is the plot that the svg and XML are based off. If it is included
  than there will be the VI and the Describe information in the webpage.

## Details

A HTML file is written in the current working directory. This HTML file
will have the embeded svg and xml files as well as the javascript
(diagcess) to help with the exploration of the graph. Note that it is
required that you already have a svg and xml file in the current
directory for it to work.

It is much easier however to just use the `MakeAccessibleSVG` function
directly which does it all for you

## Value

NULL. This function exists for its side effects only.

## Author

Volker Sorge and James A. Thompson

## See also

[`MakeAccessibleSVG`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)`, `[`SVGThis`](http://ajrgodfrey.github.io/BrailleR/reference/SVGThis.md)`, `[`AddXML`](http://ajrgodfrey.github.io/BrailleR/reference/AddXMLMethod.md)

## Examples

``` r
library(ggplot2)
simpleHist = data.frame(x=rnorm(1e2)) |>
  ggplot(aes(x=x)) +
    geom_histogram()
file = "histogram"
pdf(NULL)  # create non-displaying graphics device for SVGThis and AddXML
svgfile = SVGThis(simpleHist, paste0(file, ".svg"),createDevice=FALSE)
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
#> This is an untitled chart with no subtitle or caption.
#> It has x-axis '' with labels -2, 0 and 2.
#> It has y-axis '' with labels 0, 3, 6 and 9.
#> The chart is a bar chart with 30 vertical bars.
xmlfile = AddXML(simpleHist, paste0(file, ".xml")) 
dev.off()  # destroy graphics device, now that we're done with it
#> agg_record_1900067626 
#>                     2 

BrowseSVG(file)

#Cleaing up from BrowseSVG
unlink(paste0(file, ".svg"))
unlink(paste0(file, ".xml"))
unlink(paste0(file, ".html"))
```
