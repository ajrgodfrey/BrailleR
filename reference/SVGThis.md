# Save commonly used graphs as structured SVG files.

Converts a graph object (as long as it has a class assigned) to an SVG
file that can be viewed using a browser (not IE). At present, the SVG
needs manual editing using the Tiger Transformer software before viewing
in the Tiger Player.

## Usage

``` r
SVGThis(x, file = "test.svg", ...)
# S3 method for class 'ggplot'
SVGThis(x, file = "test.svg", createDevice = TRUE, ...)
```

## Arguments

- x:

  a graph object for which a method exists

- file:

  The SVG file to be created.

- createDevice:

  Whether this function should creates it own none displaying device and
  print the graph on it. If FALSE will print the graph on the current
  device.

- ...:

  Arguments to be passed to the methods.

## Details

Most of the work of the function is done
[`gridSVG::grid.export`](https://rdrr.io/pkg/gridSVG/man/grid.export.html)
function. After this there is a rewrite of the SVG so that it can work
better with the XML and create a easy accessible experience of the
graph.

The produced SVG can also be used as just that a SVG. However note that
quite possibly some rewriting will of been done. The rewriting does not
change how the graph looks.

To view your graph as a accessible svg you can use the
[`MakeAccessibleSVG()`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)
function.

The Cairo SVG device found in the gr.devices package does not create a
structured SVG file that includes the semantics of the graphic being
displayed. The SVG created by the gridSVG package does meet this need,
but only works on graphs drawn using the grid package. Any graph created
using functions from the more common graphics package can be converted
to the grid package system using the gridGraphics package.

## Value

NULL. This function is solely for the purpose of creating SVG files in
the current working directory or in a path of the user's choosing.

## References

P. Murrell and S. Potter (2014) “The gridSVG package” The R Journal 6/1,
pp. 133-143.
http://journal.r-project.org/archive/2014-1/RJournal_2014-1_murrell-potter.pdf

P. Murrell (2015) “The gridGraphics package”, The R Journal 7/1 pp.
151-162. http://journal.r-project.org/archive/2015-1/murrell.pdf

P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second
edition. W3C recommendation, W3C.
http://www.w3.org/TR/2011/REC-SVG11-20110816/

## Author

A. Jonathan R. Godfrey, Paul Murrell and James Thompson

## See also

[`MakeAccessibleSVG`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)

## Examples

``` r
# Save a custom ggplot object to an SVG file
library(ggplot2)
p = ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
SVGThis(p)
#> This is an untitled chart with no subtitle or caption.
#> It has x-axis '' with labels 2, 3, 4 and 5.
#> It has y-axis '' with labels 10, 15, 20, 25, 30 and 35.
#> The chart is a set of 32 big solid circle points of which about 100% can be seen.

# Cleaning up afterwards
unlink("test.svg")
```
