# Create a standard histogram with a few extra elements added to the output object

This function is a wrapper to the standard `hist()` function in the
graphics package. It adds detail to the stored object so that a better
text description can be formulated using the
[`VI()`](http://ajrgodfrey.github.io/BrailleR/reference/VI.md) method in
the BrailleR package.

## Usage

``` r
hist(x, ...)
```

## Arguments

- x:

  a numeric variable.

- ...:

  additional arguments passed on to the plotting function.

## Details

This function masks the function of the same name in the graphics
package. Even though the base R implementation does create an object of
class histogram, the object does not store all graphical arguments that
are passed to the `hist()` function. The functionality should be no
different at all for anyone who is not using the
[`VI()`](http://ajrgodfrey.github.io/BrailleR/reference/VI.md) function
to gain a more detailed text description of the histogram. See the help
page for the graphics::hist() function to get a more complete
description of histogram creation.

## Value

An object of class histogram as per the `hist()` function from the
graphics package, with the addition of any calls to the main title or
axis labels.

## References

Godfrey, A.J.R. (2013) ‘Statistical Software from a Blind Person's
Perspective: R is the Best, but we can make it better’, The R Journal
5(1), pp73-79.

## Author

A. Jonathan R. Godfrey

## See also

The base R implementation of the
[`hist`](https://rdrr.io/r/graphics/hist.html) function should be
consulted, using the entry in the
[graphics](https://rdrr.io/r/graphics/graphics-package.html) package

## Examples

``` r
x=rnorm(1000)
# the stamdard hist function returns
MyHist=graphics::hist(x, xlab="random normal values", main="Example histogram (graphics package)")

MyHist
#> $breaks
#>  [1] -4.0 -3.5 -3.0 -2.5 -2.0 -1.5 -1.0 -0.5  0.0  0.5  1.0  1.5  2.0  2.5  3.0
#> [16]  3.5  4.0
#> 
#> $counts
#>  [1]   1   1   3  12  44  87 169 204 176 142  94  46  13   5   2   1
#> 
#> $density
#>  [1] 0.002 0.002 0.006 0.024 0.088 0.174 0.338 0.408 0.352 0.284 0.188 0.092
#> [13] 0.026 0.010 0.004 0.002
#> 
#> $mids
#>  [1] -3.75 -3.25 -2.75 -2.25 -1.75 -1.25 -0.75 -0.25  0.25  0.75  1.25  1.75
#> [13]  2.25  2.75  3.25  3.75
#> 
#> $xname
#> [1] "x"
#> 
#> $equidist
#> [1] TRUE
#> 
#> attr(,"class")
#> [1] "histogram"

# while this version returns
MyHist=hist(x, xlab="random normal values", main="Example histogram (BrailleR package)")

MyHist
#> $breaks
#>  [1] -4.0 -3.5 -3.0 -2.5 -2.0 -1.5 -1.0 -0.5  0.0  0.5  1.0  1.5  2.0  2.5  3.0
#> [16]  3.5  4.0
#> 
#> $counts
#>  [1]   1   1   3  12  44  87 169 204 176 142  94  46  13   5   2   1
#> 
#> $density
#>  [1] 0.002 0.002 0.006 0.024 0.088 0.174 0.338 0.408 0.352 0.284 0.188 0.092
#> [13] 0.026 0.010 0.004 0.002
#> 
#> $mids
#>  [1] -3.75 -3.25 -2.75 -2.25 -1.75 -1.25 -0.75 -0.25  0.25  0.75  1.25  1.75
#> [13]  2.25  2.75  3.25  3.75
#> 
#> $xname
#> [1] "x"
#> 
#> $equidist
#> [1] TRUE
#> 
#> $main
#> [1] "Example histogram (BrailleR package)"
#> 
#> $xlab
#> [1] "random normal values"
#> 
#> $ExtraArgs
#> $ExtraArgs$main
#> [1] "Histogram of x"
#> 
#> $ExtraArgs$xlab
#> [1] "x"
#> 
#> $ExtraArgs$ylab
#> [1] "Frequency"
#> 
#> $ExtraArgs$sub
#> [1] ""
#> 
#> 
#> $NBars
#> [1] 16
#> 
#> $par
#> $par$xaxp
#> [1] -4  4  4
#> 
#> $par$yaxp
#> [1]   0 200   4
#> 
#> 
#> $xTicks
#> [1] -4 -2  0  2  4
#> 
#> $yTicks
#> [1]   0  50 100 150 200
#> 
#> attr(,"class")
#> [1] "Augmented" "histogram"

# The VI() method then uses the extra information stored
VI(MyHist)
#> This is a histogram, with the title: with the title: Example histogram (BrailleR package)
#> "x" is marked on the x-axis.
#> Tick marks for the x-axis are at: -4, -2, 0, 2, and 4 
#> There are a total of 1000 elements for this variable.
#> Tick marks for the y-axis are at: 0, 50, 100, 150, and 200 
#> It has 16 bins with equal widths, starting at -4 and ending at 4 .
#> The mids and counts for the bins are:
#> mid = -3.75  count = 1 
#> mid = -3.25  count = 1 
#> mid = -2.75  count = 3 
#> mid = -2.25  count = 12 
#> mid = -1.75  count = 44 
#> mid = -1.25  count = 87 
#> mid = -0.75  count = 169 
#> mid = -0.25  count = 204 
#> mid = 0.25  count = 176 
#> mid = 0.75  count = 142 
#> mid = 1.25  count = 94 
#> mid = 1.75  count = 46 
#> mid = 2.25  count = 13 
#> mid = 2.75  count = 5 
#> mid = 3.25  count = 2 
#> mid = 3.75  count = 1
```
