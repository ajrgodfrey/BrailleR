# Count points in a scatter plot

count the number of points that fall into various sized subparts of a
scatter plot. The graphing region can be split into cells based on a
uniform or normal marginal distribution separately for the x and y
variables.

## Usage

``` r
WhereXY(x, y = NULL, grid = c(4, 4), xDist = "uniform", 
       yDist = xDist, addmargins=TRUE)
```

## Arguments

- x,y:

  vectors of x coordinates. If y is not specified, the function expects
  x to be a two-column matrix with x and y values in columns 1 and 2
  respectively.

- grid:

  pair of values to specify the way the graph is to be split into parts.
  Specify x and then y.

- xDist,yDist:

  the distribution the variables might be expected to follow. The
  default is to consider uniformly distributed but any alternative text
  will lead to an assumption of both margins being normally distributed.

- addmargins:

  logical: should sums be added to both rows and columns.

## Value

A text description of the number of points in each subregion of the
scatter plot. The table of counts can then be compared to the expected
number of points in each subregion.

## Author

A. Jonathan R. Godfrey

## Examples

``` r
x=rnorm(50)
y=rnorm(50)
WhereXY(x,y)
#>     1  2  3  4 Sum
#> 4   1  0  0  0   1
#> 3   1  4  3  1   9
#> 2   0  5  9  5  19
#> 1   0  7  7  7  21
#> Sum 2 16 19 13  50
WhereXY(x,y, c(3,4))
#>     1  2  3 Sum
#> 4   1  0  0   1
#> 3   1  5  3   9
#> 2   3  8  8  19
#> 1   1 11  9  21
#> Sum 6 24 20  50
WhereXY(x,y, xDist="other")
#>      1  2  3  4 Sum
#> 4    3  3  2  4  12
#> 3    5  4  3  2  14
#> 2    1  3  2  3   9
#> 1    5  2  3  5  15
#> Sum 14 12 10 14  50
```
