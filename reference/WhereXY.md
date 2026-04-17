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
#>      1  2 3 4 Sum
#> 4    5  1 1 0   7
#> 3    4 10 3 0  17
#> 2    8  7 4 0  19
#> 1    2  3 1 1   7
#> Sum 19 21 9 1  50
WhereXY(x,y, c(3,4))
#>      1  2 3 Sum
#> 4    6  1 0   7
#> 3    6 10 1  17
#> 2   11  8 0  19
#> 1    3  3 1   7
#> Sum 26 22 2  50
WhereXY(x,y, xDist="other")
#>      1  2  3  4 Sum
#> 4    3  4  3  3  13
#> 3    3  1  5  2  11
#> 2    6  3  3  1  13
#> 1    3  2  3  5  13
#> Sum 15 10 14 11  50
```
