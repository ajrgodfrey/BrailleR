# Create XML files to sit alongside SVG files in order to make an accessible graph experience.

Creates the necessary XML file for a graph object (as long as it has a
class assigned)

## Usage

``` r
AddXML(x, file)
```

## Arguments

- x:

  a graph object for which a method exists

- file:

  The XML file to be created.

## Details

It will create a xml file which has useful information for creating a
accessible svg graph experience. However for it to work properly the
`SVGThis` and `BrowseSVG` function must also be used. As can be seen in
the examples it takes a bit of verbose code to use this function. To
create easy exploration webpages of a graph use `MakeAccessibleSVG`.

## Value

NULL. This function is solely for the purpose of creating XML files in
the current working directory or in a path of the user's choosing.

## References

P. Dengler et al. (2011) Scalable vector graphics (SVG) 1.1, second
edition. W3C recommendation, W3C.
http://www.w3.org/TR/2011/REC-XML11-20110816/

## Author

Volker Sorge, A. Jonathan R. Godfrey and James Thompson

## See also

[`MakeAccessibleSVG`](http://ajrgodfrey.github.io/BrailleR/reference/MakeAccessibleSVGMethod.md)

## Examples

``` r
library(ggplot2)
library(grid)

# Create a simple histogram plot
simpleHist = data.frame(x=rnorm(1e2)) |>
  ggplot(aes(x=x)) +
  geom_histogram()

# Open a new PDF device, but
#discard the output instead of saving it to a file
pdf(NULL)

# Plot the ggplot object on the current device
simpleHist
#> `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
#> This is an untitled chart with no subtitle or caption.
#> It has x-axis '' with labels -2, -1, 0, 1, 2 and 3.
#> It has y-axis '' with labels 0.0, 2.5, 5.0, 7.5, 10.0 and 12.5.
#> The chart is a bar chart with 30 vertical bars.

# Force the plot to be drawn on the device,
#even though the output is being discarded
grid.force()

# Export the plot to an XML file
AddXML(simpleHist, file = "histogram.xml")

# Close the current PDF graphic device
dev.off()
#> agg_record_346871191 
#>                    2 

#Cleaning up afterwards
unlink("histogram.xml")
```
