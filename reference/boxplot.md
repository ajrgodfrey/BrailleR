# Create a standard boxplot with a few extra elements added to the output object

This function is a wrapper to the standard `boxplot()` function in the
graphics package. It adds detail to the stored object so that a better
text description can be formulated using the
[`VI()`](http://ajrgodfrey.github.io/BrailleR/reference/VI.md) method in
the BrailleR package.

## Usage

``` r
boxplot(x, ...)
```

## Arguments

- x:

  a numeric variable.

- ...:

  additional arguments passed on to the plotting function.

## Details

This function masks the function of the same name in the graphics
package. The base R implementation does create an object, but does not
give it a class attribute, the object does not store all graphical
arguments that are passed to the `boxplot()` function. The functionality
should be no different at all for anyone who is not using the
[`VI()`](http://ajrgodfrey.github.io/BrailleR/reference/VI.md) function
to gain a more detailed text description of the boxplot. See the help
page for the
[`graphics::boxplot()`](https://rdrr.io/r/graphics/boxplot.html)
function to get a more complete description of boxplot creation.

## Value

An object of class boxplot. This class is just a placeholder for the
contents of the object used to create a boxplot which would otherwise
not be stored in a usable format. The class is not intended for the
user; it is a tool that enables the BrailleR package to deliver a
readable text version of the plot.

## References

The problem of not including class attributes for graphs was identified
in: Godfrey, A.J.R. (2013) ‘Statistical Software from a Blind Person's
Perspective: R is the Best, but we can make it better’, The R Journal
5(1), pp73-79.

## Author

A. Jonathan R. Godfrey

## Note

I would love to see this function become redundant. This will happen if
the extra functionality is included in the `boxplot()` function in the
graphics package. This should be possible as the user experience will
not be any different, no matter if the user is blind or sighted.

## See also

The base R implementation of the
[`boxplot`](https://rdrr.io/r/graphics/boxplot.html) function should be
consulted; see the entry in the
[graphics](https://rdrr.io/r/graphics/graphics-package.html) package

## Examples

``` r
x=rnorm(1000)
op = par(mfcol=c(2,1))
# the stamdard boxplot function returns
MyBoxplot=graphics::boxplot(x, main="Example boxplot (graphics package)", horizontal=TRUE)
MyBoxplot
#> $stats
#>              [,1]
#> [1,] -2.419820346
#> [2,] -0.644741797
#> [3,] -0.002118877
#> [4,]  0.597188875
#> [5,]  2.446781428
#> 
#> $n
#> [1] 1000
#> 
#> $conf
#>             [,1]
#> [1,] -0.06417069
#> [2,]  0.05993293
#> 
#> $out
#>  [1]  2.595524  2.556924  3.586945  3.037581  2.468741 -2.626042 -2.904221
#>  [8] -2.778434 -2.786975  2.506002
#> 
#> $group
#>  [1] 1 1 1 1 1 1 1 1 1 1
#> 
#> $names
#> [1] ""
#> 

# while this version returns
MyBoxplot=boxplot(x, main="Example boxplot (BrailleR package)", horizontal=TRUE)

MyBoxplot
#> $stats
#>              [,1]
#> [1,] -2.419820346
#> [2,] -0.644741797
#> [3,] -0.002118877
#> [4,]  0.597188875
#> [5,]  2.446781428
#> 
#> $n
#> [1] 1000
#> 
#> $conf
#>             [,1]
#> [1,] -0.06417069
#> [2,]  0.05993293
#> 
#> $out
#>  [1]  2.595524  2.556924  3.586945  3.037581  2.468741 -2.626042 -2.904221
#>  [8] -2.778434 -2.786975  2.506002
#> 
#> $group
#>  [1] 1 1 1 1 1 1 1 1 1 1
#> 
#> $names
#> [1] ""
#> 
#> $main
#> [1] "Example boxplot (BrailleR package)"
#> 
#> $horizontal
#> [1] TRUE
#> 
#> $call
#> graphics::boxplot(x, main = "Example boxplot (BrailleR package)", 
#>     horizontal = TRUE)
#> 
#> $par
#> $par$xaxp
#> [1] -3  3  6
#> 
#> $par$yaxp
#> [1] 0.6 1.4 4.0
#> 
#> 
#> $xTicks
#> [1] -3 -2 -1  0  1  2  3
#> 
#> $yTicks
#> [1] 0.6 0.8 1.0 1.2 1.4
#> 
#> $ExtraArgs
#> $ExtraArgs$main
#> [1] ""
#> 
#> $ExtraArgs$sub
#> [1] ""
#> 
#> $ExtraArgs$xlab
#> [1] ""
#> 
#> $ExtraArgs$ylab
#> [1] ""
#> 
#> 
#> $NBox
#> [1] 1
#> 
#> $VarGroup
#> [1] "variable"
#> 
#> $VarGroupUpp
#> [1] "This variable"
#> 
#> $IsAre
#> [1] "is"
#> 
#> $Boxplots
#> [1] "a boxplot"
#> 
#> $VertHorz
#> [1] "horizontally"
#> 
#> attr(,"class")
#> [1] "Augmented" "boxplot"  
par(op)

# The VI() method then uses the extra information stored
VI(MyBoxplot)
#> This graph has a boxplot printed horizontally
#> With the title: Example boxplot (BrailleR package)
#> "" appears on the x-axis.
#> "" appears on the y-axis.
#> Tick marks for the x-axis are at: -3, -2, -1, 0, 1, 2, and 3 
#> This variable  has 1000 values.
#> An outlier is marked at: 2.595524 2.556924 3.586945 3.037581 2.468741 -2.626042 -2.904221 -2.778434 -2.786975 2.506002 
#> The whiskers extend to -2.41982 and 2.446781 from the ends of the box, 
#> which are at -0.6447418 and 0.5971889 
#> The median, -0.002118877 is 52 % from the left end of the box to the right end.
#> The right whisker is 1.04 times the length of the left whisker.
#> 
```
