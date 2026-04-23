# Summarise the display list for a graphics device

Base graphics are created using a series of calls to C routines. This
function gathers the names of these calls and the values of the
arguments as supplied. Names of the arguments are then added. The
display list must be retrieved before the graphics device is closed, but
this could be stored for later summarisation.

## Usage

``` r
# S3 method for class 'recordedplot'
summary(object, ...)
```

## Arguments

- object:

  the display list created by recordPlot().

- ...:

  necessary argument for the method; currently ignored

## Details

The outcome of this command must be further processed to give it
context.

## Value

A named list of named vectors. Names of list elements are the C function
calls used in plotting the graph on the graphics device; the names for
the vectors are dependent on which C functions are called, but are the
argument names as per the R function most closely associated with that C
call.

## Author

Deepayan Sarkar with minor edits from A. Jonathan R. Godfrey

## See also

to fix

## Examples

``` r
plot(x=c(1:20), y=runif(20))
abline(h=0.5)


p = recordPlot()
summary(p)
#> $C_plot_new
#> list()
#> 
#> $palette2
#> $palette2[[1]]
#> [1] -16777216  -9743393 -11546527  -1665246  -1711576  -4453427 -15677451
#> [8]  -6381922
#> 
#> 
#> $C_plot_window
#> $C_plot_window[[1]]
#> [1]  1 20
#> 
#> $C_plot_window[[2]]
#> [1] 0.1117447 0.8969387
#> 
#> $C_plot_window[[3]]
#> [1] ""
#> 
#> $C_plot_window[[4]]
#> [1] NA
#> 
#> 
#> $C_plotXY
#> $C_plotXY[[1]]
#> $C_plotXY[[1]]$x
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
#> 
#> $C_plotXY[[1]]$y
#>  [1] 0.1246747 0.4644884 0.1908919 0.1201033 0.4776687 0.2810508 0.2584534
#>  [8] 0.4954504 0.6054651 0.8077452 0.6367392 0.5699745 0.1117447 0.4894001
#> [15] 0.5326480 0.8969387 0.2131197 0.8281586 0.2793620 0.7644692
#> 
#> $C_plotXY[[1]]$xlab
#> [1] "c(1:20)"
#> 
#> $C_plotXY[[1]]$ylab
#> [1] "runif(20)"
#> 
#> 
#> $C_plotXY[[2]]
#> [1] "p"
#> 
#> $C_plotXY[[3]]
#> [1] 1
#> 
#> $C_plotXY[[4]]
#> [1] "solid"
#> 
#> $C_plotXY[[5]]
#> [1] "black"
#> 
#> $C_plotXY[[6]]
#> [1] NA
#> 
#> $C_plotXY[[7]]
#> [1] 1
#> 
#> $C_plotXY[[8]]
#> [1] 1
#> 
#> 
#> $C_axis
#> $C_axis[[1]]
#> [1] 1
#> 
#> $C_axis[[2]]
#> NULL
#> 
#> $C_axis[[3]]
#> NULL
#> 
#> $C_axis[[4]]
#> [1] TRUE
#> 
#> $C_axis[[5]]
#> [1] NA
#> 
#> $C_axis[[6]]
#> [1] NA
#> 
#> $C_axis[[7]]
#> [1] FALSE
#> 
#> $C_axis[[8]]
#> [1] NA
#> 
#> $C_axis[[9]]
#> [1] "solid"
#> 
#> $C_axis[[10]]
#> [1] 1
#> 
#> $C_axis[[11]]
#> [1] 1
#> 
#> $C_axis[[12]]
#> NULL
#> 
#> $C_axis[[13]]
#> NULL
#> 
#> $C_axis[[14]]
#> [1] NA
#> 
#> $C_axis[[15]]
#> [1] NA
#> 
#> $C_axis[[16]]
#> [1] NA
#> 
#> 
#> $C_axis
#> $C_axis[[1]]
#> [1] 2
#> 
#> $C_axis[[2]]
#> NULL
#> 
#> $C_axis[[3]]
#> NULL
#> 
#> $C_axis[[4]]
#> [1] TRUE
#> 
#> $C_axis[[5]]
#> [1] NA
#> 
#> $C_axis[[6]]
#> [1] NA
#> 
#> $C_axis[[7]]
#> [1] FALSE
#> 
#> $C_axis[[8]]
#> [1] NA
#> 
#> $C_axis[[9]]
#> [1] "solid"
#> 
#> $C_axis[[10]]
#> [1] 1
#> 
#> $C_axis[[11]]
#> [1] 1
#> 
#> $C_axis[[12]]
#> NULL
#> 
#> $C_axis[[13]]
#> NULL
#> 
#> $C_axis[[14]]
#> [1] NA
#> 
#> $C_axis[[15]]
#> [1] NA
#> 
#> $C_axis[[16]]
#> [1] NA
#> 
#> 
#> $C_box
#> $C_box$which
#> [1] 1
#> 
#> $C_box$lty
#> [1] "solid"
#> 
#> 
#> $C_title
#> $C_title[[1]]
#> NULL
#> 
#> $C_title[[2]]
#> NULL
#> 
#> $C_title[[3]]
#> [1] "c(1:20)"
#> 
#> $C_title[[4]]
#> [1] "runif(20)"
#> 
#> $C_title[[5]]
#> [1] NA
#> 
#> $C_title[[6]]
#> [1] FALSE
#> 
#> 
#> $C_abline
#> $C_abline[[1]]
#> NULL
#> 
#> $C_abline[[2]]
#> NULL
#> 
#> $C_abline[[3]]
#> [1] 0.5
#> 
#> $C_abline[[4]]
#> NULL
#> 
#> $C_abline[[5]]
#> [1] FALSE
#> 
#> $C_abline[[6]]
#> [1] "black"
#> 
#> $C_abline[[7]]
#> [1] "solid"
#> 
#> $C_abline[[8]]
#> [1] 1
#> 
#> 
rm(p)
```
