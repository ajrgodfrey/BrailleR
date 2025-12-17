# Investigate data objects

Investigate an object, especially useful at any stage in a pipe chain.

## Usage

``` r
CheckIt(x, ...)
check_it(x, ...)

what_is(x, ...)
WhatIs(x, ...)
```

## Arguments

- x:

  The object to be investigated and passed out again.

- ...:

  extra parameters to be passed on.

## Value

These functions intentionally return (invisibly of course) the original
input object so that they can be used within a pipe chain, as is
commonly used by the Tidyverse.

## Details

The VI() functionality returns a character vector and is not useful
inside a pipe chain. In effect, WhatIs() just adds the pipe chain
convenience to the VI() tool, while CheckIt() looks at the structure of
the data object. The latter is perhaps more useful if you are uncertain
that the pipe chain is delivering what you hoped for.

## Author

A. Jonathan R. Godfrey

## Examples

``` r
require(dplyr)
airquality %>% CheckIt() %>% arrange(Ozone) %>% head()
#> Rows: 153
#> Columns: 6
#> $ Ozone   <int> 41, 36, 12, 18, NA, 28, 23, 19, 8, NA, 7, 16, 11, 14, 18, 14, …
#> $ Solar.R <int> 190, 118, 149, 313, NA, NA, 299, 99, 19, 194, NA, 256, 290, 27…
#> $ Wind    <dbl> 7.4, 8.0, 12.6, 11.5, 14.3, 14.9, 8.6, 13.8, 20.1, 8.6, 6.9, 9…
#> $ Temp    <int> 67, 72, 74, 62, 56, 66, 65, 59, 61, 69, 74, 69, 66, 68, 58, 64…
#> $ Month   <int> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,…
#> $ Day     <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,…
#>   Ozone Solar.R Wind Temp Month Day
#> 1     1       8  9.7   59     5  21
#> 2     4      25  9.7   61     5  23
#> 3     6      78 18.4   57     5  18
#> 4     7      NA  6.9   74     5  11
#> 5     7      48 14.3   80     7  15
#> 6     7      49 10.3   69     9  24
```
