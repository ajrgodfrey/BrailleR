# Sort VI.ggplot points list

Allows the list of data points listed by VI.ggplot to be sorted by x or
y values, ascending or descending. Currently only implemented for
geom_points. This function is experimental and has not been extensively
tested.

## Usage

``` r
# S3 method for class 'VIgraph'
sort(x, decreasing = FALSE, by = "x", ...)
```

## Arguments

- x:

  object returned by `VI.ggplot`

- decreasing:

  logical: should the sort be decreasing

- by:

  value on which to sort, "x" or "y"

- ...:

  further arguments passed to
  [`base::sort`](https://rdrr.io/r/base/sort.html)

## Value

Returns a new object of the same type as that returned by VI.ggplot, but
with data re-ordered.

## Author

Debra Warren and Paul Murrell

## Examples

``` r
if (require(ggplot2)) {
    sort(VI(qplot(x=1:5, y=c(2,5,1,4,3))), decreasing=TRUE, by="y")
}
#> This is an untitled chart with no subtitle or caption.
#> It has x-axis '1:5' with labels 1, 2, 3, 4 and 5.
#> It has y-axis 'c(2, 5, 1, 4, 3)' with labels 1, 2, 3, 4 and 5.
#> The chart is a set of 5 big solid circle points of which about 100% can be seen.
#> The points are at:
#> (2, 5), 
#> (4, 4), 
#> (5, 3), 
#> (1, 2) and 
#> (3, 1)
```
