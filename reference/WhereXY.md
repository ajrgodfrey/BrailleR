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
#> 4    2  4 1 0   7
#> 3    6  4 5 0  15
#> 2    8  7 1 0  16
#> 1    2  6 2 2  12
#> Sum 18 21 9 2  50
WhereXY(x,y, c(3,4))
#>      1  2 3 Sum
#> 4    5  2 0   7
#> 3    7  7 1  15
#> 2   10  6 0  16
#> 1    4  5 3  12
#> Sum 26 20 4  50
WhereXY(x,y, xDist="other")
#>      1  2  3  4 Sum
#> 4    4  4  2  3  13
#> 3    7  3  3  4  17
#> 2    1  2  4  0   7
#> 1    2  4  3  4  13
#> Sum 14 13 12 11  50
```
