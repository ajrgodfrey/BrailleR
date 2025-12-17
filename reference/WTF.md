# What's this figure?

Determine what the current graphics device has on it so the blind user
can be sure they have something they want, or find out what it might be
that is contained in a graphics device.

## Usage

``` r
WTF()
wtf()
```

## Author

A. Jonathan R. Godfrey and Paul Murrell.

## Value

Text describing what BrailleR was able to detect in the graphics window.

## Examples

``` r
attach(airquality)
hist(Ozone)

WTF()

#> This graph has the main title "Histogram of Ozone";  and o subtitle;
#> "Ozone" as the x axis label;
#> "Frequency" as the y axis label;
#> There are no points marked on the graph.
plot(Ozone~Wind)

WTF()
#> This graph has the main title "Histogram of Ozone";  and o subtitle;
#> "Ozone" as the x axis label;
#> "Frequency" as the y axis label;
#> There are no points marked on the graph.
detach(airquality)
```
